//
//  SearchFactorAreaDataItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFactorAreaDataItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL selected;
+(instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
@end
