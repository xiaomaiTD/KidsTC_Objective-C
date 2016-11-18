//
//  ProductDetailTicketSelectSeatCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewCell.h"
#import "UIButton+Category.h"
#import "Colours.h"

@interface ProductDetailTicketSelectSeatCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTicketSelectSeatCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.titleLabel.numberOfLines = 0;
    self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btn.layer.borderWidth = 1;
    
    [self.btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateDisabled];
    [self.btn setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    
    [self.btn setTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor colorFromHexString:@"FFFFFF"] forState:UIControlStateSelected];
    [self.btn setTitleColor:[UIColor colorFromHexString:@"A9A9A9"] forState:UIControlStateDisabled];
}

- (IBAction)action:(UIButton *)sender {
    
}
@end
