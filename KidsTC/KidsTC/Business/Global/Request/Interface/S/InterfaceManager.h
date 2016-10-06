//
//  InterfaceManager.h
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "InterfaceModel.h"
@interface InterfaceManager : NSObject
singleH(InterfaceManager)
- (void)synchronize;
- (InterfaceItem *)interfaceItemWithName:(NSString *)name;
@end
