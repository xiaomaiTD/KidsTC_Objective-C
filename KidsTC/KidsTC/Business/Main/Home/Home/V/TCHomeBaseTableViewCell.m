 //
//  TCHomeBaseTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeBaseTableViewCell.h"
#import "TCHomeCollectionViewCell.h"
#import "NSString+Category.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "TCHomeTitleContainer.h"
#import "YYKit.h"

@interface TCHomeNotiTipBGView : UIView
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) UIImageView *notiImageView;
@property (nonatomic, strong) UIView *line;
@end

@implementation TCHomeNotiTipBGView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *notiImageView = [UIImageView new];
        notiImageView.contentMode = UIViewContentModeScaleToFill;
        notiImageView.clipsToBounds = YES;
        [self addSubview:notiImageView];
        self.notiImageView = notiImageView;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    CGFloat margin = 8;
    _notiImageView.frame = CGRectMake(margin, margin, self_w - 2 * margin, self_h - 2 * margin);
    _line.frame = CGRectMake(self_w - LINE_H, margin, LINE_H, self_h - 2 * margin);
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [_notiImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end

static NSString *const kTCHomeCollectionViewCellID = @"TCHomeCollectionViewCell";

@interface TCHomeBaseTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,TCHomeTitleContainerDelegate>
@property (nonatomic, strong) TCHomeTitleContainer *titleContainer;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) TCHomeNotiTipBGView *notiBGView;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation TCHomeBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        TCHomeTitleContainer *titleContainer = [TCHomeTitleContainer new];
        titleContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTCHomeFloorTitleContentH);
        titleContainer.delegate = self;
        [self addSubview:titleContainer];
        self.titleContainer = titleContainer;
        
        UICollectionViewLayout *layout = [UICollectionViewLayout new];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[TCHomeCollectionViewCell class] forCellWithReuseIdentifier:kTCHomeCollectionViewCellID];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.clipsToBounds = YES;
        collectionView.backgroundView = bgImageView;
        self.bgImageView = bgImageView;
        
        TCHomeNotiTipBGView *notiBGView = [TCHomeNotiTipBGView new];
        [self addSubview:notiBGView];
        self.notiBGView = notiBGView;
        
        
        UIPageControl *pageControl = [UIPageControl new];
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        pageControl.currentPageIndicatorTintColor = COLOR_PINK;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViews];
}

- (void)setFloor:(TCHomeFloor *)floor {
    _floor = floor;

    _titleContainer.hidden = !_floor.showTitleContainer;
    if (_floor.showTitleContainer) {
        _titleContainer.titleContent = floor.titleContent;
    }
    
    _bgImageView.hidden = !_floor.showBgImageView;
    if (_floor.showBgImageView) {
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:floor.bgImgUrl]];
    }
    
    _notiBGView.hidden = !_floor.showNotiImageView;
    if (_floor.showNotiImageView) {
        _notiBGView.imgUrl = floor.notiImgUrl;
    }
    
    _pageControl.hidden = !_floor.showPageControl;
    if (_floor.showPageControl) {
        _pageControl.numberOfPages = _floor.contents.count;
    }
    
    [self addYYTimer];
    
    [self.collectionView reloadData];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    
    if (_floor.collectionViewLayout) {
        self.collectionView.frame = _floor.collectionViewFrame;
        self.collectionView.collectionViewLayout = _floor.collectionViewLayout;
    }else{
        self.collectionView.frame = self.bounds;
    }
    if (_floor.showBgImageView) {
        self.bgImageView.frame = self.collectionView.bounds;
    }
    if (_floor.showNotiImageView) {
        _notiBGView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.2, CGRectGetHeight(self.bounds));
    }
    if (_floor.showPageControl) {
        self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 30, CGRectGetWidth(self.bounds), 30);
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _floor.canAddYYTimer?kTCHomeCollectionViewCellMaxSections:1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.floor.contents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTCHomeCollectionViewCellID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.floor.contents.count) {
        cell.content = self.floor.contents[row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    if (row<self.floor.contents.count) {
        TCHomeFloorContent *content = self.floor.contents[row];
        if ([self.delegate respondsToSelector:@selector(tcHomeBaseTableViewCell:actionType:value:)]) {
            [self.delegate tcHomeBaseTableViewCell:self actionType:TCHomeBaseTableViewCellActionTypeSegue value:content.segueModel];
        }
    }
}

#pragma mark - TCHomeTitleContainerDelegate

- (void)tcHomeTitleContainer:(TCHomeTitleContainer *)container actionType:(TCHomeTitleContainerActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(tcHomeBaseTableViewCell:actionType:value:)]) {
        [self.delegate tcHomeBaseTableViewCell:self actionType:TCHomeBaseTableViewCellActionTypeSegue value:value];
    }
}

#pragma mark - timer

- (void)addYYTimer{
    if (_floor.canAddYYTimer) {
        if (self.timer) [self removeYYTimer];
        self.timer = [YYTimer timerWithTimeInterval:5 target:self selector:@selector(nextPage) repeats:YES];
    }else{
        [self removeYYTimer];
    }
}

- (void)removeYYTimer {
    [self.timer invalidate];
    self.timer = nil;
}

//下一页
- (void)nextPage
{
    int count = (int)_floor.contents.count;
    
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == count) {
        nextItem = 0;
        nextSection++;
    }
    if (nextItem<count && nextSection<kTCHomeCollectionViewCellMaxSections) {
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
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kTCHomeCollectionViewCellMaxSections/2];
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
    if (self.floor.contents.count>1)[self addYYTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int count = (int)_floor.contents.count;
    if (count>0) {
        int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % count;
        self.pageControl.currentPage = page;
    }
}

@end
