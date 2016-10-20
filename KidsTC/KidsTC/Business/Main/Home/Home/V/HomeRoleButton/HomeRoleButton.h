//
//  HomeRoleButton.h
//  KidsTC
//
//  Created by zhanping on 8/2/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRoleButton : UIButton
+ (instancetype)btnWithImageName:(NSString *)imageName
                   highImageName:(NSString *)highImageName
                          target:(id)target
                          action:(SEL)action;
@end
