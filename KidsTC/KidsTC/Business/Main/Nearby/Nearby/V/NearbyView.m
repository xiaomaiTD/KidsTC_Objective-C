//
//  NearbyView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyView.h"
#import "Colours.h"
#import "MultiItemsToolBar.h"
#import "NearbyCategoryToolBar.h"
#import "NearbyCollectionViewCell.h"
#import "NearbyViewFlowLayout.h"

static NSString *CellID = @"NearbyCollectionViewCell";

@interface NearbyView ()<UICollectionViewDelegate,UICollectionViewDataSource,MultiItemsToolBarDelegate,NearbyCollectionViewCellDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) MultiItemsToolBar *itemsBar;
@property (weak, nonatomic) NearbyCategoryToolBar *categoryToolBar;
@end

@implementation NearbyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect collectionViewFrame = CGRectMake(0, 64 + MultiItemsToolBarScrollViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - MultiItemsToolBarScrollViewHeight - 49);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:[NearbyViewFlowLayout new]];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        collectionView.pagingEnabled = YES;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        [self.collectionView registerNib:[UINib nibWithNibName:@"NearbyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
        
        NearbyCategoryToolBar *categoryToolBar = [[NSBundle mainBundle] loadNibNamed:@"NearbyCategoryToolBar" owner:self options:nil].firstObject;
        categoryToolBar.frame = CGRectMake(0, CGRectGetMaxY(self.itemsBar.frame), SCREEN_WIDTH,SCREEN_HEIGHT - 64 - MultiItemsToolBarScrollViewHeight - 49);
        [self addSubview:categoryToolBar];
        categoryToolBar.hidden = YES;
        self.categoryToolBar = categoryToolBar;
        
        MultiItemsToolBar *itemsBar = [[MultiItemsToolBar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight)];
        itemsBar.delegate =  self;
        itemsBar.tags = @[@"人气",@"价格",@"促销",@"分类"];
        [self addSubview:itemsBar];
        self.itemsBar = itemsBar;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.itemsBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
        });
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 64 + MultiItemsToolBarScrollViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - MultiItemsToolBarScrollViewHeight - 49);
    self.categoryToolBar.frame = CGRectMake(0, CGRectGetMaxY(self.itemsBar.frame), SCREEN_WIDTH,SCREEN_HEIGHT - 64 - MultiItemsToolBarScrollViewHeight - 49);
    self.itemsBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NearbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - MultiItemsToolBarDelegate

- (void)multiItemsToolBar:(MultiItemsToolBar *)multiItemsToolBar didSelectedIndex:(NSUInteger)index {
    if (index == self.itemsBar.tags.count - 1) {
        [self.categoryToolBar showHide];
    }else{
        [self.categoryToolBar hide];
        CGFloat scrollView_w = SCREEN_WIDTH;
        CGPoint contentOffset = self.collectionView.contentOffset;
        contentOffset.x = scrollView_w*index;
        self.collectionView.contentOffset = contentOffset;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat scrollView_w = SCREEN_WIDTH;
    NSUInteger smallIndex = offsetX/scrollView_w;
    NSUInteger bigIndex = smallIndex+1;
    CGFloat progress = (offsetX - smallIndex * scrollView_w)/scrollView_w;
    
    [self.itemsBar changeTipPlaceWithSmallIndex:smallIndex bigIndex:bigIndex progress:progress animate:YES];
}

#pragma mark - NearbyCollectionViewCellDelegate

- (void)nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyCollectionViewCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyView:actionType:value:)]) {
        [self.delegate nearbyView:self actionType:(NearbyViewActionType)type value:value];
    }
}


@end
