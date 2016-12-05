//
//  ProductOrderListAllTitle.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleView.h"

@interface ProductOrderListAllTitleView ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation ProductOrderListAllTitleView

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = _title;
}

- (IBAction)action:(UIButton *)sender {
    [self setupSelected];
    if (self.acitonBlock) {
        self.acitonBlock(sender.selected);
    }
}

- (void)setupSelected {
    self.btn.selected = !self.btn.selected;
    self.arrowImg.image = self.btn.selected?[UIImage imageNamed:@"ProductOrderList_all_arrow_up"]:[UIImage imageNamed:@"ProductOrderList_all_arrow_down"];
}

@end
