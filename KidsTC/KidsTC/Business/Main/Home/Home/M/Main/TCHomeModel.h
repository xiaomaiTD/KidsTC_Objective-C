//
//  TCHomeModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeData.h"

@interface TCHomeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) TCHomeData *data;
@property (nonatomic, strong) NSString *md5;
@end
