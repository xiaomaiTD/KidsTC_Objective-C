//
//  AutoRollView.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "UserCenterProductAutoRollView.h"
#import "UserCenterProductAutoRollViewLayout.h"
#import "UIImage+Category.h"
#import "StyledPageControl.h"
#define cellIdentifier @"UserCenterProductAutoRollCell"
#define AutoRollViewMaxSections 11

@interface UserCenterProductAutoRollView()<UICollectionViewDelegate,UICollectionViewDataSource,UserCenterProductAutoRollCellDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)StyledPageControl *pageContol;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong)NSArray<NSArray<UserCenterProductLsItem *> *> *items;
@end

@implementation UserCenterProductAutoRollView

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout=[[UserCenterProductAutoRollViewLayout alloc]init];
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.showsVerticalScrollIndicator=NO;
        self.collectionView.showsHorizontalScrollIndicator=NO;
        self.collectionView.pagingEnabled=YES;
        self.collectionView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.collectionView];
        self.collectionView.scrollsToTop = NO;
        [self.collectionView registerNib:[UINib nibWithNibName:@"UserCenterProductAutoRollCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        
        StyledPageControl *pageControl=[[StyledPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        pageControl.gapWidth = 6;
        CGSize imageSize = CGSizeMake(8, 2);
        UIImage *pageImage = [UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] size:imageSize];
        UIImage *currentPageImage = [UIImage imageWithColor:COLOR_PINK size:imageSize];
        pageControl.pageControlStyle = PageControlStyleThumb;
        [pageControl setThumbImage:pageImage];
        [pageControl setSelectedThumbImage:currentPageImage];
        
        [self addSubview:pageControl];
        self.pageContol = pageControl;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, (int)CGRectGetWidth(self.bounds), (int)CGRectGetHeight(self.bounds));
    self.pageContol.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-10, CGRectGetWidth(self.bounds), 10);
}

- (void)setOriginalItems:(NSArray<UserCenterProductLsItem *> *)originalItems{
    _originalItems = originalItems;
    int groupNum = ((int)originalItems.count +3-1) / 3 ;//按3个一组来分，有几组
    NSMutableArray *bigArray = [NSMutableArray new];
    for (int i = 0; i<groupNum; i++) {
        NSMutableArray *samllArrray = [NSMutableArray new];
        for (int j = 0; j<3; j++) {
            int index = i*3 + j;
            if (index < originalItems.count) {
                NSObject *obj = originalItems[index];
                [samllArrray addObject:obj];
            }
        }
        [bigArray addObject:samllArrray];
    }
    self.items = [NSArray arrayWithArray:bigArray];
    if (self.items.count<=1) {
        [self removeTimer];
        self.collectionView.scrollEnabled = NO;
    }else{
        [self addTimer];
        self.collectionView.scrollEnabled = YES;
    }
    self.pageContol.numberOfPages = self.items.count;
    [self.collectionView reloadData];
}

#pragma mark - helpers
/**
 *  添加定时器
 */
- (void)addTimer
{
    [self removeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}
/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];

    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.items.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:AutoRollViewMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return AutoRollViewMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterProductAutoRollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.productType = self.productType;
    cell.items = self.items[indexPath.item];
    cell.delegate = self;
    return cell;
}


#pragma mark - UserCenterProductAutoRollCellDelegate

- (void)userCenterProductAutoRollCell:(UserCenterProductAutoRollCell *)cell actionIndex:(NSUInteger)index{
    NSInteger selectedIndex = self.pageContol.currentPage*3+index;
    if ([self.delegate respondsToSelector:@selector(didSelectPageAtIndex:)]) {
        [self.delegate didSelectPageAtIndex:selectedIndex];
    }
}

#pragma mark  - UIScrollViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.items.count>1)[self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.items.count;
    if (self.items.count>1) self.pageContol.currentPage = page;
}


@end
