//
//  ScoreProductItem.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

/*
 productNo	Integer	45
 channelId	Integer	0
 productImg	String	http://img.test.kidstc.com/v1/img/T1HRETBm_v1RCvBVdK.jpeg
 promotionText	String	正版芭比公主故事主题拍摄，正版托马斯小火车主题拍摄！
 picRate	String	0.6
 storePrice	String	￥55
 productName	String	2.3折！倍他漫想文化摄影国庆特惠！拍出最美的自己！
 price	String	￥10
 radishCount	Integer	0
 ageGroup	String	0~12岁
 discount	String	1.8折
 productRedirectType	Integer	4
 btnName	String	去参加
 joinDesc	String	2组成团
 */

@interface ScoreProductItem : NSObject
@property (nonatomic,strong) NSString *productNo;
@property (nonatomic,strong) NSString *channelId;
@property (nonatomic,strong) NSString *productImg;
@property (nonatomic,strong) NSString *promotionText;
@property (nonatomic,assign) CGFloat picRate;
@property (nonatomic,strong) NSString *storePrice;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *radishCount;
@property (nonatomic,strong) NSString *ageGroup;
@property (nonatomic,strong) NSString *discount;
@property (nonatomic,assign) ProductDetailType productRedirectType;
@property (nonatomic,strong) NSString *btnName;
@property (nonatomic,strong) NSString *joinDesc;
//selfDeine
@property (nonatomic,strong) SegueModel *segueModel;
@end
