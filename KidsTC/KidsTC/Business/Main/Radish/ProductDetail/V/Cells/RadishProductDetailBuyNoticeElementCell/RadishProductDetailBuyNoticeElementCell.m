//
//  RadishProductDetailBuyNoticeElementCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailBuyNoticeElementCell.h"

@interface RadishProductDetailBuyNoticeElementCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation RadishProductDetailBuyNoticeElementCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNotice:(RadishProductDetailNotice *)notice {
    _notice = notice;
    self.titleL.text = [NSString stringWithFormat:@"%@：",notice.clause];
    self.contentL.text = notice.notice;
}

@end
