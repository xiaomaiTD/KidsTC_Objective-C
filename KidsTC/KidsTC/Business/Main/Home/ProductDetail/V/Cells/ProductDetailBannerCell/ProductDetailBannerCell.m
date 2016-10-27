//
//  ProductDetailBannerCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailBannerCell.h"
#import "ProductDetailBannerCollectionViewCell.h"
#import "YYKit.h"
static NSString *const ID = @"ProductDetailBannerCollectionViewCell";
static int const kProductDetailBannerCellMaxSections = 11;

@interface ProductDetailBannerCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CollectionViewConstraintH;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) YYTimer *timer;
@property (nonatomic, weak) NSArray<NSString *> *narrowImg;
@end

@implementation ProductDetailBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailBannerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.pageControl.currentPageIndicatorTintColor = COLOR_PINK;
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    self.CollectionViewConstraintH.constant = data.picRate * SCREEN_WIDTH;
    
    self.narrowImg = data.narrowImg;
    [self.collectionView reloadData];
    
    self.pageControl.numberOfPages = _narrowImg.count;
    [self addYYTimer];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * self.data.picRate);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _narrowImg.count>1?kProductDetailBannerCellMaxSections:1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _narrowImg.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageUrl = _narrowImg[indexPath.row];
    return cell;
}

#pragma mark - timer

- (void)addYYTimer{
    if (_narrowImg.count>1) {
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
    int count = (int)_narrowImg.count;
    
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == count) {
        nextItem = 0;
        nextSection++;
    }
    if (nextItem<count && nextSection<kProductDetailBannerCellMaxSections) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        // 3.通过动画滚动到下一个位置
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kProductDetailBannerCellMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    return currentIndexPathReset;
}

#pragma mark  - UIScrollViewDelegate
//当用户即将开始拖拽的时候就调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeYYTimer];
}

//当用户停止拖拽的时候就调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_narrowImg.count>1)[self addYYTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int count = (int)_narrowImg.count;
    if (count>0) {
        int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % count;
        self.pageControl.currentPage = page;
    }
}

@end
