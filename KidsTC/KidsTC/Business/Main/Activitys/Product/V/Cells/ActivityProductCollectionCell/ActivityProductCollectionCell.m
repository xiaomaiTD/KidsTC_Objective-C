//
//  ActivityProductCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionCell.h"

#import "ActivityProductCollectionBaseCell.h"
#import "ActivityProductLargeCell.h"
#import "ActivityProductMediumCell.h"
#import "ActivityProductSmallCell.h"
#import "ActivityProductCouponCell.h"

#import "ActivityProductCollectionHeader.h"

static NSString *const BaseCellID = @"ActivityProductCollectionBaseCell";
static NSString *const LargeCellID = @"ActivityProductLargeCell";
static NSString *const MediumCellID = @"ActivityProductMediumCell";
static NSString *const SmallCellID = @"ActivityProductSmallCell";
static NSString *const CouponCellID = @"ActivityProductCouponCell";
static NSString *const HeaderViewID = @"ActivityProductCollectionHeader";

static CGFloat const item_margin = 10;

@interface ActivityProductCollectionCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, strong) NSArray<ActivityProductItem *> *productItems;
@property (nonatomic, assign) CGSize item_size;
@property (nonatomic, assign) CGSize head_size;
@property (nonatomic, assign) CGSize foot_size;
@end

@implementation ActivityProductCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionBaseCell" bundle:nil] forCellWithReuseIdentifier:BaseCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductLargeCell" bundle:nil] forCellWithReuseIdentifier:LargeCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductMediumCell" bundle:nil] forCellWithReuseIdentifier:MediumCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductSmallCell" bundle:nil] forCellWithReuseIdentifier:SmallCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCouponCell" bundle:nil] forCellWithReuseIdentifier:CouponCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    
    [self layoutIfNeeded];
}

- (CGSize)sizeThatFits:(CGSize)size {
    //[self.collectionView reloadData];
    [self layoutIfNeeded];
    return CGSizeMake(size.width, self.collectionView.contentSize.height);
}

- (void)setFloorItem:(ActivityProductFloorItem *)floorItem {
    [super setFloorItem:floorItem];
    NSArray<ActivityProductContent *> *contents = floorItem.contents;
    if (contents.count>0) {
        ActivityProductContent *content = contents.firstObject;
        self.content = content;
        self.productItems = content.productItems;
        self.collectionView.backgroundColor = [UIColor colorFromHexString:content.floorBgc];
        [self setupSize:content];
    }
    [self.collectionView reloadData];
}

- (void)setupSize:(ActivityProductContent *)content {
    switch (self.floorItem.contentType) {
        case ActivityProductContentTypeLarge:
        {
            CGFloat item_w = (SCREEN_WIDTH - 2*item_margin);
            self.item_size = CGSizeMake(item_w, 327);
            self.head_size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*content.floorTopPicRate);
        }
            break;
        case ActivityProductContentTypeMedium:
        {
            CGFloat item_w = (SCREEN_WIDTH - 3*item_margin)*0.5;
            self.item_size = CGSizeMake(item_w, item_w+95);
            self.head_size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*content.floorTopPicRate);
        }
            break;
        case ActivityProductContentTypeSmall:
        {
            CGFloat item_w = (SCREEN_WIDTH - 2*item_margin);
            self.item_size = CGSizeMake(item_w, 120);
            self.head_size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*content.floorTopPicRate);
        }
            break;
        case ActivityProductContentTypeCoupon:
        {
            CGFloat item_w = (SCREEN_WIDTH - 2*item_margin);
            self.item_size = CGSizeMake(item_w, 126);
            self.head_size = CGSizeZero;
        }
            break;
        default:
        {
            self.item_size = CGSizeMake(0, 0);
        }
            break;
    }
}

- (NSString *)cellIdWithType:(ActivityProductContentType)type {
    switch (type) {
        case ActivityProductContentTypeLarge:
        {
            return LargeCellID;
        }
            break;
        case ActivityProductContentTypeMedium:
        {
            return MediumCellID;
        }
            break;
        case ActivityProductContentTypeSmall:
        {
            return SmallCellID;
        }
            break;
        case ActivityProductContentTypeCoupon:
        {
            return CouponCellID;
        }
            break;
        default:
        {
            return BaseCellID;
        }
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.item_size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(item_margin, item_margin, item_margin, item_margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return item_margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return item_margin;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return self.head_size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [self cellIdWithType:self.floorItem.contentType];
    ActivityProductCollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.productItems.count) {
        ActivityProductItem *item = self.productItems[row];
        cell.item = item;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        ActivityProductCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderViewID forIndexPath:indexPath];
        headerView.content = self.content;
        return  headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.productItems.count) {
        ActivityProductItem *item = self.productItems[row];
        if ([self.delegate respondsToSelector:@selector(activityProductBaseCell:actionType:value:)]) {
            [self.delegate activityProductBaseCell:self actionType:ActivityProductBaseCellActionTypeSegue value:item.segueModel];
        }
    }
}



@end
