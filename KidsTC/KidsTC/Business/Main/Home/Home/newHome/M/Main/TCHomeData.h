//
//  TCHomeData.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeModule.h"
#import "TCHomeCategory.h"
#import "TCHomeFloor.h"

@interface TCHomeData : NSObject
@property (nonatomic, strong) NSArray<TCHomeModule *> *modules;
@property (nonatomic, strong) NSArray<TCHomeCategory *> *categorys;
/**SelfDefine*/
@property (nonatomic, strong) NSArray<TCHomeFloor *> *sections;
@end
