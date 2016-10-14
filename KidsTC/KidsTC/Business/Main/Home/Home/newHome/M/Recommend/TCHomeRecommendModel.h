//
//  TCHomeRecommendModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeRecommendItem.h"
#import "TCHomeFloor.h"

@interface TCHomeRecommendModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSArray<TCHomeRecommendItem *> *data;
@property (nonatomic, assign) NSUInteger count;
/**SelfDefine*/
@property (nonatomic, strong) NSArray<TCHomeFloor *> *floors;
@end
