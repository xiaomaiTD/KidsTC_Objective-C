//
//  CollectionStoreHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreHeader.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

#import "CollectionStoreHeaderCollectionViewCell.h"


static NSString *const ID = @"CollectionStoreHeaderCollectionViewCell";

static CGFloat const margin = 12;

@interface CollectionStoreHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoH;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat collectionViewCellW;
@end

@implementation CollectionStoreHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    
    self.enterBtn.layer.borderColor = COLOR_PINK.CGColor;
    self.enterBtn.layer.borderWidth = 1;
    self.enterBtn.layer.cornerRadius = 4;
    self.enterBtn.layer.masksToBounds = YES;
    [self.enterBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    
    self.lineOneH.constant = LINE_H;
    self.lineTwoH.constant = LINE_H;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionStoreHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    _collectionViewCellW = (SCREEN_WIDTH - 2*15 - 2*10) / 3;
    self.collectionViewH.constant = _collectionViewCellW * 0.48;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.numL.textColor = [UIColor colorFromHexString:@"888888"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
    [self layoutIfNeeded];
}

- (void)setItem:(CollectionStoreItem *)item {
    _item = item;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.storeImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = item.storeName;
    self.numL.text = [NSString stringWithFormat:@"销量 %@  收藏 %@",item.saleNum,item.interestNum];
    [self.collectionView reloadData];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    [self goToStoreAction];
}

- (IBAction)action:(UIButton *)sender {
    [self goToStoreAction];
}

- (void)goToStoreAction {
    if ([self.delegate respondsToSelector:@selector(collectionStoreHeader:actionType:value:)]) {
        [self.delegate collectionStoreHeader:self actionType:CollectionStoreHeaderActionTypeSegue value:self.item.segueModel];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self layoutIfNeeded];
    CGFloat h = self.collectionViewH.constant;
    CGFloat w = _collectionViewCellW;
    return CGSizeMake(w, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.item.couponModeLst.count>3) {
        return 3;
    }else{
        return self.item.couponModeLst.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionStoreHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSArray<CollectionStoreCoupon *> *couponModeLst = self.item.couponModeLst;
    if (row<couponModeLst.count) {
        CollectionStoreCoupon *coupon = couponModeLst[row];
        cell.coupon = coupon;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self goToStoreAction];
}


@end
