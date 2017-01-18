//
//  BuryPointTrackModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuryPointTrackData.h"
@interface BuryPointTrackModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) BuryPointTrackData *data;
@end
