//
//  ProductDetailConsultItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProductDetailConsultItem : NSObject
@property (nonatomic, strong) NSString *sysNo;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *replies;
//selfDefine
@property (nonatomic, assign) BOOL isReply;//是否是回复信息
@end
