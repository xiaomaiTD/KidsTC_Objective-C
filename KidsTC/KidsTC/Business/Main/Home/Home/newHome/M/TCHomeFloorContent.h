//
//  TCHomeFloorContent.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
#import "TCHomeFloorContentArticleParam.h"

@interface TCHomeFloorContent : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) TCHomeFloorContentArticleParam *articleParam;
//以下三个属性只有当TCHomeFloor的contentType为13的时候才会有
@property (nonatomic, strong) NSString *subTitle;//右描述
@property (nonatomic, strong) NSString *linkKey;//文字
@property (nonatomic, strong) NSString *color;//linkKey的字体颜色
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
