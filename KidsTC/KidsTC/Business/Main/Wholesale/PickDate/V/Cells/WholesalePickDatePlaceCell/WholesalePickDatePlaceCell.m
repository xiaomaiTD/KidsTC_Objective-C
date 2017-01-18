//
//  WholesalePickDatePlaceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDatePlaceCell.h"
#import "WholesalePickDatePlaceCollectionCell.h"

static NSString *CellID = @"WholesalePickDatePlaceCollectionCell";

@interface WholesalePickDatePlaceCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<WholesalePickDatePlace *> *places;
@property (nonatomic, strong) WholesalePickDatePlace *selectPlace;
@end

@implementation WholesalePickDatePlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WholesalePickDatePlaceCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    [self layoutIfNeeded];
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self layoutIfNeeded];
    return CGSizeMake(size.width, CGRectGetMinY(self.collectionView.frame) + self.collectionView.contentSize.height);
}

- (void)setSku:(WholesalePickDateSKU *)sku {
    [super setSku:sku];
    self.places = sku.places;
    [self.places enumerateObjectsUsingBlock:^(WholesalePickDatePlace *obj, NSUInteger idx, BOOL *stop) {
        if (obj.select) {
            self.selectPlace = obj;
            *stop = YES;
        }
    }];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH-30, 58);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 16, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.places.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WholesalePickDatePlaceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.places.count) {
        WholesalePickDatePlace *place = self.places[row];
        cell.place = place;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row<self.places.count) {
        WholesalePickDatePlace *place = self.places[row];
        [self toSelectPlace:place];
    }
}

- (void)toSelectPlace:(WholesalePickDatePlace *)place {
    self.selectPlace.select = NO;
    place.select = YES;
    self.selectPlace = place;
    [self.collectionView reloadData];
}

@end
