//
//  WholesaleOrderListBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 /// <summary>
 /// 拼团按钮
 /// </summary>
 public enum FightGroupBtn
 {
 /// <summary>
 /// 在线客服
 /// </summary>
 ConnectService = 1,
 /// <summary>
 /// 邀请好友
 /// </summary>
 Invite = 2,
 /// <summary>
 /// 分享
 /// </summary>
 Share = 3,
 /// <summary>
 /// 支付
 /// </summary>
 Pay = 4
 }
 */

typedef enum : NSUInteger {
    WholesaleOrderListBtnTypeConnectService = 1,//在线客服
    WholesaleOrderListBtnTypeInvite = 2,//邀请好友
    WholesaleOrderListBtnTypeShare = 3,//分享
    WholesaleOrderListBtnTypePay = 4,//支付
    WholesaleOrderListBtnTypeConsumeCode = 5,//消费码
    WholesaleOrderListBtnTypeComment = 6,//评论
} WholesaleOrderListBtnType;

@interface WholesaleOrderListBtn : NSObject
@property (nonatomic, assign) WholesaleOrderListBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(WholesaleOrderListBtnType)type isHighLight:(BOOL)isHighLight;
@end
