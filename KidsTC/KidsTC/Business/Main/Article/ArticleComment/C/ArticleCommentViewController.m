//
//  ArticleCommentViewController.m
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCommentViewController.h"
#import "ArticleCommentModel.h"
#import "ArticleCommentLayout.h"
#import "ArticleCommentHeader.h"
#import "ArticleCommentCell.h"
#import "UserArticleCommentsViewController.h"
#import "AUIKeyboardAdhesiveView.h"
#import "TZImagePickerController.h"
#import "KTCImageUploader.h"
#import "KTCCommentManager.h"
#import "MWPhotoBrowser.h"
#import "ArticleMoreCommentsViewController.h"
#import "KTCEmptyDataView.h"
#import "GHeader.h"
#import "UIButton+Category.h"
#import "NSString+Category.h"

#define pageCount 10
#define CommentViewHight 44
#define HeightForMarinInSection 50

/**
 upload_img 上传照片
 add_comment 评论、回复别人的评论
 praise_comment 点赞
 */

@interface ArticleCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AUIKeyboardAdhesiveViewDelegate,TZImagePickerControllerDelegate,MWPhotoBrowserDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) ArticleCommentHeader *header;
@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, strong) AUIKeyboardAdhesiveView *keyboardAdhesiveView;
@property (nonatomic, strong) KTCCommentManager *commentManager;

@property (nonatomic, strong) ArticleCommentResponseModel *model;
@property (nonatomic, assign) BOOL isComment;
@property (nonatomic, strong) NSString *currentCommentSysNo;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end

static NSString *const reuseIdentifier = @"reuseIdentifier";
@implementation ArticleCommentViewController

-(NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}

