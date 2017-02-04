//
//  FlashBuyProductDetailProgressCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailProgressCell.h"
#import "FlashBuyProductDetailProgressCollectionCell.h"

static NSString *CellID = @"FlashBuyProductDetailProgressCollectionCell";

@interface FlashBuyProductDetailProgressCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailPriceConfig *> *priceConfigs;
@end

@implementation FlashBuyProductDetailProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.margin = 15;
    [self.collectionView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailProgressCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    self.priceConfigs = data.priceConfigs;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.margin, 0, self.margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.priceConfigs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlashBuyProductDetailProgressCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.priceConfigs.count) {
        FlashBuyProductDetailPriceConfig *config = self.priceConfigs[row];
        cell.config = config;
    }
    return cell;
}


@end
