//
//  CollectionStoreHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreHeader.h"
#import "CollectionStoreHeaderCollectionViewCell.h"

static NSString *const ID = @"CollectionStoreHeaderCollectionViewCell";

static CGFloat const margin = 12;

@interface CollectionStoreHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat collectionViewCellW;
@end

@implementation CollectionStoreHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.enterBtn.layer.borderColor = COLOR_PINK.CGColor;
    self.enterBtn.layer.borderWidth = 1;
    [self.enterBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    self.lineH.constant = LINE_H;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionStoreHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID
     ];
    _collectionViewCellW = (SCREEN_WIDTH - 4 * margin) / 3;
    self.collectionViewH.constant = _collectionViewCellW * 0.6;
    
    [self layoutIfNeeded];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self layoutIfNeeded];
    CGFloat h = self.collectionViewH.constant;
    CGFloat w = _collectionViewCellW;
    return CGSizeMake(w, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionStoreHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}



@end
