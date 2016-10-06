//
//  SoftwareSettingModel.h
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoftwareSettingModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, assign) BOOL showArrow;
@property (nonatomic, assign) SEL sel;
+(instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle showArrow:(BOOL)showArrow sel:(SEL)sel;
@end