- (ArticleCommentHeader *)header{
    if (!_header) {
        _header = [[ArticleCommentHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        self.tableView.tableHeaderView = _header;
    }
    return _header;
}

-(AUIKeyboardAdhesiveView *)keyboardAdhesiveView{
    if (!_keyboardAdhesiveView) {
        AUIKeyboardAdhesiveViewExtensionFunction *photoFunc = [AUIKeyboardAdhesiveViewExtensionFunction funtionWithType:AUIKeyboardAdhesiveViewExtensionFunctionTypeImageUpload];
        _keyboardAdhesiveView = [[AUIKeyboardAdhesiveView alloc] initWithAvailableFuntions:[NSArray arrayWithObject:photoFunc]];
        [_keyboardAdhesiveView.headerView setBackgroundColor:COLOR_PINK];
        [_keyboardAdhesiveView setTextLimitLength:500];
        [_keyboardAdhesiveView setUploadImageLimitCount:4];
        _keyboardAdhesiveView.delegate = self;
    }
    return _keyboardAdhesiveView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.keyboardAdhesiveView shrink];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论列表";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-CommentViewHight, SCREEN_WIDTH, CommentViewHight)];
    commentView.backgroundColor = COLOR_PINK;
    [self.view addSubview:commentView];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(20, (CGRectGetHeight(commentView.frame)-30)*0.5, CGRectGetWidth(commentView.frame)-40, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 15;
    bgView.layer.masksToBounds = YES;
    [commentView addSubview:bgView];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(bgView.frame)-20, 30)];
    tf.delegate = self;
    tf.placeholder = @"评论一下...";
    tf.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:tf];
    self.tf = tf;
    
    WeakSelf(self)
    MJRefreshHeader *tv1_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getArticleCommentListRefresh:YES];
    }];
    tv1_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = tv1_header;
    
    MJRefreshFooter *tv1_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getArticleCommentListRefresh:NO];
    }];
    tv1_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = tv1_footer;
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)getArticleCommentListRefresh:(BOOL)refresh {
    
    if (refresh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    NSDictionary *paramters = @{@"page":[NSString stringWithFormat:@"%zd",self.page],
                                @"pageCount":[NSString stringWithFormat:@"%zd",pageCount],
                                @"relationId":self.relationId};
    [Request startWithName:@"GET_ARTICLE_COMMENT" param:paramters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ArticleCommentResponseModel *model = [ArticleCommentResponseModel modelWithDictionary:dic];
        self.model = model;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self caculateLayout:model refresh:refresh];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (refresh) self.header.model = model;
                if ([self.list count] == 0) {
                    self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"还没人评论噢，赶紧抢个沙发吧···" needGoHome:NO];
                } else {
                    self.tableView.backgroundView = nil;
                }
                [self.tableView reloadData];
            });
        });
        
        [self.tableView.mj_header endRefreshing];
        
        NSArray *comments = self.model.data.comments;
        if (!comments || comments.count<pageCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.list count] == 0) {
            self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"还没人评论噢，赶紧抢个沙发吧···" needGoHome:NO];
        } else {
            self.tableView.backgroundView = nil;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
- (void)caculateLayout:(ArticleCommentResponseModel *)model refresh:(BOOL)refresh {
    ACData *data = model.data;
    
    NSArray *myEvaList = data.myEva.evaList;
    ArticleCommentNeedModel *myNeedModel = nil;
    if (myEvaList.count>0) {
        myNeedModel = [[ArticleCommentNeedModel alloc]init];
        NSMutableArray *myAry = [NSMutableArray new];
        for (EvaListItem *item in myEvaList) {
            ArticleCommentLayout *layout = [[ArticleCommentLayout alloc]init];
            layout.isAboutMe = YES;
            layout.item = item;
            [myAry addObject:layout];
        }
        myNeedModel.headerTitle = [NSString stringWithFormat:@"与我相关(%ld)",(unsigned long)myAry.count];
        myNeedModel.dataAry = myAry;
        myNeedModel.hasMore = data.myEva.evaCount>myAry.count;
        
    }
    
    NSArray *hotEvaList = data.hotEva.evaList;
    ArticleCommentNeedModel *hotNeedModel = nil;
    if (hotEvaList.count>0) {
        hotNeedModel = [[ArticleCommentNeedModel alloc]init];
        NSMutableArray *hotAry = [NSMutableArray new];
        for (EvaListItem *item in hotEvaList) {
            ArticleCommentLayout *layout = [[ArticleCommentLayout alloc]init];
            layout.item = item;
            [hotAry addObject:layout];
        }
        hotNeedModel.headerTitle = [NSString stringWithFormat:@"热门评论(%ld)",(unsigned long)hotAry.count];
        hotNeedModel.dataAry = hotAry;
        
    }
    
    NSArray *comments = data.comments;
    ArticleCommentNeedModel *comNeedModel = nil;
    if (comments.count>0) {
        comNeedModel = [[ArticleCommentNeedModel alloc]init];
        NSMutableArray *comAry = [NSMutableArray new];
        for (EvaListItem *item in comments) {
            ArticleCommentLayout *layout = [[ArticleCommentLayout alloc]init];
            layout.item = item;
            [comAry addObject:layout];
        }
        comNeedModel.headerTitle = [NSString stringWithFormat:@"最新评论(%ld)",(unsigned long)model.count];
        comNeedModel.dataAry = comAry;
        
    }
    
    if (refresh) {
        NSMutableArray *listAry = [NSMutableArray new];
        if (myNeedModel) [listAry addObject:myNeedModel];
        if (hotNeedModel) [listAry addObject:hotNeedModel];
        if (comNeedModel) [listAry addObject:comNeedModel];
        if (listAry.count>0) self.list = listAry;
    }else{
        ArticleCommentNeedModel *oldComNeedModel = self.list.lastObject;
        if (comNeedModel) {
            NSMutableArray *newComAry = comNeedModel.dataAry;
            [oldComNeedModel.dataAry addObjectsFromArray:newComAry];
            oldComNeedModel.headerTitle = [NSString stringWithFormat:@"最新评论(%ld)",(unsigned long)oldComNeedModel.dataAry.count];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _selectedPhotos = nil;
    _selectedAssets = nil;
    self.keyboardAdhesiveView.placeholder = @"评论一下...";
    self.keyboardAdhesiveView.firstFunctionButton.hidden = NO;
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self.keyboardAdhesiveView expand];
    }];
    self.isComment = YES;
    
    return NO;
}

