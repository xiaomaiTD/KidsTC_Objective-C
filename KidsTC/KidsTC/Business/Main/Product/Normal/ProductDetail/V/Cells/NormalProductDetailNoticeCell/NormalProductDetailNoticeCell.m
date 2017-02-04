//
//  NormalProductDetailNoticeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailNoticeCell.h"
#import "NormalProductDetailNoticeCollectionCell.h"

static NSString *const ID = @"NormalProductDetailNoticeCollectionCell";

static int const columnCount = 4;
static int const item_w = 30;
static int const item_h = 57;
static int const margin_v = 16;

@interface NormalProductDetailNoticeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraintH;
@property (nonatomic, strong) NSArray<NormalProductDetailInsuranceItem *> *items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@property (nonatomic, assign) CGFloat margin_h;
@end

@implementation NormalProductDetailNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineH.constant = LINE_H;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NormalProductDetailNoticeCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self layoutIfNeeded];
    
    self.margin_h = (SCREEN_WIDTH - columnCount * item_w) / (columnCount + 1);
}

- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    
    self.items = data.insurance.items;
    int rowCount = ((int)self.items.count + columnCount - 1) / columnCount ;//按columnCount个一组来分，有几组
    self.collectionConstraintH.constant = (margin_v + item_h) * rowCount + margin_v;
    [self.collectionView reloadData];
    
    [self layoutIfNeeded];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(item_w, item_h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin_v, self.margin_h, margin_v, self.margin_h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin_v;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.margin_h;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalProductDetailNoticeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.items.count) {
        NormalProductDetailInsuranceItem *item = self.items[row];
        cell.item = item;
    }
    return cell;
}


@end
