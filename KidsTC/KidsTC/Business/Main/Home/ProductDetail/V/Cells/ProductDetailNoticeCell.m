//
//  ProductDetailNoticeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailNoticeCell.h"
#import "ProductDetailNoticeCollectionViewCell.h"

static NSString *const ID = @"ProductDetailNoticeCollectionViewCell";

static int const columnCount = 5;

@interface ProductDetailNoticeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraintH;
@property (nonatomic, strong) NSArray<ProductDetailInsuranceItem *> *items;
@end

@implementation ProductDetailNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailNoticeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    self.items = data.insurance.items;
    int rowCount = ((int)self.items.count + columnCount - 1) / columnCount ;//按columnCount个一组来分，有几组
    CGFloat itemSize = SCREEN_WIDTH / columnCount;
    self.collectionConstraintH.constant = itemSize * rowCount;
    [self.collectionView reloadData];
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemSize = SCREEN_WIDTH / columnCount;
    return CGSizeMake(itemSize, itemSize);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailNoticeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.items[indexPath.row];
    return cell;
}


@end