#define MIN_COMMENTLENGTH (1)
- (BOOL)isValidateComment {
    NSString *commentText = self.keyboardAdhesiveView.text;
    commentText = [commentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([commentText length] < MIN_COMMENTLENGTH) {
        [[iToast makeText:@"请至少输入1个字"] show];
        return NO;
    }
    
    return YES;
}
#pragma mark AUIKeyboardAdhesiveViewDelegate

//评论 - 点击评论相机按钮
- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedExtensionFunctionButtonWithType:(AUIKeyboardAdhesiveViewExtensionFunctionType)type {
    if (type == AUIKeyboardAdhesiveViewExtensionFunctionTypeImageUpload) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 columnNumber:4 delegate:self];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        [self.keyboardAdhesiveView hide];
    }
}

//评论 - 点击发送评论按钮
- (void)didClickedSendButtonOnKeyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view {

    if (![self isValidateComment]) return;
    [TCProgressHUD showSVP];
    if (_selectedPhotos.count>0) {
        __weak ArticleCommentViewController *weakSelf = self;
        [[KTCImageUploader sharedInstance] startUploadWithImagesArray:_selectedPhotos splitCount:1 withSucceed:^(NSArray *locateUrlStrings) {
            [weakSelf submitCommentsWithUploadLocations:locateUrlStrings];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            if (error.userInfo) {
                NSString *errMsg = [error.userInfo objectForKey:@"data"];
                if ([errMsg isKindOfClass:[NSString class]] && [errMsg length] > 0) {
                    [[iToast makeText:errMsg] show];
                } else {
                    [[iToast makeText:@"照片上传失败，请重新提交"] show];
                }
            } else {
                [[iToast makeText:@"照片上传失败，请重新提交"] show];
            }
        }];
    } else {
        [self submitCommentsWithUploadLocations:nil];
    }
}

//如果有图片 在所有图片上传完成、拿到所有url之后，再提交评论请求
- (void)submitCommentsWithUploadLocations:(NSArray *)locationUrls {
    KTCCommentObject *object = [[KTCCommentObject alloc] init];
    object.identifier = self.model.data.articleInfo.articleSysNo;
    object.relationType = CommentRelationTypeNews;
    object.isAnonymous = NO;
    object.isComment = self.isComment;
    object.commentIdentifier = self.currentCommentSysNo;
    object.content = self.keyboardAdhesiveView.text;
    object.uploadImageStrings = locationUrls;
    
    if (!self.commentManager) {
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    __weak ArticleCommentViewController *weakSelf = self;
    [weakSelf.commentManager addCommentWithObject:object succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentSucceed:data];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [weakSelf submitCommentFailed:error];
    }];
}
//提交评论 请求成功
- (void)submitCommentSucceed:(NSDictionary *)data {
    [self.keyboardAdhesiveView shrink];
    [self.tableView.mj_header beginRefreshing];
    
}
//提交评论 请求失败
- (void)submitCommentFailed:(NSError *)error {
    NSString *errMsg = @"提交评论失败，请重新提交。";
    NSString *remoteErrMsg = [error.userInfo objectForKey:@"data"];
    if ([remoteErrMsg isKindOfClass:[NSString class]] && [remoteErrMsg length] > 0) {
        errMsg = remoteErrMsg;
    }
    [[iToast makeText:errMsg] show];
}


//评论 - 预览照片
- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedUploadImageAtIndex:(NSUInteger)index {
    NSArray *array = [self makeMWPhotoFromImageArray:_selectedPhotos];
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:array];
    [photoBrowser setCurrentPhotoIndex:index];
    [photoBrowser setShowDeleteButton:YES];
    photoBrowser.delegate = self;
    [self.keyboardAdhesiveView hide];
    [self presentViewController:photoBrowser animated:YES completion:nil];
}


