//
//  WholesaleOrderDetailProgressItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailProgressItemView.h"

@interface WholesaleOrderDetailProgressItemView ()
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *titleL;
@end

@implementation WholesaleOrderDetailProgressItemView

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    NSString *imageName = [NSString stringWithFormat:@"wholesale_progress_%zd_%@",self.tag,selected?@"h":@"n"];
    self.icon.image = [UIImage imageNamed:imageName];
    self.titleL.textColor = selected?[UIColor colorFromHexString:@"FF8888"]:[UIColor colorFromHexString:@"999999"];
}

@end
