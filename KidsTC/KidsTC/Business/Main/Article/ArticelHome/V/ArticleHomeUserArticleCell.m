//
//  ArticleHomeUserArticleCell.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeUserArticleCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"
#import "NSString+Category.h"
#import "ArticleHomeUserArticleCollectionViewCell.h"

#define ICON_H_INSETS 12
#define CELL_MARGIN 8

static NSString *const ArticleHomeUserArticleCollectionViewCellID = @"ArticleHomeUserArticleCollectionViewCellID";

@interface ArticleHomeUserArticleCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UILabel *brefContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintBottomMargin;
@end

@implementation ArticleHomeUserArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coulmnLabel.textColor = COLOR_PINK;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeUserArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeUserArticleCollectionViewCellID];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    
    self.coulmnLabel.text = item.columnTitle;
    self.brefContentLabel.attributedText = item.brifContentAttributeStr;
    self.titleLabel.attributedText = item.titleAttributeStr;
    self.bottomView.item = item;
    self.bottomView.hidden = ![item.authorName isNotNull];
    self.collectionViewConstraintBottomMargin.constant = self.bottomView.hidden?12:44;
    
    self.collectionViewConstraintHeight.constant = (int)((SCREEN_WIDTH-24-3*CELL_MARGIN)/3.5);
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(size, size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CELL_MARGIN;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.imgPicUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeUserArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleHomeUserArticleCollectionViewCellID forIndexPath:indexPath];
    cell.imgUrl = self.item.imgPicUrls[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:self.item.segueModel];
    }
}

@end
