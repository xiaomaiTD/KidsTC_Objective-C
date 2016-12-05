//
//  ProductOrderListAllTitleShowView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleShowView.h"
#import "NSString+Category.h"

#import "ProductOrderListAllTitleSectionItem.h"

#import "ProductOrderListAllTitleCollectionHeader.h"
#import "ProductOrderListAllTitleCollectionCell.h"

static NSString *const HeadID = @"ProductOrderListAllTitleCollectionHeader";
static NSString *const CellID = @"ProductOrderListAllTitleCollectionCell";

static CGFloat const kAnimationDuration = 0.3;

@interface ProductOrderListAllTitleShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewTop;
@property (nonatomic, strong) NSArray<ProductOrderListAllTitleSectionItem *> *sectionItems;
@property (nonatomic, strong) ProductOrderListAllTitleRowItem *currentRowItem;
@end

@implementation ProductOrderListAllTitleShowView

- (NSArray<ProductOrderListAllTitleSectionItem *> *)sectionItems {
    if (!_sectionItems) {
        _sectionItems = [ProductOrderListAllTitleSectionItem sectionItems];
    }
    return _sectionItems;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductOrderListAllTitleCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductOrderListAllTitleCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    
    self.collectionViewTop.constant = -self.collectionViewH.constant;
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    if (self.sectionItems.count>0) {
        NSArray<ProductOrderListAllTitleRowItem *> *rowItems = self.sectionItems.firstObject.rowItems;
        if (rowItems.count>0) {
            [self selectCurrentItem:rowItems.firstObject];
        }
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionViewH.constant = self.contentHeight;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(ProductOrderListAllTitleShowView:actionType:value:)]) {
        [self.delegate ProductOrderListAllTitleShowView:self actionType:ProductOrderListAllTitleShowViewActionTypeClose value:nil];
    }
}

- (CGFloat)contentHeight {
    CGFloat height = self.collectionView.contentSize.height;
    CGFloat maxHeight = (SCREEN_HEIGHT - 64) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

- (void)setOpen:(BOOL)open {
    _open = open;
    if (_open) {
        [self show];
    } else {
        [self hide];
    }
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.collectionViewTop.constant = - self.collectionViewH.constant;
        self.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.collectionViewTop.constant = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self layoutIfNeeded];
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - 2*15 - 2*10)/3.0;
    return CGSizeMake(w, 36);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(16, 15, 16, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 23;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section<self.sectionItems.count) {
        ProductOrderListAllTitleSectionItem *sectionItem = self.sectionItems[section];
        if ([sectionItem.title isNotNull]) {
            return CGSizeMake(SCREEN_WIDTH, 20);
        }
    }
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionItems.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section<self.sectionItems.count) {
        return self.sectionItems[section].rowItems.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductOrderListAllTitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListAllTitleCollectionCell" owner:self options:nil].firstObject;
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sectionItems.count) {
        NSArray<ProductOrderListAllTitleRowItem *> *rowItems = self.sectionItems[section].rowItems;
        if (row<rowItems.count) {
            ProductOrderListAllTitleRowItem *rowItem = rowItems[row];
            cell.item = rowItem;
            cell.actionBlock = ^(ProductOrderListAllTitleRowItem *item){
                if ([self.delegate respondsToSelector:@selector(ProductOrderListAllTitleShowView:actionType:value:)]) {
                    [self.delegate ProductOrderListAllTitleShowView:self actionType:(ProductOrderListAllTitleShowViewActionType)item.actionType value:item];
                }
                if(item.canSelected)[self selectCurrentItem:item];
            };
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ProductOrderListAllTitleCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeadID forIndexPath:indexPath];
        if (!header) {
            header = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListAllTitleCollectionHeader" owner:self options:nil].firstObject;
        }
        NSInteger section = indexPath.section;
        if (section<self.sectionItems.count) {
            ProductOrderListAllTitleSectionItem *sectionItem = self.sectionItems[section];
            header.title = sectionItem.title;
        }
        
        return header;
    }
    return [UICollectionReusableView new];
}

- (void)selectCurrentItem:(ProductOrderListAllTitleRowItem *)item {
    self.currentRowItem.selected = NO;
    item.selected = YES;
    self.currentRowItem = item;
    [self.collectionView reloadData];
}

@end
