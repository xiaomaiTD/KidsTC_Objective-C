//
//  GetUserPopulationModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserPopulationData : NSObject
@property (nonatomic, assign) NSInteger BabyAgeType;
@property (nonatomic, assign) NSInteger BabySex;
@property (nonatomic, assign) NSInteger WirelessPopulationType;
@end

@interface GetUserPopulationModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) GetUserPopulationData *data;
@end
