//
//  ProductOrderListAllTitleRowItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleRowItem.h"

@implementation ProductOrderListAllTitleRowItem
+(instancetype)itemWithType:(ProductOrderListAllTitleRowItemActionType)type {

    ProductOrderListAllTitleRowItem *item = [ProductOrderListAllTitleRowItem new];
    item.actionType = type;
    switch (type) {
        case ProductOrderListAllTitleRowItemActionTypeAll:
        {
            item.title = @"全部订单";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeCompleted:
        {
            item.title = @"已完成订单";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeCancled:
        {
            item.title = @"已取消订单";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeTicket:
        {
            item.title = @"票务";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeRealObject:
        {
            item.title = @"商品";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeActivity:
        {
            item.title = @"活动";
            item.canSelected = YES;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeFlash:
        {
            item.title = @"拼团";
            item.canSelected = NO;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeAppoinment:
        {
            item.title = @"我的预约";
            item.canSelected = NO;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeRadish:
        {
            item.title = @"萝卜兑换";
            item.canSelected = NO;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeLottery:
        {
            item.title = @"我的抽奖";
            item.canSelected = NO;
        }
            break;
        case ProductOrderListAllTitleRowItemActionTypeActivityRegister:
        {
            item.title = @"活动报名";
            item.canSelected = NO;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
    return item;
}
@end
