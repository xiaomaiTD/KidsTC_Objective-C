//
//  ArticleHomeColumnTitleCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeColumnTitleCell.h"
#import "ArticleHomeColumnTitleCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

#define MARGING 12

static NSString *const ArticleHomeColumnTitleCollectionViewCellID = @"ArticleHomeColumnTitleCollectionViewCellID";

@interface ArticleHomeColumnTitleCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ArticleHomeColumnTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconImageView.layer.cornerRadius = 10;
    self.iconImageView.layer.masksToBounds = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeColumnTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeColumnTitleCollectionViewCellID];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.titleLabel.text = item.title;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = CGRectGetHeight(collectionView.bounds);
    CGFloat w = self.item.columnTags[indexPath.row].width;
    return CGSizeMake(w, h);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    __block CGFloat left=CGRectGetWidth(collectionView.bounds);
    [self.item.columnTags enumerateObjectsUsingBlock:^(ArticleHomeColumnTag *obj, NSUInteger idx, BOOL *stop) {
        left-=obj.width+MARGING;
    }];
    left += MARGING;
    
    return UIEdgeInsetsMake(0, left, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return MARGING;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return MARGING;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.columnTags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleHomeColumnTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleHomeColumnTitleCollectionViewCellID forIndexPath:indexPath];
    cell.title = self.item.columnTags[indexPath.row].title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeColumnTag *tag = self.item.columnTags[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:tag.segueModel];
    }
}
@end
