//
//  WholesalePickDateTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateTitleCell.h"

@interface WholesalePickDateTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation WholesalePickDateTitleCell

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = self.title;
}

@end
