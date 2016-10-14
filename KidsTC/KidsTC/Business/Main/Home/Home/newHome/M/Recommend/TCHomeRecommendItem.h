//
//  TCHomeRecommendItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloorContent.h"
#import "TCHomeFloor.h"

@interface TCHomeRecommendItem : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *channelId;
//@property (nonatomic, assign) <#type#> reProductType;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, strong) NSString *promotionText;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
- (TCHomeFloor *)conventToFloor;
@end
