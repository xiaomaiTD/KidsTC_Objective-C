//
//  HeaderView.m
//  test2222
//
//  Created by 平 on 16/1/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation HeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
}
@end
