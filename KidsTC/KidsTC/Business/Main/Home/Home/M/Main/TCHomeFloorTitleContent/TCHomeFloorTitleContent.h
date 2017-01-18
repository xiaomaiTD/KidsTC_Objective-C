//
//  TCHomeFloorTitleContent.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
#import "TCHomeFloorTitleContentLayout.h"
#import "TCHomeFloorTitleContentShowpiece.h"

typedef enum {
    TCHomeFloorTitleContentTypeNormalTitle = 1,
    TCHomeFloorTitleContentTypeMoreTitle,
    TCHomeFloorTitleContentTypeCountDownTitle,
    TCHomeFloorTitleContentTypeCountDownMoreTitle,
    TCHomeFloorTitleContentTypeRecommend=1000
}TCHomeFloorTitleContentType;

@interface TCHomeFloorTitleContent : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subName;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, strong) NSString *remainName;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *titleIconUrl;
@property (nonatomic, strong) NSString *stageName;
@property (nonatomic, assign) CGFloat titleIconRatio;
//selfDefine
@property (nonatomic, assign) TCHomeFloorTitleContentType type;
@property (nonatomic, strong) TCHomeFloorTitleContentLayout *layout;
@property (nonatomic, strong) TCHomeFloorTitleContentShowpiece *showPiece;
@property (nonatomic, strong) SegueModel *segueModel;
- (void)setupAttributes;
@end
