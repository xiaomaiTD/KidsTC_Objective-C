//
//  NurseryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryCell.h"
#import "NurseryCollectionViewCell.h"
#import "NSString+Category.h"

static NSString *const ID = @"NurseryCollectionViewCell";

static CGFloat const imgMragin = 12;

@interface NurseryCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat item_s;

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *storeL;
@property (weak, nonatomic) IBOutlet UILabel *officeTimeL;
@property (weak, nonatomic) IBOutlet UILabel *facilitiesL;

@property (weak, nonatomic) IBOutlet UIButton *nearbyBtn;
@property (weak, nonatomic) IBOutlet UIButton *routeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HOneLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HTwoLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VOneLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VTwoLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VThreeLineH;
@end

@implementation NurseryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nearbyBtn.tag = NurseryCellActionTypeNearby;
    self.routeBtn.tag = NurseryCellActionTypeRoute;
    
    self.collectionView.userInteractionEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NurseryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.item_s = (SCREEN_WIDTH - 5*imgMragin)/4.5;
    self.collectionViewH.constant = self.item_s;
    
    self.HOneLineH.constant = LINE_H;
    self.HTwoLineH.constant = LINE_H;
    self.VOneLineH.constant = LINE_H;
    self.VTwoLineH.constant = LINE_H;
    self.VThreeLineH.constant = LINE_H;
    [self layoutIfNeeded];
    
}

- (void)setItem:(NurseryItem *)item {
    _item = item;
    [self.collectionView reloadData];
    
    self.nameL.text = item.name;
    self.distanceL.text = item.distanceDesc;
    self.storeL.text = [NSString stringWithFormat:@"商户(%zd)",item.storesTotal];
    self.officeTimeL.text = item.officeTimeDesc;
    self.facilitiesL.text = item.facilitiesDesc;
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(nurseryCell:actionType:value:)]) {
        [self.delegate nurseryCell:self actionType:sender.tag value:nil];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.item_s, self.item_s);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, imgMragin, 0, imgMragin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return imgMragin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return imgMragin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NurseryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.item.pictures.count) {
        cell.imgUrl = self.item.pictures[row];
    }
    return cell;
}

@end
