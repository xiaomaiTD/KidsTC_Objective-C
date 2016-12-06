//
//  SearchHotKeyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeyCell.h"

#import "SearchHotKeyCollectionCell.h"

static NSString *const CellID = @"SearchHotKeyCollectionCell";

@interface SearchHotKeyCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SearchHotKeyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.VLineW.constant = LINE_H;
    self.HLineH.constant = LINE_H;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchHotKeyCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (void)setRowItem:(SearchRowItem *)rowItem {
    _rowItem = rowItem;
    self.icon.image = [UIImage imageNamed:rowItem.icon];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(110, CGRectGetHeight(collectionView.frame));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowItem.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchHotKeyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSArray<SearchHotKeywordsItem *> *items = self.rowItem.items;
    NSInteger row = indexPath.row;
    if (row<items.count) {
        SearchHotKeywordsItem *item = items[row];
        cell.item = item;
        cell.actionBlock = ^(SearchHotKeywordsItem *item){
            if (self.actionBlock) self.actionBlock(item);
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
