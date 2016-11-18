//
//  ProductDetailTicketActorCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketActorCell.h"
#import "ProductDetailTicketActorCollectionViewCell.h"

static NSString *const ID = @"ProductDetailTicketActorCollectionViewCell";
static CGFloat const margin = 15;

@interface ProductDetailTicketActorCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (nonatomic, assign) CGFloat item_w;
@property (nonatomic, assign) CGFloat item_h;
@end

@implementation ProductDetailTicketActorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketActorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    CGFloat imgRatio = 20/13.0;
    _item_w = (SCREEN_WIDTH - 5 * margin)/4.5;
    _item_h = _item_w * imgRatio + 79;
    self.collectionViewH.constant = _item_h;
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_item_w, _item_h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, 0, margin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.actors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailTicketActorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row<self.data.actors.count) {
        cell.actor = self.data.actors[indexPath.row];
    }
    return cell;
}

@end
