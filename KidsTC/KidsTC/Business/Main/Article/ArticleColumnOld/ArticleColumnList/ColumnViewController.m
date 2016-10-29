//
//  ColumnCollectionViewController.m
//  KidsTC
//
//  Created by zhanping on 4/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ColumnViewController.h"
#import "ColumnCell.h"
#import "YYKit.h"
#import "ColumnModel.h"
#import "ArticleColumnViewController.h"

#import "GHeader.h"
#import "KTCEmptyDataView.h"
@interface ColumnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *ary;
@end

@implementation ColumnViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10707;
    self.navigationItem.title = @"栏目列表";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, 200);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[ColumnCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSDictionary *param = @{@"page":@"1",@"pageCount":@"1000"};
    [Request startWithName:@"GET_ARTICLE_COLUMN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ColumnResponse *columnResponse = [ColumnResponse modelWithDictionary:dic];
        if (columnResponse.data.count>0) {
            self.ary = columnResponse.data;
            CDataItem *item = self.ary[0];
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
            layout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, SCREEN_WIDTH*0.5*item.ratio);
        }
        if ([self.ary count] == 0) {
            self.collectionView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.collectionView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        } else {
            self.collectionView.backgroundView = nil;
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.ary count] == 0) {
            self.collectionView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.collectionView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        } else {
            self.collectionView.backgroundView = nil;
        }
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.ary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.item = self.ary[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CDataItem *item = self.ary[indexPath.row];
    ArticleColumnViewController *cdVC = [[ArticleColumnViewController alloc]init];
    cdVC.columnSysNo = item.ID;
    cdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cdVC animated:YES];
}


@end
