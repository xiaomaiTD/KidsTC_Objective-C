//
//  TCStoreDetailNearbyFacilitiesCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyFacilitiesCell.h"

#import "TCStoreDetailNearbyFacilitiesCollectionCell.h"

static NSString *const ID = @"TCStoreDetailNearbyFacilitiesCollectionCell";

static int const columnCount = 3;
static int const item_h = 57;
static int const margin = 16;

@interface TCStoreDetailNearbyFacilitiesCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraintH;
@property (nonatomic, strong) NSArray<TCStoreDetailFacility *> *facilities;


@property (nonatomic, assign) CGFloat item_w;
@end

@implementation TCStoreDetailNearbyFacilitiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TCStoreDetailNearbyFacilitiesCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self layoutIfNeeded];
    
    self.item_w = (SCREEN_WIDTH - (columnCount+1) * margin) / columnCount;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    self.facilities = data.facilities;
    int rowCount = ((int)self.facilities.count + columnCount - 1) / columnCount ;//按columnCount个一组来分，有几组
    self.collectionConstraintH.constant = (margin + item_h) * rowCount + margin;
    [self.collectionView reloadData];
    
    [self layoutIfNeeded];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.item_w-1, item_h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.facilities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCStoreDetailNearbyFacilitiesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.facilities.count) {
        TCStoreDetailFacility *facility = self.facilities[row];
        cell.facility = facility;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row<self.facilities.count) {
        if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
            [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeFacility value:@(row)];
        }
    }
}

@end
