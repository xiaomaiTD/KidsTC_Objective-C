//
//  AreaAndAgeDataManager.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaAndAgeModel.h"
#import "GHeader.h"
@interface AreaAndAgeDataManager : NSObject
singleH(AreaAndAgeDataManager)
@property (nonatomic, strong) AreaAndAgeModel *model;
- (void)synchronize;
@end