//选择照片完成
#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self.keyboardAdhesiveView setUploadImages:_selectedPhotos];
    [self.keyboardAdhesiveView show];
}

 - (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
     [self.keyboardAdhesiveView show];
 }


#pragma mark MWPhotoBrowserDelegate

- (void)photoBrowserDidDismissed:(MWPhotoBrowser *)photoBrowser {
    [self.keyboardAdhesiveView show];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didClickedDeleteButtonAtIndex:(NSUInteger)index {
    [self deletePhotoAtIndex:index];
    [self.keyboardAdhesiveView setUploadImages:_selectedPhotos];
}

- (NSArray *)makeMWPhotoFromImageArray:(NSArray<UIImage *> *)array {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [[MWPhoto alloc] initWithImage:obj];
        if (photo) {
            [temp addObject:photo];
        }
    }];
    return [NSArray arrayWithArray:temp];
}

- (void)deletePhotoAtIndex :(NSInteger)index
{
    if (_selectedPhotos.count>index) {
        [_selectedPhotos removeObjectAtIndex:index];
    }
    if (_selectedAssets.count>index) {
        [_selectedAssets removeObjectAtIndex:index];
    }
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.keyboardAdhesiveView shrink];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ArticleCommentNeedModel *needModel = self.list[section];
    return [needModel.dataAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightForMarinInSection;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.list.count-1) {
        return CommentViewHight;
    }else{
        ArticleCommentNeedModel *needModel = self.list[section];
        if (needModel.hasMore) {
            return HeightForMarinInSection;
        }
        
        return 0.01;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ArticleCommentNeedModel *needModel = self.list[indexPath.section];
    ArticleCommentLayout *layout = needModel.dataAry[indexPath.row];
    CGFloat hight = layout.isStyleOpen?layout.openHight:layout.normalHight;
    return hight;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ArticleCommentNeedModel *needModel = self.list[section];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightForMarinInSection)];
    view.backgroundColor = [UIColor colorWithRed:0.965  green:0.965  blue:0.965 alpha:1];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, HeightForMarinInSection-8)];
    [view addSubview:label];
    label.textColor = [UIColor colorWithRed:0.200  green:0.200  blue:0.200 alpha:1];
    label.backgroundColor = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:19];
    label.font = font;
    label.text = [NSString stringWithFormat:@"   %@",needModel.headerTitle];
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(ArticleCommentCellMarginInsets+2, HeightForMarinInSection-1, [needModel.headerTitle sizeWithAttributes:@{NSFontAttributeName:font}].width, 1)];
    [view addSubview:redView];
    redView.backgroundColor = [UIColor colorWithRed:0.992  green:0.616  blue:0.620 alpha:1];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ArticleCommentNeedModel *needModel = self.list[section];
    if (needModel.hasMore) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightForMarinInSection)];
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont  systemFontOfSize:15];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return btn;
    }else{
        return nil;
    }
}

