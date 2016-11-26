//
//  AccountCenterActivitiesCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterActivitiesCell.h"
#import "AccountCenterActivitiesCollectionViewCell.h"

static NSString *ID = @"AccountCenterActivitiesCollectionViewCell";

@interface AccountCenterActivitiesCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<AccountCenterActivity *> *activities;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;

@end

@implementation AccountCenterActivitiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AccountCenterActivitiesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    _activities = self.model.data.config.activityExhibitionHall;
    
    if (_activities.count<=4) {
        _collectionViewH.constant = SCREEN_WIDTH/4.0;
    }else{
        _collectionViewH.constant = SCREEN_WIDTH/4.5;
    }
    [self layoutIfNeeded];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(size, size);
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
    return _activities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AccountCenterActivitiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<_activities.count) {
        cell.activity = _activities[row];
        cell.actionBlock = ^(SegueModel *segueModel){
            if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
                [self.delegate accountCenterBaseCell:self actionType:AccountCenterCellActionTypeSegue value:segueModel];
            }
        };
    }
    return cell;
}


@end
