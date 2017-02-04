//
//  NormalProductDetailTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailTitleCell.h"

@interface NormalProductDetailTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation NormalProductDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleL.textColor = [UIColor colorFromHexString:@"222222"];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.titleL.text = text;
}

@end
