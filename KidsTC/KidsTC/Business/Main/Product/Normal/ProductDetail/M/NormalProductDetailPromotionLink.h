//
//  NormalProductDetailPromotionLink.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface NormalProductDetailPromotionLink : NSObject
@property (nonatomic, strong) NSString *linkKey;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
