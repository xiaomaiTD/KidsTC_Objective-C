//
//  ActivityProductCouponsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCouponsCell.h"
#import "NSString+Category.h"

#import "ActivityProductCollectionCouponCell.h"
#import "ActivityProductCouponsFooter.h"

static NSString *const CouponCellID = @"ActivityProductCollectionCouponCell";
static NSString *const FooterViewID = @"ActivityProductCouponsFooter";

static CGFloat const item_margin = 10;

@interface ActivityProductCouponsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, strong) NSArray<ActivityProductCoupon *> *couponModels;
@property (nonatomic, assign) CGSize item_size;
@property (nonatomic, assign) CGSize head_size;
@property (nonatomic, assign) CGSize foot_size;
@property (nonatomic, assign) CGFloat bottom_margin;
@end

@implementation ActivityProductCouponsCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionCouponCell" bundle:nil] forCellWithReuseIdentifier:CouponCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCouponsFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterViewID];
    
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
        self.couponModels = content.couponModels;
        self.collectionView.backgroundColor = [UIColor colorFromHexString:content.floorBgc];
        [self setupSize:content];
    }
    [self.collectionView reloadData];
}

- (void)setupSize:(ActivityProductContent *)content {
    CGFloat item_w = 0;
    NSUInteger count = self.couponModels.count;
    if (count>0) {
        item_w = (SCREEN_WIDTH - (count+1)*item_margin)/count;
    }
    CGFloat ratio = 0;
    if (count == 1) {
        ratio = 0.21;
    }else if (count == 2) {
        ratio = 0.44;
    }else if (count == 3) {
        ratio = 0.69;
    }else if (count == 4) {
        ratio = 0.75;
    }
    self.item_size = CGSizeMake(item_w, item_w*ratio);
    self.head_size = CGSizeZero;
    if ([content.couponTips isNotNull]) {
        self.foot_size = CGSizeMake(SCREEN_WIDTH, 12);
        self.bottom_margin = item_margin;
    }else{
        self.foot_size = CGSizeZero;
        self.bottom_margin = 0;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.item_size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, item_margin, self.bottom_margin, item_margin);
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
    return self.foot_size;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.couponModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityProductCollectionCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CouponCellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.couponModels.count) {
        ActivityProductCoupon *coupon = self.couponModels[row];
        cell.coupon = coupon;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        ActivityProductCouponsFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterViewID forIndexPath:indexPath];
        footerView.content = self.content;
        return  footerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.couponModels.count) {
        ActivityProductCoupon *coupon = self.couponModels[row];
        if ([self.delegate respondsToSelector:@selector(activityProductBaseCell:actionType:value:)]) {
            [self.delegate activityProductBaseCell:self actionType:ActivityProductBaseCellActionTypeCoupon value:coupon];
        }
    }
}



@end
