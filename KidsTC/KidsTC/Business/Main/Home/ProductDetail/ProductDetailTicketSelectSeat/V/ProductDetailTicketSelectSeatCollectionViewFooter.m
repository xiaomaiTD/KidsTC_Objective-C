//
//  ProductDetailTicketSelectSeatCollectionViewFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewFooter.h"
#import "Colours.h"
@interface ProductDetailTicketSelectSeatCollectionViewFooter ()
@property (weak, nonatomic) IBOutlet UILabel *bottomL;

@end

@implementation ProductDetailTicketSelectSeatCollectionViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bottomL.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
}

@end
