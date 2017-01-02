//
//  RecommendProductAccountCenterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProductAccountCenterView.h"
#import "RecommendDataManager.h"
#import "RecommendProductAccountCenterCell.h"

static NSString *const CellID = @"RecommendProductAccountCenterCell";

static CGFloat const margin = 8;

@interface RecommendProductAccountCenterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation RecommendProductAccountCenterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecommendProductAccountCenterCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    [self layoutIfNeeded];
}

- (void)setProducts:(NSArray<RecommendProduct *> *)products {
    [super setProducts:products];
    [self.collectionView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)reloadData {
    self.products = [[RecommendDataManager shareRecommendDataManager] recommendProductsWithType:RecommendProductTypeUserCenter];
}

- (CGFloat)contentHeight {
    return CGRectGetMinY(self.collectionView.frame) + self.collectionView.contentSize.height;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - 3*margin) * 0.5;
    return CGSizeMake(w, w + 95);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, 0, margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommendProductAccountCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.products.count) {
        RecommendProduct *product = self.products[row];
        cell.product = product;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row<self.products.count) {
        RecommendProduct *product = self.products[row];
        if ([self.delegate respondsToSelector:@selector(recommendProductView:actionType:value:)]) {
            [self.delegate recommendProductView:self actionType:RecommendProductViewActionTypeSegue value:product.segueModel];
        }
    }
}

- (void)dealloc {
    TCLog(@"RecommendProductAccountCenterView挂掉了...");
    [[RecommendDataManager shareRecommendDataManager] nilRecommendProdWithType:RecommendProductTypeUserCenter];
}

@end
