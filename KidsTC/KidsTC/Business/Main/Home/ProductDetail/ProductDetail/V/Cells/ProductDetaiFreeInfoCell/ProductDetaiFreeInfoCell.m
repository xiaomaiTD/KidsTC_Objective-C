//
//  ProductDetaiFreeInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeInfoCell.h"


@interface ProductDetaiFreeInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *collectionNumL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *freeL;
@property (weak, nonatomic) IBOutlet UILabel *countTipL;
@end

@implementation ProductDetaiFreeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentL.textColor = [UIColor colorFromHexString:@"222222"];
    self.collectionNumL.textColor = [UIColor colorFromHexString:@"999999"];
    self.countL.textColor = [UIColor colorFromHexString:@"7EBCF2"];
    self.freeL.textColor = [UIColor colorFromHexString:@"F36863"];
    self.countTipL.textColor = [UIColor colorFromHexString:@"666666"];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    self.contentL.attributedText = data.attServeName;
    self.collectionNumL.text = [NSString stringWithFormat:@"%zd人关注",data.favorCount];
    self.countL.text = [NSString stringWithFormat:@"%zd",data.remainCount];
}

@end
