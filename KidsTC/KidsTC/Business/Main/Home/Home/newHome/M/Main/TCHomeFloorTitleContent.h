//
//  TCHomeFloorTitleContent.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum {
    TCHomeFloorTitleContentTypeNormalTitle = 1,
    TCHomeFloorTitleContentTypeMoreTitle,
    TCHomeFloorTitleContentTypeCountDownTitle,
    TCHomeFloorTitleContentTypeCountDownMoreTitle
}TCHomeFloorTitleContentType;

@interface TCHomeFloorTitleContent : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subName;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, strong) NSString *remainName;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, assign) TCHomeFloorTitleContentType type;
@end
