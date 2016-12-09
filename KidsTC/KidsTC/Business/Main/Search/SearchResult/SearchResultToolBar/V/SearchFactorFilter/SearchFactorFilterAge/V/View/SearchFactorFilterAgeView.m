//
//  SearchFactorFilterAgeView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterAgeView.h"
#import "NSString+Category.h"

#import "SearchFactorFilterAgeCell.h"

static NSString *const CellID = @"SearchFactorFilterAgeCell";
static CGFloat const margin = 16;

@interface SearchFactorFilterAgeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<SearchFactorFilterAgeItem *> *items;
@end

@implementation SearchFactorFilterAgeView

- (NSArray<SearchFactorFilterAgeItem *> *)items {
    if (!_items) {
        _items = [SearchFactorFilterAgeItem items];
    } return _items;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchFactorFilterAgeCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (CGFloat)contentHeight {
    if (_items.count>0) {
        return self.collectionView.contentSize.height + CGRectGetMinY(self.collectionView.frame);
    }else{
        return 0;
    }
}

- (void)clean {
    [self.items enumerateObjectsUsingBlock:^(SearchFactorFilterAgeItem *obj, NSUInteger idx, BOOL *stop) {
        obj.cellSelected = NO;
    }];
    [self.collectionView reloadData];
}

- (void)sure {
    [self.items enumerateObjectsUsingBlock:^(SearchFactorFilterAgeItem *obj, NSUInteger idx, BOOL *stop) {
        obj.dataSelected = obj.cellSelected;
    }];
    [self.collectionView reloadData];
}

- (void)reset {
    [self.items enumerateObjectsUsingBlock:^(SearchFactorFilterAgeItem *obj, NSUInteger idx, BOOL *stop) {
        obj.cellSelected = obj.dataSelected;
        if (obj.dataSelected) {
            self.cellSelectedItem = obj;
        }
    }];
    [self.collectionView reloadData];
}

- (void)setInsetParam:(NSDictionary *)insetParam {
    _insetParam = insetParam;
    if (self.cellSelectedItem) {
        self.cellSelectedItem.cellSelected = NO;
        self.cellSelectedItem.dataSelected = NO;
        self.cellSelectedItem = nil;
        [self.collectionView reloadData];
    }
    NSString *age = [NSString stringWithFormat:@"%@",insetParam[kSearchKey_age]];
    if ([age isNotNull]) {
        [self.items enumerateObjectsUsingBlock:^(SearchFactorFilterAgeItem *obj, NSUInteger idx, BOOL *stop) {
            if ([age isEqualToString:obj.value]) {
                obj.cellSelected = YES;
                obj.dataSelected = YES;
                self.cellSelectedItem = obj;
            }
        }];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - 5*margin - 5)/4.0;
    return CGSizeMake(w, 28);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin-2, margin, margin, margin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchFactorFilterAgeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        cell.item = self.items[row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        SearchFactorFilterAgeItem *item = self.items[row];
        [self setupSelectedItem:item];
    }
}

- (void)setupSelectedItem:(SearchFactorFilterAgeItem *)item {
    if (item == self.cellSelectedItem) {
        item.cellSelected = !item.cellSelected;
    }else{
        self.cellSelectedItem.cellSelected = NO;
        item.cellSelected = YES;
        self.cellSelectedItem = item;
    }
    [self.collectionView reloadData];
}

@end
