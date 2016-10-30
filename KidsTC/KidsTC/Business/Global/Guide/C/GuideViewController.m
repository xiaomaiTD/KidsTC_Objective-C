//
//  GuideViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideViewCell.h"


@interface GuideViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
static NSString *const GuideViewCellID = @"GuideViewCellID";
@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initui];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)initui{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initCollectionView];
    
    [self initBtn];
    
    [self updateBtn:0];
}

- (void)initCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.scrollEnabled = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"GuideViewCell" bundle:nil] forCellWithReuseIdentifier:GuideViewCellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)initBtn{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)back{
    [super back];
    if (self.resultBlock) self.resultBlock();
}

- (void)turnPage{
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].firstObject;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item+1 inSection:currentIndexPath.section];
    if (nextIndexPath.item<self.datas.count) {
        [self updateBtn:nextIndexPath.item];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        [self back];
    }
}

- (void)updateBtn:(NSUInteger)index{
    GuideDataItem *item = self.datas[index];
    self.btn.hidden = !item.btnCanShow;
    self.btn.frame = item.btnFrame;
    [self.btn setImage:[UIImage imageNamed:item.btnImageName] forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuideViewCellID forIndexPath:indexPath];
    cell.item = self.datas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self turnPage];
}


@end
