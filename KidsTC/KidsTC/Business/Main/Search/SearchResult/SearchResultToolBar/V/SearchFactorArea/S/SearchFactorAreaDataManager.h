//
//  SearchFactorAreaDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaAndAgeDataManager.h"
#import "SearchFactorAreaDataItem.h"
#import "Single.h"

@interface SearchFactorAreaDataManager : NSObject
singleH(SearchFactorAreaDataManager)
@property (nonatomic, strong) NSArray<SearchFactorAreaDataItem *> *areas;
@property (nonatomic, strong) SearchFactorAreaDataItem *headItem;
@end
