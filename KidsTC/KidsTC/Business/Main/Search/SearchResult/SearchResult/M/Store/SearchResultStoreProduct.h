//
//  SearchResultStoreProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

/*
 serveId	Integer	2015098101
 name	String	1记忆力系列课程（记忆训练先人一步，圆周率记忆法、PEG记忆法、连锁法记忆法、直观像记忆法、扑克牌记忆法）
 productType	Integer	3
 channelId	Integer	0
 productSearchType	Integer	1
 imgurl	String	http://img.kidstc.com/v1/img/T1LtETBmKT1RCvBVdK.png
 price	String	￥10
 */

@interface SearchResultStoreProduct : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SearchResultProductType productType;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) ProductDetailType productSearchType;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *price;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
