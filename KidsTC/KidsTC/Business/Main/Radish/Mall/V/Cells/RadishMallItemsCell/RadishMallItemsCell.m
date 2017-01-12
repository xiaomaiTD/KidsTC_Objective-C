//
//  RadishMallItemsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallItemsCell.h"

#import "RadishMallItemsCollectionCell.h"
#import "RadishMallThreeItemCollectionCell.h"

static NSString *ItemsCellID = @"RadishMallItemsCollectionCell";
static NSString *ThreeCellID = @"RadishMallThreeItemCollectionCell";

@interface RadishMallItemsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat margin_h;
@property (nonatomic, assign) CGFloat margin_v;
@end

@implementation RadishMallItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RadishMallItemsCollectionCell" bundle:nil] forCellWithReuseIdentifier:ItemsCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RadishMallThreeItemCollectionCell" bundle:nil] forCellWithReuseIdentifier:ThreeCellID];
}

- (void)setData:(RadishMallData *)data {
    [super setData:data];
    
    NSArray<RadishMallIcon *> *icons = self.data.icons;
    NSUInteger count = icons.count;
    
    if (count>3) {
        self.margin_h = 0;
        self.margin_v = 0;
        CGFloat item_h = CGRectGetHeight(self.bounds);
        CGFloat item_w = 0;
        if (count>4) {
            item_w = CGRectGetWidth(self.bounds)/4.5;
        }else{
            item_w = CGRectGetWidth(self.bounds)/4.0;
            self.itemSize = CGSizeMake(item_w, item_h);
        }
    }else{
        self.margin_h = 16;
        self.margin_v = 15;
        CGFloat item_h = 64;
        CGFloat item_w = (SCREEN_WIDTH-(count+1)*self.margin_h)/count;
        self.itemSize = CGSizeMake(item_w, item_h);
    }
    
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(self.margin_v, self.margin_h, self.margin_v, self.margin_h);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.margin_v;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.margin_h;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.icons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    NSArray<RadishMallIcon *> *icons = self.data.icons;
    NSUInteger count = icons.count;
    if (row<count) {
        RadishMallIcon *icon = icons[row];
        if (count>3) {
            RadishMallItemsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemsCellID forIndexPath:indexPath];
            cell.icon = icon;
            return cell;
        }else{
            RadishMallThreeItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThreeCellID forIndexPath:indexPath];
            cell.icon = icon;
            return cell;
        }
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:ItemsCellID forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    NSArray<RadishMallIcon *> *icons = self.data.icons;
    NSUInteger count = icons.count;
    if (row<count) {
        RadishMallIcon *icon = icons[row];
        if ([self.delegate respondsToSelector:@selector(radishMallBaseCell:actionType:value:)]) {
            [self.delegate radishMallBaseCell:self actionType:RadishMallBaseCellActionTypeSegue value:icon.segueModel];
        }
    }
}

@end
