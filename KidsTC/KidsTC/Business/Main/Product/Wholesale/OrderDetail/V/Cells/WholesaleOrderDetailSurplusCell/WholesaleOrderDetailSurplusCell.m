//
//  WholesaleOrderDetailSurplusCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailSurplusCell.h"

@interface WholesaleOrderDetailSurplusCell ()
@property (weak, nonatomic) IBOutlet UILabel *fullL;
@property (weak, nonatomic) IBOutlet UIView *surplusBGView;
@property (weak, nonatomic) IBOutlet UILabel *surplusL;

@end

@implementation WholesaleOrderDetailSurplusCell

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    
    if (data.surplusUserCount>0) {
        self.surplusBGView.hidden = NO;
        self.fullL.hidden = YES;
        self.surplusL.text = [NSString stringWithFormat:@"%zd",data.surplusUserCount];
    }else{
        self.surplusBGView.hidden = YES;
        self.fullL.hidden = NO;
    }
}


@end
