//
//  ComposeMd5Data.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeData.h"

@interface ComposeMd5Data : Model
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) ComposeData *data;
@end
