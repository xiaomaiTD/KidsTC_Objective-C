//
//  ComposeBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "Model.h"

typedef enum : NSUInteger {
    ComposeBtnIconTypeNone,//不显示图标
    ComposeBtnIconTypeLocal,//显示本地默认
    ComposeBtnIconTypeUrl,//显示Url
} ComposeBtnIconType;

@interface ComposeBtn : Model
@property (nonatomic, assign) ComposeBtnIconType iconCode;
@property (nonatomic, strong) NSString *iconUrl;
@end
