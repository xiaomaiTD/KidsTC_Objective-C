//
//  CollectProductCategoryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryCell.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

#import "CollectProductCategoryCollectionViewCell.h"

static NSString *const ID = @"CollectProductCategoryCollectionViewCell";
static CGFloat const margin_lefe_right = 10;
static CGFloat const margin_top_bottom = 16;

@interface CollectProductCategoryCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baannerIconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat item_s;
@end

@implementation CollectProductCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectProductCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    _item_s = (SCREEN_WIDTH - 7*margin_lefe_right)/4.5;
    self.collectionViewH.constant = _item_s + margin_top_bottom * 2;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.numL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    
    self.bannerIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bannerIcon addGestureRecognizer:iconTapGR];
    
    [self layoutIfNeeded];
    
}

- (void)setItem:(CollectProductCategoryItem *)item {
    _item = item;
    self.nameL.text = item.categoryName;
    self.numL.text = [NSString stringWithFormat:@"%zd个活动",item.totalCount];
    [self.bannerIcon sd_setImageWithURL:[NSURL URLWithString:item.firstItem.img] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.baannerIconH.constant = CGRectGetWidth(self.bannerIcon.frame) * _item.firstItem.imgRatio;
    
    CGFloat collectionViewH = 0;
    if (self.item.items.count>0) {
        collectionViewH = _item_s + margin_top_bottom * 2;
    }
    self.collectionViewH.constant = collectionViewH;
    //[self layoutIfNeeded];
    
    [self.collectionView reloadData];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(collectProductCategoryCell:actionType:value:)]) {
        [self.delegate collectProductCategoryCell:self actionType:CollectProductCategoryCellActionTypeSegue value:self.item.firstItem.segueModel];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_item_s, _item_s);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin_top_bottom, margin_lefe_right, margin_top_bottom, margin_lefe_right);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin_lefe_right;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin_lefe_right;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectProductCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSArray<CollectProductItem *> *items = self.item.items;
    if (row<items.count) {
        cell.imgUrl = items[row].img;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    NSArray<CollectProductItem *> *items = self.item.items;
    if (row<items.count) {
        CollectProductItem *item = items[row];
        if ([self.delegate respondsToSelector:@selector(collectProductCategoryCell:actionType:value:)]) {
            [self.delegate collectProductCategoryCell:self actionType:CollectProductCategoryCellActionTypeSegue value:item.segueModel];
        }
    }
}


@end
