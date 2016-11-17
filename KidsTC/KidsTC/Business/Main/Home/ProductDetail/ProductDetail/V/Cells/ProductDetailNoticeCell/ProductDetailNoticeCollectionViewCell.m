//
//  ProductDetailNoticeCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailNoticeCollectionViewCell.h"
#import "Colours.h"

@interface ProductDetailNoticeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation ProductDetailNoticeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleL.textColor = [UIColor colorFromHexString:@"222222"];
}

- (void)setItem:(ProductDetailInsuranceItem *)item {
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.imageName];
    self.titleL.text = item.title;
}

@end
