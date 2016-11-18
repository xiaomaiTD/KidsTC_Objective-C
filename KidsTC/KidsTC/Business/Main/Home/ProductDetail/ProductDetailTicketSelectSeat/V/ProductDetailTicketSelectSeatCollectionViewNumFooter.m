//
//  ProductDetailTicketSelectSeatCollectionViewNumFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewNumFooter.h"
#import "Colours.h"
@interface ProductDetailTicketSelectSeatCollectionViewNumFooter ()
@property (weak, nonatomic) IBOutlet UIView *bgOne;
@property (weak, nonatomic) IBOutlet UIView *bgTwo;
@end

@implementation ProductDetailTicketSelectSeatCollectionViewNumFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgOne.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    self.bgTwo.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
}

@end
