//
//  ProductDetailTicketSelectSeatCollectionViewHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewHeader.h"

@interface ProductDetailTicketSelectSeatCollectionViewHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation ProductDetailTicketSelectSeatCollectionViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setTitle:(NSString *)title {

    _title = title;
    self.titleL.text = title;
}

@end
