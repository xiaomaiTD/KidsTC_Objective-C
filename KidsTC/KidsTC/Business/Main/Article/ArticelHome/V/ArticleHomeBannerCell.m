//
//  ArticleHomeBannerCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBannerCell.h"
#import "ArticleHomeBannerCollectionViewBaseCell.h"
#import "ArticleHomeBannerCollectionViewOneCell.h"
#import "ArticleHomeBannerCollectionViewTwoCell.h"
#import "YYTimer.h"

#define MAX_SECTIONS     11
#define TWOCELL_H_INSETS 12
#define TWOCELL_V_INSETS 12
static NSString *const ArticleHomeBannerCollectionViewBaseCellID = @"ArticleHomeBannerCollectionViewBaseCellID";
static NSString *const ArticleHomeBannerCollectionViewOneCellID  = @"ArticleHomeBannerCollectionViewOneCellID";
static NSString *const ArticleHomeBannerCollectionViewTwoCellID  = @"ArticleHomeBannerCollectionViewTwoCellID";

@interface ArticleHomeBannerCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlConstraintBottomMargin;

@property (nonatomic, strong) YYTimer *timer;
@end

@implementation ArticleHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collectionView.scrollsToTop = NO;
    [self.collectionView registerClass:[ArticleHomeBannerCollectionViewBaseCell class] forCellWithReuseIdentifier:ArticleHomeBannerCollectionViewBaseCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeBannerCollectionViewOneCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeBannerCollectionViewOneCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeBannerCollectionViewTwoCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeBannerCollectionViewTwoCellID];
    
    self.pageControl.currentPageIndicatorTintColor = COLOR_PINK;
    self.pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    if (item.banners.count<=1) {
        [self removeTimer];
        self.collectionView.scrollEnabled = NO;
    }else{
        [self addTimer];
        self.collectionView.scrollEnabled = YES;
    }
    self.pageControl.numberOfPages = item.banners.count;
    
    CGFloat collectionConstraintHeight;
    CGFloat pageControlConstraintBottomMargin;
    switch (item.listTemplate) {
        case ArticleHomeListTemplateBanner:
        {
            collectionConstraintHeight = item.ratio*(SCREEN_WIDTH-TWOCELL_H_INSETS*2)+TWOCELL_V_INSETS*2;
            pageControlConstraintBottomMargin = TWOCELL_V_INSETS;
        }
            break;
        case ArticleHomeListTemplateHeadBanner:
        {
            collectionConstraintHeight = item.ratio*SCREEN_WIDTH;
            pageControlConstraintBottomMargin = 0.0;
        }
            break;
        default:
        {
            collectionConstraintHeight = 0.0;
            pageControlConstraintBottomMargin = 0.0;
        }
            break;
    }
    self.pageControlConstraintBottomMargin.constant = (int)pageControlConstraintBottomMargin;
    self.collectionConstraintHeight.constant = (int)collectionConstraintHeight;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MAX_SECTIONS;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.banners.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeItem *item = self.item;
    NSString *ID = [self IdWith:item.listTemplate];
    ArticleHomeBannerCollectionViewBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imgUrl = item.banners[indexPath.row].imgUrl;
    return cell;
}

- (NSString *)IdWith:(ArticleHomeListTemplate)listTemplate {
    NSString *ID = ArticleHomeBannerCollectionViewBaseCellID;
    switch (listTemplate) {
        case ArticleHomeListTemplateBanner:
        {
            ID = ArticleHomeBannerCollectionViewTwoCellID;
        }
            break;
        case ArticleHomeListTemplateHeadBanner:
        {
            ID = ArticleHomeBannerCollectionViewOneCellID;
        }
            break;
        default:
        {
            ID = ArticleHomeBannerCollectionViewBaseCellID;
        }
            break;
    }
    return ID;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeBanner *banner = self.item.banners[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:banner.segueModel];
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
    if (self.item.banners.count>1)[self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger count = self.item.banners.count;
    if (count>0) {
        int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.item.banners.count;
        if (self.item.banners.count>1) self.pageControl.currentPage = page;
    }
}

#pragma mark - helpers
/**
 *  添加定时器
 */
- (void)addTimer
{
    [self removeTimer];
    self.timer = [YYTimer timerWithTimeInterval:5.0 target:self selector:@selector(nextPage) repeats:YES];
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
    if (nextItem == self.item.banners.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    if (nextSection<MAX_SECTIONS && nextItem<self.item.banners.count) {
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MAX_SECTIONS/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

@end
