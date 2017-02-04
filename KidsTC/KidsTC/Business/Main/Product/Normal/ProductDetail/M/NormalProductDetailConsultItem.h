//
//  NormalProductDetailConsultItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailConsultItem : NSObject
@property (nonatomic, strong) NSString *sysNo;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<NormalProductDetailConsultItem *> *replies;
//selfDefine
@property (nonatomic, assign) BOOL isReply;//是否是回复信息
@end
