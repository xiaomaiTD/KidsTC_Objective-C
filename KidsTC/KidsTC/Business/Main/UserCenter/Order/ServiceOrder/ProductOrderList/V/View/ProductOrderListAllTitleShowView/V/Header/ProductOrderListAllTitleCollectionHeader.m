//
//  ProductOrderListAllTitleCollectionHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleCollectionHeader.h"

@interface ProductOrderListAllTitleCollectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation ProductOrderListAllTitleCollectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineH.constant = LINE_H;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}

@end
