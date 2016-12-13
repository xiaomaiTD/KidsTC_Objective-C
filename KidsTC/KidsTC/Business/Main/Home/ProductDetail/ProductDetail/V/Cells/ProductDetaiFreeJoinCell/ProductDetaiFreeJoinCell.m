//
//  ProductDetaiFreeJoinCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeJoinCell.h"
#import "ProductDetaiFreeJoinCollectionCell.h"

static NSString *const CellID = @"ProductDetaiFreeJoinCollectionCell";

@interface ProductDetaiFreeJoinCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat itemSize;
@end

@implementation ProductDetaiFreeJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.itemSize = (SCREEN_WIDTH - 15*2 - 4*21)/5;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetaiFreeJoinCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    [self.collectionView reloadData];
    
    int groupNum = ((int)self.data.joinMember.count + 5 - 1) / 5 ;
    self.collectionViewH.constant = groupNum*(self.itemSize + 20) -20;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemSize, self.itemSize);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.joinMember.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetaiFreeJoinCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row<self.data.joinMember.count) {
        cell.imageUrl = self.data.joinMember[row];
    }
    return cell;
}

@end
