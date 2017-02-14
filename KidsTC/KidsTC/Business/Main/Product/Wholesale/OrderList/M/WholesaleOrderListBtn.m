//
//  WholesaleOrderListBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListBtn.h"
#import "Colours.h"

@implementation WholesaleOrderListBtn

+ (instancetype)btnWithType:(WholesaleOrderListBtnType)type isHighLight:(BOOL)isHighLight {
    WholesaleOrderListBtn *btn = [WholesaleOrderListBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case WholesaleOrderListBtnTypeConnectService:
        {
            btn.title = @"在线客服";
        }
            break;
        case WholesaleOrderListBtnTypeInvite:
        {
            btn.title = @"邀请好友";
        }
            break;
        case WholesaleOrderListBtnTypeShare:
        {
            btn.title = @"分享";
        }
            break;
        case WholesaleOrderListBtnTypePay:
        {
            btn.title = @"支付";
        }
            break;
        case WholesaleOrderListBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case WholesaleOrderListBtnTypeComment:
        {
            btn.title = @"评价";
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
    return btn;
}

@end
