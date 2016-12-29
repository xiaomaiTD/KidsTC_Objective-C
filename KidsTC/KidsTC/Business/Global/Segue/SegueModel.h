//
//  SegueModel.h
//  KidsTC
//
//  Created by 钱烨 on 10/10/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
typedef enum {
    SegueDestinationNone                    = 0,     //无跳转
    SegueDestinationH5                      = 1,     //H5
    SegueDestinationNewsRecommend           = 2,     //资讯推荐列表(微信)
    SegueDestinationNewsList                = 3,     //资讯列表
    SegueDestinationActivity                = 4,     //活动页面
    SegueDestinationLoveHouse               = 5,     //爱心小屋
    SegueDestinationHospital                = 6,     //医院
    SegueDestinationStrategyList            = 7,     //攻略列表
    SegueDestinationServiceList             = 8,     //服务列表
    SegueDestinationStoreList               = 9,     //门店列表
    SegueDestinationServiceDetail           = 10,    //服务详情
    SegueDestinationStoreDetail             = 11,    //门店详情
    SegueDestinationStrategyDetail          = 12,    //攻略详情
    SegueDestinationCouponList              = 13,    //优惠券列表
    SegueDestinationOrderDetail             = 14,    //订单详情
    SegueDestinationOrderList               = 15,    //订单列表
    SegueDestinationFlashDetail             = 18,    //闪购详情
    SegueDestinationColumnList              = 19,    //栏目列表
    SegueDestinationColumnDetail            = 20,    //栏目详情
    SegueDestinationArticleAlbumn           = 21,    //资讯图集
    SegueDestinationStrategyTag             = 22,    //攻略标签
    SegueDestinationArticalComment          = 23,    //咨询评论
    SegueDestinationProductTicketDetail     = 24,    //票务商品详情
    SegueDestinationProductFreeDetail       = 25,    //免费商品详情
    SegueDestinationOrderTicketDetail       = 26,    //票务订单详情
    SegueDestinationOrderFreeDetail         = 27,    //免费订单详情
    SegueDestinationOrderWholesaleDetail    = 28,    //拼团详情、拼团订单详情
}SegueDestination;

//H5
extern NSString *const kSegueParameterKeyLinkUrl;

@interface SegueModel : Model

@property (nonatomic, readonly) SegueDestination destination;

@property (nonatomic, strong, readonly) NSDictionary *segueParam;

+ (instancetype)modelWithDestination:(SegueDestination)destination;

+ (instancetype)modelWithDestination:(SegueDestination)destination paramRawData:(NSDictionary *)data;

@end
