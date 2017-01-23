//
//  FlashServiceOrderDetailProgressCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailProgressCell.h"
#import "FlashServiceOrderDetailProgressCollectionViewCell.h"

#define COLLECTIONVIEWCELL_ITEMSIZE 90

@interface FlashServiceOrderDetailProgressCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

static NSString *const ID = @"FlashServiceOrderDetailProgressCollectionViewCellID";

@implementation FlashServiceOrderDetailProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UINib *nib = [UINib nibWithNibName:@"FlashServiceOrderDetailProgressCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(COLLECTIONVIEWCELL_ITEMSIZE, COLLECTIONVIEWCELL_ITEMSIZE);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSUInteger count = self.data.priceConfigs.count;
    CGFloat margin = (SCREEN_WIDTH-count*COLLECTIONVIEWCELL_ITEMSIZE)/(count+1);
    if (margin<8) margin = 8;
    return UIEdgeInsetsMake(0, margin, 0, margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    NSUInteger count = self.data.priceConfigs.count;
    CGFloat margin = (SCREEN_WIDTH-count*COLLECTIONVIEWCELL_ITEMSIZE)/(count+1);
    if (margin<8) margin = 8;
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.priceConfigs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlashServiceOrderDetailProgressCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.config = self.data.priceConfigs[indexPath.item];
    return cell;
}

@end
