//
//  ArticleHomeAlbumEntrysCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeAlbumEntrysCell.h"
#import "ArticleHomeAlbumEntrysCollectionViewCell.h"

#define CELL_MARGIN 8
#define COLLECTIONVIEW_MARGIN 12

static NSString *const ArticleHomeAlbumEntrysCollectionViewCellID = @"ArticleHomeAlbumEntrysCollectionViewCellID";

@interface ArticleHomeAlbumEntrysCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintHeight;
@end

@implementation ArticleHomeAlbumEntrysCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _collectionView.scrollsToTop = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumEntrysCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ArticleHomeAlbumEntrysCollectionViewCellID];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.collectionViewConstraintHeight.constant = (int)((SCREEN_WIDTH-COLLECTIONVIEW_MARGIN*2-3*CELL_MARGIN)/3.5);
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
    return self.item.albumEntrys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ArticleHomeAlbumEntrysCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ArticleHomeAlbumEntrysCollectionViewCellID forIndexPath:indexPath];
    cell.imgUrl = self.item.albumEntrys[indexPath.row].imgUrl;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeAlbumEntry *albumEntry = self.item.albumEntrys[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:albumEntry.segueModel];
    }
}

@end
