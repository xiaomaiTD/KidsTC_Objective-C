//
//  TCStoreDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailData.h"

@interface TCStoreDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) TCStoreDetailData *data;
@end
