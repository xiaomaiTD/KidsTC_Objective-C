//
//  NormalProductDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailData.h"

@interface NormalProductDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NormalProductDetailData *data;
@end
