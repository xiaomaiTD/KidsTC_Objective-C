//
//  SearchFactorAreaView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaView.h"
#import "SearchFactorAreaCell.h"

static NSString *const kCellID = @"SearchFactorAreaCell";
static CGFloat const margin = 16;

@interface SearchFactorAreaView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<SearchFactorAreaDataItem *> *areas;

@property (nonatomic, weak) SearchFactorAreaDataItem *selectedItem;

@end

@implementation SearchFactorAreaView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchFactorAreaCell" bundle:nil] forCellWithReuseIdentifier:kCellID];
    
    _areas = [SearchFactorAreaDataManager shareSearchFactorAreaDataManager].areas;
    if (_areas.count>0) [self setupSelectItem:_areas.firstObject];
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
    CGFloat w = (SCREEN_WIDTH - 4 * margin - 4) / 3.0;
    return CGSizeMake(w, 28);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
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
            [self setupSelectItem:item];
        };
    }
    return cell;
}

- (void)setupSelectItem:(SearchFactorAreaDataItem *)item {
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    [self.collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(searchFactorAreaView:didSelectItem:)]) {
        [self.delegate searchFactorAreaView:self didSelectItem:_selectedItem];
    }
}

@end
