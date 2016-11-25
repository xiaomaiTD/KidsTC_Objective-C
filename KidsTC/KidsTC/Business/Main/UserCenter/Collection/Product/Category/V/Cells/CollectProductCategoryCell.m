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
static CGFloat const margin = 10;

@interface CollectProductCategoryCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baannerIconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@end

@implementation CollectProductCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    self.bannerIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bannerIcon.layer.borderWidth = LINE_H;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectProductCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    CGFloat item_w = (SCREEN_WIDTH - 7*margin)/4.5;
    self.collectionViewH.constant = item_w;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.numL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    [self layoutIfNeeded];
    
}

- (void)setItem:(CollectProductCategoryItem *)item {
    _item = item;
    self.nameL.text = item.categoryName;
    self.numL.text = [NSString stringWithFormat:@"%zd个活动",item.totalCount];
    [self.bannerIcon sd_setImageWithURL:[NSURL URLWithString:item.firstItem.img] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(size, size);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, 0, margin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectProductCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.item.items.count) {
        cell.imgUrl = self.item.items[row].img;
    }
    return cell;
}



@end
