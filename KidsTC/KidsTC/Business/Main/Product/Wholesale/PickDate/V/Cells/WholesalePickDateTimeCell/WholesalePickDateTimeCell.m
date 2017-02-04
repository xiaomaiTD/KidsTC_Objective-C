//
//  WholesalePickDateTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateTimeCell.h"
#import "WholesalePickDateTimeCollectionCell.h"

static NSString *CellID = @"WholesalePickDateTimeCollectionCell";

@interface WholesalePickDateTimeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<WholesalePickDateTime *> *times;
@property (nonatomic, strong) WholesalePickDateTime *selectTime;
@end

@implementation WholesalePickDateTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WholesalePickDateTimeCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    [self layoutIfNeeded];
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self layoutIfNeeded];
    return CGSizeMake(size.width, CGRectGetMinY(self.collectionView.frame) + self.collectionView.contentSize.height);
}

- (void)setSku:(WholesalePickDateSKU *)sku {
    [super setSku:sku];
    self.times = sku.times;
    [self.collectionView reloadData];
    if (sku.isShowTime) {
        [self.times enumerateObjectsUsingBlock:^(WholesalePickDateTime * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.select) {
                self.selectTime = obj;
                *stop = YES;
            }
        }];
    }else{
        self.selectTime = nil;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH-30), 45);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 16, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.times.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WholesalePickDateTimeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.times.count) {
        WholesalePickDateTime *time = self.times[row];
        cell.time = time;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row<self.times.count) {
        WholesalePickDateTime *time = self.times[row];
        [self toSelectTime:time];
    }
}

- (void)toSelectTime:(WholesalePickDateTime *)time {
    self.selectTime.select = NO;
    time.select = YES;
    self.selectTime = time;
    [self.collectionView reloadData];
}

- (void)setSelectTime:(WholesalePickDateTime *)selectTime {
    _selectTime = selectTime;
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateBaseCell:actionType:vlaue:)]) {
        [self.delegate wholesalePickDateBaseCell:self actionType:WholesalePickDateBaseCellActionTypeSelectTiem vlaue:selectTime];
    }
}

@end
