//
//  ProductDetailFreeApplySelectStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectStoreCell.h"
#import "FiveStarsView.h"

@interface ProductDetailFreeApplySelectStoreCell ()
@property (weak, nonatomic) IBOutlet UIView *shapeView;
@property (weak, nonatomic) IBOutlet UIView *itemsContentsView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *pickStoreDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@end

@implementation ProductDetailFreeApplySelectStoreCell

- (void)setStore:(ProductDetailStore *)store {
    _store = store;
    self.nameLabel.text = store.storeName;
    self.starsView.starNumber = store.level;
    //self.pickStoreDescLabel.attributedText = store.pickStoreDesc;
    self.checkImageView.hidden = !store.selected;
    self.shapeView.layer.borderColor = ([store.selected?COLOR_PINK:[UIColor lightGrayColor] colorWithAlphaComponent:0.3]).CGColor;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starsView.userInteractionEnabled = NO;
    self.shapeView.layer.cornerRadius = 4;
    self.shapeView.layer.masksToBounds = YES;
    self.shapeView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.shapeView.layer.borderWidth = LINE_H;
}


@end
