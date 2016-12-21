//
//  RecommendProductSettlementResultView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProductSettlementResultView.h"
#import "RecommendDataManager.h"
#import "RecommendProductSettlementResultCell.h"

static NSString *const CellID = @"RecommendProductSettlementResultCell";

static CGFloat const margin = 8;

@interface RecommendProductSettlementResultView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation RecommendProductSettlementResultView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RecommendProductSettlementResultCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (void)setProducts:(NSArray<RecommendProduct *> *)products {
    [super setProducts:products];
    [self.collectionView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (RecommendProductType)recommendType {
    RecommendProductType recommendType = RecommendProductTypeNormal;
    switch (_productType) {
        case ProductDetailTypeTicket:
        {
            recommendType = RecommendProductTypeTicket;
        }
            break;
        case ProductDetailTypeFree:
        {
            recommendType = RecommendProductTypeFree;
        }
            break;
        default:
        {
            recommendType = RecommendProductTypeNormal;
        }
            break;
    }
    return recommendType;
}

- (void)reloadData {
    
    self.products = [[RecommendDataManager shareRecommendDataManager] recommendProductsWithType:self.recommendType];
}

- (CGFloat)contentHeight {
    CGFloat height = CGRectGetMinY(self.collectionView.frame) + self.collectionView.contentSize.height;
    return self.products.count>0? height:0.001;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - 3*margin) * 0.5;
    return CGSizeMake(w, w + 95);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, margin, margin);
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
    RecommendProductSettlementResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
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

- (void)nilData {
    [[RecommendDataManager shareRecommendDataManager] nilRecommendProdWithType:self.recommendType];
}

- (void)dealloc {
    [self nilData];
}
@end
