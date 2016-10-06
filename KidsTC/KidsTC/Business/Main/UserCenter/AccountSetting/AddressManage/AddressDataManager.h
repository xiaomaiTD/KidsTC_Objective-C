//
//  AddressDataManager.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "AddressModel.h"
@interface AddressDataManager : NSObject
singleH(AddressDataManager)
@property (nonatomic, strong) AddressModel *model;

- (void)synchronize;
@end
