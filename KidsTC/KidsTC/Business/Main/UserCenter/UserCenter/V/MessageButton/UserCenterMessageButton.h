//
//  UserCenterMessageButton.h
//  KidsTC
//
//  Created by 詹平 on 16/7/28.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "TipButton.h"

@interface UserCenterMessageButton : TipButton

+ (instancetype)btnWithImageName:(NSString *)imageName
                   highImageName:(NSString *)highImageName
                          target:(id)target
                          action:(SEL)action;
@end
