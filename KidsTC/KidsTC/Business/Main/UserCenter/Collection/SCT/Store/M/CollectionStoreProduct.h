//
//  CollectionStoreProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
/*
 productType	Integer	1
 channelId	Integer	0
 */
@interface CollectionStoreProduct : NSObject
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) NSString *channelId;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
