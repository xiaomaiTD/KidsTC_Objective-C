//
//  WholesaleOrderDetailV2InfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailV2InfoCell.h"
@interface WholesaleOrderDetailV2InfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIImageView *resultLog;
@end

@implementation WholesaleOrderDetailV2InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    WholesaleProductDetailBase *base = data.fightGroupBase;
    WolesaleProductDetailV2Data *detailV2 = base.detailV2;
    self.nameL.text = base.productName;
    self.subL.attributedText = detailV2.attPpromotionText;
    self.priceL.text = base.platFormPrice;
    self.timeL.text = detailV2.timeDesc;
    
    switch (data.openGroupStatus) {
        case FightGroupOpenGroupStatusOpenGroupSuccess:
        case FightGroupOpenGroupStatusJoinGroupSuccess:
        {
            self.resultLog.image = [UIImage imageNamed:@"wholesale_success_log_v2"];
            self.resultLog.hidden = NO;
        }
            break;
        case FightGroupOpenGroupStatusOpenGroupFailure:
        case FightGroupOpenGroupStatusJoinGroupFailure:
        {
            self.resultLog.image = [UIImage imageNamed:@"wholesale_failure_log_v2"];
            self.resultLog.hidden = NO;
        }
            break;
        default:
        {
            self.resultLog.hidden = YES;
        }
            break;
    }
}

@end
