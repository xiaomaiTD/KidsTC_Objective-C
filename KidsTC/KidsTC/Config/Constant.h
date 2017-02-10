//
//  Constant.h
//  KidsTC
//
//  Created by zhanping on 7/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

//AppIDInAppStore
static NSString * const kAppIDInAppStore                   = @"1063632560";

//网页跳转app
static NSString *const kKidstcAppScheme                    = @"kidstcapp";
static NSString *const kKidstcAppOpenRage                  = @"com.kidstc/openPage";

//错误Key
static NSString *const kErrMsgKey                          = @"kErrMsgKey";

//微信跳转过来的流量统计
static NSString *const kWeiXinOTag                         = @"weixin_otag";
static NSString *const kWeixinOTagTime                     = @"weixin_otag_time";

//用户退出登录通知
static NSString *const kUserLogoutNotification             = @"UserLogoutNotification";
//用户角色修改通知
static NSString *const kRoleHasChangedNotification         = @"RoleHasChangedNotification";
//用户地理位置修改通知
static NSString *const kUserLocationHasChangedNotification = @"UserLocationHasChangedNotification";

//需要同步的数据的文件夹
static NSString *const kSynchronizedData                   = @"SynchronizedData";

//首页下拉刷活动--引导页面
static NSString *const kHomeViewControllerDidScroll        = @"HomeViewControllerDidScroll";
static NSString *const kHomeViewControllerDidEndDrag       = @"HomeViewControllerDidEndDrag";

//票务详情 - 想看
static NSString *const kProductDetaiTicketLike             = @"ProductDetaiTicketLike";

//门店 收藏/点赞
static NSString *const kTCStoreDetailCollect               = @"kTCStoreDetailCollect";

//倒计时
static NSString *const kTCCountDownNoti                    = @"kTCCountDownNoti";

//搜索关键字
static NSString *const kSearchKey_words                    = @"k";//搜索词
static NSString *const kSearchKey_area                     = @"s";//地区
static NSString *const kSearchKey_sort                     = @"st";//排序
static NSString *const kSearchKey_age                      = @"a";//年龄
static NSString *const kSearchKey_category                 = @"c";//分类
static NSString *const kSearchKey_populationType           = @"pt";//人群种类
