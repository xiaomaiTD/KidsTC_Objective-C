//
//  StrategyAutoRollView.m
//  StrategyAutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "StrategyAutoRollView.h"
#import "Macro.h"
#define cellIdentifier @"StrategyAutoRollCell"
#define StrategyAutoRollViewMaxSections 101

@interface StrategyAutoRollView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIPageControl *pageContol;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation StrategyAutoRollView

#pragma mark -
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<StrategyAutoRollViewDelegate>)delegate{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.items=items;
        self.delegate=delegate;
        
        CGFloat width=frame.size.width;
        CGFloat height=frame.size.height;
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize=CGSizeMake(width, height);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:flowLayout];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.showsVerticalScrollIndicator=NO;
        self.collectionView.showsHorizontalScrollIndicator=NO;
        self.collectionView.pagingEnabled=YES;
        self.collectionView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.collectionView];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"StrategyAutoRollCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        
        
        self.pageContol=[[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-20, CGRectGetWidth(self.bounds), 20)];
        self.pageContol.pageIndicatorTintColor=[UIColor whiteColor];
        UIColor *color = COLOR_PINK;
        self.pageContol.currentPageIndicatorTintColor = color;
        self.pageContol.numberOfPages = self.items.count;
        [self addSubview:self.pageContol];
        
        
        // 默认显示最中间的那组
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:StrategyAutoRollViewMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        
        // 添加定时器
        [self addTimer];
        
    }
    return self;
}

#pragma mark - helpers
/**
 *  添加定时器
 */
- (void)addTimer
{
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
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:StrategyAutoRollViewMaxSections/2];
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
    return StrategyAutoRollViewMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StrategyAutoRollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.item = self.items[indexPath.row];
    
    return cell;
}


#pragma mark  - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath.row:%ld",indexPath.row);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didSelectPageAtIndex:)]) {
        [self.delegate didSelectPageAtIndex:indexPath.row];
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
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.items.count;
    self.pageContol.currentPage = page;
}

#pragma mark  -
-(void)dealloc{
    [self.timer invalidate];
    self.timer=nil;
}


@end
