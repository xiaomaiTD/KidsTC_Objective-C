//
//  NormalProductDetailConsultModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailConsultItem.h"
@interface NormalProductDetailConsultModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<NormalProductDetailConsultItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
//selfDefine
@property (nonatomic, strong) NSArray<NormalProductDetailConsultItem *> *items;
@end
