//
//  HomeBannerCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/20.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeBannerCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "SegueMaster.h"
#import "HomeDataManager.h"
#import "BannerCollectionCell.h"
#import "Masonry.h"
#import "HomeBannerCollectionViewFlowLayout.h"

static NSString *const identifier = @"banner";
static NSTimeInterval const duration = 5;

@interface HomeBannerCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation HomeBannerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self prepareCollection];
        [self addSubview:self.pageControl];
        [self setConstraints];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView setNeedsUpdateConstraints];
    [self.collectionView updateConstraints];
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutIfNeeded];
}

- (void)prepareCollection{
    
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[BannerCollectionCell class] forCellWithReuseIdentifier:identifier];
}

- (void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [super  setFloorsItem:floorItem1];
    self.pageControl.numberOfPages = floorsItem.contents.count > 1 ? floorsItem.contents.count : 0;
    [self reloadData];
    //self.layout.itemSize = CGSizeMake(SCREEN_WIDTH, floorsItem.rowHeight);
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:floorsItem.contents.count > 1 ? 1 : 0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];//默认滚动到中间sec
    
    if (floorsItem.contents.count > 1) {
        [self addTimer];
    }
}

#pragma mark-
#pragma mark delegate & datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.floorsItem.contents.count == 1) return 1;
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.floorsItem.contents.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //模型
    BannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.floorItem = self.floorsItem;
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return self.collectionView.bounds.size;
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    NSInteger targetIndex = currentIndex % self.floorsItem.contents.count;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:1] atScrollPosition:0 animated:NO];
    
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.floorsItem.contents.count;
    self.pageControl.currentPage = page;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeItemContentItem *content = self.floorsItem.contents[indexPath.item];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}
#pragma mark-
#pragma mark timer
- (void)autoScroll{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.floorsItem.contents.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSIndexPath *)resetIndexPath{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1    ];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

- (void)addTimer{
    [self removeTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)removeTimer{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)reloadData{
    [self.collectionView reloadData];
    [self removeTimer];
}

-(void)dealloc{
    [self removeTimer];
}
#pragma mark-
#pragma mark lzy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        HomeBannerCollectionViewFlowLayout *layout = [[HomeBannerCollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = COLOR_PINK;
        _pageControl.pageIndicatorTintColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.3];
    }
    return _pageControl;
}
@end