- (void)moreAction:(UIButton *)btn {
    
    ArticleMoreCommentsViewController *articleMoreCommentsViewController = [[ArticleMoreCommentsViewController alloc]init];
    articleMoreCommentsViewController.relationId = self.model.data.articleInfo.articleSysNo;
    articleMoreCommentsViewController.userId = [User shareUser].uid;
    [self.navigationController pushViewController:articleMoreCommentsViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[ArticleCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    ArticleCommentNeedModel *needModel = self.list[indexPath.section];
    ArticleCommentLayout *layout = needModel.dataAry[indexPath.row];
    cell.layout = layout;
    
    __weak typeof(self) weakSelf = self;
    cell.headActionBlock = ^ (NSString *userId){
        ArticleCommentViewController *self = weakSelf;
        
        UserArticleCommentsViewController *userArticleCommentsVC = [[UserArticleCommentsViewController alloc]init];
        userArticleCommentsVC.userId = userId;
        [self.navigationController pushViewController:userArticleCommentsVC animated:YES];
    };
    cell.nameActionBlock = ^(NSString *userId){
        ArticleCommentViewController *self = weakSelf;
        
        UserArticleCommentsViewController *userArticleCommentsVC = [[UserArticleCommentsViewController alloc]init];
        userArticleCommentsVC.userId = userId;
        [self.navigationController pushViewController:userArticleCommentsVC animated:YES];
    };
    
    cell.priseActionBlock = ^(NSString *commentSysNo){
        ArticleCommentViewController *self = weakSelf;
        self.currentIndexPath = indexPath;
        [self changePriseStateAction];
    };
    
    cell.changeStyleActionBlock = ^{
        ArticleCommentViewController *self = weakSelf;
        layout.isStyleOpen = !layout.isStyleOpen;
        
        [self.tableView reloadData];
    };
    
    cell.SVTapActionBlock = ^{
        ArticleCommentViewController *self = weakSelf;
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    
    return cell;
}

- (void)changePriseStateAction{
    
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ArticleCommentNeedModel *needModel = self.list[self.currentIndexPath.section];
        ArticleCommentLayout *layout = needModel.dataAry[self.currentIndexPath.row];
        EvaListItem *item = layout.item;
        
        NSString *isPrasize = item.isPraised? @"0":@"1";
        NSString *articleSysNo = self.model.data.articleInfo.articleSysNo;
        articleSysNo = [articleSysNo isNotNull]?articleSysNo:@"";
        NSString *commentSysNo = item.commentSysNo;
        commentSysNo = [commentSysNo isNotNull]?commentSysNo:@"";
        NSDictionary *param = @{@"relationSysNo":articleSysNo,
                                @"commentSysNo":commentSysNo,
                                @"isPraise":isPrasize};
        [Request startWithName:@"COMMENT_PRAISE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            item.isPraised = !item.isPraised;
            if (item.isPraised) {
                item.praiseCount ++;
            }else{
                item.praiseCount --;
            }
            [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failure:nil];
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ArticleCommentNeedModel *needModel = self.list[indexPath.section];
    ArticleCommentLayout *layout = needModel.dataAry[indexPath.row];
    if (layout.isAboutMe) {
        return;
    }else{
        if ([self becomeFirstResponder]) {
            self.currentIndexPath = indexPath;
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            if ([window isKeyWindow] == NO)
            {
                [window becomeKeyWindow];
                [window makeKeyAndVisible];
            }
            
            NSString *changePriseStateStr = @"";
            if (layout.item.isPraised) {
                changePriseStateStr = @"取消顶";
            }else{
                changePriseStateStr = @"顶一下";
            }
            
            ArticleCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UIMenuItem *menuItemChangePriseState = [[UIMenuItem alloc] initWithTitle:changePriseStateStr
                                                                              action:@selector(changePriseStateAction)];
            UIMenuItem *menuItemReply = [[UIMenuItem alloc]initWithTitle:@"评一下" action:@selector(replyAction)];
            [[UIMenuController sharedMenuController] setMenuItems:@[menuItemChangePriseState,menuItemReply]];
            [[UIMenuController sharedMenuController] setTargetRect:cell.contentLabel.frame inView:cell.contentLabel.superview];
            [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
        }
    }
}

- (void)replyAction{
    
    ArticleCommentNeedModel *needModel = self.list[self.currentIndexPath.section];
    ArticleCommentLayout *layout = needModel.dataAry[self.currentIndexPath.row];
    if (layout.item){
        self.keyboardAdhesiveView.placeholder = [NSString stringWithFormat:@"回复%@:",layout.item.userName];
        self.currentCommentSysNo = layout.item.commentSysNo;
    }

    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self.keyboardAdhesiveView expand];
    }];
    self.keyboardAdhesiveView.firstFunctionButton.hidden = YES;
    //评论的回复
    self.isComment = NO;
}



#pragma mark UIMenuItemActions 需要实现的额外方法
-(BOOL)canBecomeFirstResponder {
    return YES;
}
// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(changePriseStateAction) ||
        action == @selector(replyAction)) {
        return YES;
    }else{
        return NO;
    }
}
@end
