//
//  WholesaleOrderDetailJoinCountCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailJoinCountCell.h"
#import "WholesaleOrderDetailJoinCountCollectionCell.h"

static NSString *const CellID = @"WholesaleOrderDetailJoinCountCollectionCell";

static CGFloat const CellWidth = 74;
static CGFloat const CellMargin = 12;

@interface WholesaleOrderDetailJoinCountCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) WholesaleProductDetailCount *selectedItem;
@end

@implementation WholesaleOrderDetailJoinCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinCountCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (void)setCounts:(NSArray<WholesaleProductDetailCount *> *)counts {
    _counts = counts;
    NSInteger count = _counts.count;
    if (count>0) {
        self.margin = (SCREEN_WIDTH - count * CellWidth - CellMargin*(count-1))*0.5;
        if (self.margin<15) self.margin = 15;
    }
    [_counts enumerateObjectsUsingBlock:^(WholesaleProductDetailCount *obj, NSUInteger idx, BOOL *stop) {
        if (obj.selected) self.selectedItem = obj;
    }];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CellWidth, CGRectGetHeight(collectionView.frame));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.margin, 0, self.margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CellMargin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CellMargin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.counts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WholesaleOrderDetailJoinCountCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.counts.count) {
        cell.item = self.counts[row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row<self.counts.count) {
        WholesaleProductDetailCount *item = self.counts[row];
        if (item == self.selectedItem) return;
        self.selectedItem.selected = NO;
        item.selected = YES;
        self.selectedItem = item;
        [collectionView reloadData];
        if ([self.delegate respondsToSelector:@selector(wholesaleOrderDetailBaseCell:actionType:value:)]) {
            [self.delegate wholesaleOrderDetailBaseCell:self actionType:self.tag value:@(item.index+1)];
        }
    }
}

@end
