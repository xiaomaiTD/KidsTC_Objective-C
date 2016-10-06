//
//  SheetCell.m
//  jcjzwork
//
//  Created by 平 on 15/10/15.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "SheetCell.h"

@interface SheetCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation SheetCell

- (void)awakeFromNib {
    self.HLineConstraintHeight.constant = 1/[UIScreen mainScreen].scale;
}

@end
