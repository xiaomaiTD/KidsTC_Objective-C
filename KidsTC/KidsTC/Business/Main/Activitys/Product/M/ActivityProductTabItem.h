//
//  ActivityProductTabItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface ActivityProductTabItem : NSObject

@property (nonatomic, strong) NSString *tabName;

@property (nonatomic, strong) NSString *tabPicUrl;
@property (nonatomic, strong) NSString *tabSelPicUrl;
@property (nonatomic, assign) CGFloat tabWidthRate;
@property (nonatomic, assign) CGFloat tabHeight;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;//fid
@property (nonatomic, strong) NSString *tabId;

//selfDefine
@property (nonatomic, assign) BOOL select;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, assign) NSUInteger sectioinIndex;
@end
