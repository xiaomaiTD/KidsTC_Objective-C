//
//  AccountCenterBannersCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBannersCell.h"
#import "AccountCenterBannersCollectionViewCell.h"
#import "YYKit.h"
#import "StyledPageControl.h"

static NSInteger const maxSections = 11;
static NSString *const ID = @"AccountCenterBannersCollectionViewCell";

@interface AccountCenterBannersCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)StyledPageControl *pageControl;
@property (nonatomic, strong) NSArray<AccountCenterBanner *> *banners;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation AccountCenterBannersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AccountCenterBannersCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
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
    self.pageControl = pageControl;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-12, CGRectGetWidth(self.bounds), 12);
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    self.banners = self.model.data.config.banners;
    CGFloat height = self.model.data.config.bannerHeight;
    if (height<=0) height = 90;
    self.height.constant = height;
    self.pageControl.numberOfPages = self.banners.count;
    [self.collectionView reloadData];
    [self addYYTimer];
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
    return maxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.banners.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountCenterBannersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    if (row<self.banners.count) {
        cell.banner = self.banners[row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row<self.banners.count) {
        if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
            [self.delegate accountCenterBaseCell:self actionType:AccountCenterCellActionTypeSegue value:self.banners[row].segueModel];
        }
    }
}

#pragma mark - helpers

- (void)addYYTimer{
    if (self.banners.count>1) {
        if (self.timer) [self removeYYTimer];
        self.timer = [YYTimer timerWithTimeInterval:5 target:self selector:@selector(nextPage) repeats:YES];
    }else{
        [self removeYYTimer];
    }
}

- (void)removeYYTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//下一页
- (void)nextPage
{
    int count = (int)self.banners.count;
    
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    if (currentIndexPathReset) {
        // 2.计算出下一个需要展示的位置
        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem >= count) {
            nextItem = 0;
            nextSection++;
        }
        if (nextSection >= maxSections) {
            nextSection = 0;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSArray *indexs = [self.collectionView indexPathsForVisibleItems];
    if (indexs.count>0) {
        NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
        
        // 马上显示回最中间那组的数据
        NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:maxSections/2];
        [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return currentIndexPathReset;
    }
    return nil;
}

#pragma mark  - UIScrollViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeYYTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.banners.count>1)[self addYYTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.banners.count;
    if (self.banners.count>1) self.pageControl.currentPage = page;
}

@end
