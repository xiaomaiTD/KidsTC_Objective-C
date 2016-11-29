//
//  SearchFactorAreaView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaView.h"
#import "SearchFactorAreaHeader.h"
#import "SearchFactorAreaCell.h"


static NSString *const kHeadID = @"SearchFactorAreaHeader";
static NSString *const kCellID = @"SearchFactorAreaCell";

@interface SearchFactorAreaView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<SearchFactorAreaDataItem *> *areas;
@property (nonatomic, strong) SearchFactorAreaDataItem *headItem;

@property (nonatomic, weak) SearchFactorAreaDataItem *selectedItem;

@end

@implementation SearchFactorAreaView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _areas = [SearchFactorAreaDataManager shareSearchFactorAreaDataManager].areas;
    _headItem = [SearchFactorAreaDataManager shareSearchFactorAreaDataManager].headItem;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchFactorAreaHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeadID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchFactorAreaCell" bundle:nil] forCellWithReuseIdentifier:kCellID];
    
    [self layoutIfNeeded];
    
    [self.collectionView reloadData];
    
    [self selectItem:_headItem];
}

- (CGFloat)contentHeight {
    
    CGFloat height = self.collectionView.contentSize.height;
    CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - 2 * LINE_H) * 0.5;
    return CGSizeMake(w, 49);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return LINE_H;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return LINE_H;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 49);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _areas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchFactorAreaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<_areas.count) {
        cell.item = _areas[row];
        cell.actionBlock = ^(SearchFactorAreaDataItem *item){
            [self selectItem:item];
        };
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SearchFactorAreaHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeadID forIndexPath:indexPath];
        header.item = _headItem;
        header.actionBlock = ^(SearchFactorAreaDataItem *item){
            [self selectItem:item];
        };
        return header;
    }
    return nil;
}

- (void)selectItem:(SearchFactorAreaDataItem *)item {
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    [self.collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(searchFactorAreaView:didSelectItem:)]) {
        [self.delegate searchFactorAreaView:self didSelectItem:_selectedItem];
    }
}

@end
