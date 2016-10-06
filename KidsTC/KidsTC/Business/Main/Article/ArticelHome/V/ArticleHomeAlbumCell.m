//
//  ArticleHomeAlbumCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeAlbumCell.h"
#import "ArticleHomeAlbumCollectionViewCell.h"

#define CELL_MARGIN 8

static NSString *const ArticleHomeAlbumCollectionViewCellID = @"ArticleHomeAlbumCollectionViewCellID";

@interface ArticleHomeAlbumCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *coulmnTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintHeight;

@end

@implementation ArticleHomeAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coulmnTitleLabel.textColor = COLOR_PINK;
    _collectionView.scrollsToTop = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeAlbumCollectionViewCellID];
    
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.coulmnTitleLabel.text = item.columnTitle;
    self.collectionViewConstraintHeight.constant = (int)((CGRectGetWidth(self.collectionView.bounds)-3*CELL_MARGIN)/3.5);
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
    ArticleHomeAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleHomeAlbumCollectionViewCellID forIndexPath:indexPath];
    cell.imgUrl = self.item.imgPicUrls[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:self.item.segueModel];
    }
}

@end
