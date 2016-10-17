//
//  TCHomeCategory.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloor.h"

@interface TCHomeCategory : NSObject
@property (nonatomic, strong) NSString *sysNo;
@property (nonatomic, strong) NSString *name;
/**SelfDefine*/
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSArray<TCHomeFloor *> *floors;
@end
