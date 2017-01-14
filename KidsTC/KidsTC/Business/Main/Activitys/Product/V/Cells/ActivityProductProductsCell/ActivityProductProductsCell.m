//
//  ActivityProductProductsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductProductsCell.h"

#import "ActivityProductCollectionBaseCell.h"
#import "ActivityProductCollectionLargeCell.h"
#import "ActivityProductCollectionMediumCell.h"
#import "ActivityProductCollectionSmallCell.h"

#import "ActivityProductProductsHeader.h"

static NSString *const BaseCellID = @"ActivityProductCollectionBaseCell";
static NSString *const LargeCellID = @"ActivityProductCollectionLargeCell";
static NSString *const MediumCellID = @"ActivityProductCollectionMediumCell";
static NSString *const SmallCellID = @"ActivityProductCollectionSmallCell";
static NSString *const HeaderViewID = @"ActivityProductProductsHeader";

static CGFloat const item_margin = 10;

@interface ActivityProductProductsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, strong) NSArray<ActivityProductItem *> *productItems;
@property (nonatomic, assign) CGSize item_size;
@property (nonatomic, assign) CGSize head_size;
@property (nonatomic, assign) CGSize foot_size;
@end

@implementation ActivityProductProductsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionBaseCell" bundle:nil] forCellWithReuseIdentifier:BaseCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionLargeCell" bundle:nil] forCellWithReuseIdentifier:LargeCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionMediumCell" bundle:nil] forCellWithReuseIdentifier:MediumCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionSmallCell" bundle:nil] forCellWithReuseIdentifier:SmallCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ActivityProductProductsHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    
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
            CGFloat item_h = 327;
            if (self.productItems.count>0) {
                ActivityProductItem *item = self.productItems.firstObject;
                item_h = item.ratio * item_w + 167;
            }
            self.item_size = CGSizeMake(item_w, item_h);
            self.head_size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*content.floorTopPicRate);
        }
            break;
        case ActivityProductContentTypeMedium:
        {
            CGFloat item_w = (SCREEN_WIDTH - 3*item_margin)*0.5;
            self.item_size = CGSizeMake(item_w, item_w+113);
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
        ActivityProductProductsHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderViewID forIndexPath:indexPath];
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
