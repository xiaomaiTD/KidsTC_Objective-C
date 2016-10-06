//
//  ZPPhotoBrowerViewController.m
//  ZPPhotoBrower
//
//  Created by 詹平 on 16/4/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ZPPhotoBrowserViewController.h"
#import "AlbumCollectionViewCell.h"
#import "AlbumnModel.h"
#import "CommonShareObject.h"
#import "CommonShareViewController.h"
#import "ArticleCommentViewController.h"
#import "AlbumToolBarView.h"

#import "GHeader.h"

#define ToolBarViewHight 549

@interface ZPPhotoBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,AlbumToolBarViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) AlbumToolBarView *toolBarView;

@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) ADArticleContent *articleContent;
@end

@implementation ZPPhotoBrowserViewController
static NSString *const reuseIndentifier = @"AlbumCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    CGFloat screenW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenH = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    UICollectionViewFlowLayout *lo = [[UICollectionViewFlowLayout alloc]init];
    lo.itemSize = CGSizeMake(screenW, screenH);
    lo.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    lo.minimumLineSpacing = 0;
    lo.minimumInteritemSpacing = 0;
    
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH) collectionViewLayout:lo];
    cv.delegate = self;
    cv.dataSource = self;
    cv.pagingEnabled = YES;
    cv.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:cv];
    self.collectionView = cv;
    
    [cv registerNib:[UINib nibWithNibName:@"AlbumCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIndentifier];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    AlbumToolBarView *toolBarView = [[[NSBundle mainBundle] loadNibNamed:@"AlbumToolBarView" owner:self options:nil] lastObject];
    toolBarView.frame = CGRectMake(0, screenH-ToolBarViewHight, screenW, ToolBarViewHight);
    [self.view addSubview:toolBarView];
    toolBarView.delegate = self;
    self.toolBarView = toolBarView;
    
    
    [self getAlbumnRequest];
}

- (void)albumToolBarView:(AlbumToolBarView *)toolBarView didClickOnBtnType:(AlbumToolBarViewBtnType)btnType{
    switch (btnType) {
        case AlbumToolBarViewBtnType_like:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
              [self changeLikeState];
            }];
        }
            break;
        case AlbumToolBarViewBtnType_comment:
        {
            [self showArticleCommentList];
        }
            break;
    }
}

- (void) showArticleCommentList{
    
    ArticleCommentViewController *articleCommentViewController = [[ArticleCommentViewController alloc] init];
    articleCommentViewController.relationId = self.articleContent.sysNo;
    [self.navigationController pushViewController:articleCommentViewController animated:NO];
}

- (void)moreAction:(UIBarButtonItem *)barBtn{
    //ActionSheet *actionSheet = [[ActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享",@"首页",@"话题", nil];
    //[actionSheet show];
    
    CommonShareObject *shareObject = [CommonShareObject shareObjectWithTitle:self.articleContent.title description:self.articleContent.simply thumbImageUrl:[NSURL URLWithString:self.articleContent.thumbnail] urlString:self.articleContent.linkUrl];
    shareObject.identifier = self.articleId;
    shareObject.followingContent = @"【童成网】";
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:shareObject sourceType:KTCShareServiceTypeNews];
    
    [self presentViewController:controller animated:YES completion:nil];
}

//- (void)didClickActionSheet:(ActionSheet *__nullable)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"actionSheet---buttonIndex:%ld",buttonIndex);
//    [actionSheet hide];
//}


- (void)getAlbumnRequest {
    NSDictionary *param = @{@"articleId":self.articleId};
    [Request startWithName:@"GET_ARTICLE_DETAIL_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        
        AlbumnResponse *albumnResponse = [AlbumnResponse modelWithDictionary:dic];
        ARData *albumData = albumnResponse.data;
        
        ADContentsItem *contensItem = albumData.contents[0];
        self.imageList = contensItem.bigImagesList;
        self.articleContent = albumData.articleContent;
        self.toolBarView.articleContent = self.articleContent;
        self.navigationItem.title = self.articleContent.title;
        
        [self.collectionView reloadData];
        [self scrollViewDidScroll:self.collectionView];
    } failure:nil];
}


- (void)changeLikeState{
    NSString *isLike = self.articleContent.isLike?@"0":@"1";
    NSDictionary *param = @{@"relationSysNo":[NSString stringWithFormat:@"%@",self.articleId],
                                 @"likeType":@"2",
                                 @"isLike":isLike};
    [Request startWithName:@"USER_LIKE_COLUMN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        self.articleContent.isLike = !self.articleContent.isLike;
        if (self.articleContent.isLike) {
            self.articleContent.likeCount++;
        }else{
            self.articleContent.likeCount--;
        }
        self.toolBarView.articleContent = self.articleContent;
    } failure:nil];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    ACBigImagesListItem *imageListItem = self.imageList[indexPath.row];
    cell.imageUrl = imageListItem.imgUrl;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ((int)scrollView.contentOffset.x%(int)scrollView.bounds.size.width == 0) {
        NSUInteger index = (int)scrollView.contentOffset.x/(int)scrollView.bounds.size.width;
        ACBigImagesListItem *imageListItem = self.imageList[index];
        self.toolBarView.content = imageListItem.attributeContent;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //[self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    //[[UIApplication sharedApplication] setStatusBarHidden:![UIApplication sharedApplication].statusBarHidden withAnimation:YES];
}


@end
