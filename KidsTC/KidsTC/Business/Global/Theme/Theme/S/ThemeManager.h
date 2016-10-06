//
//  ThemeManager.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "Theme.h"

@interface ThemeManager : NSObject
singleH(ThemeManager)
@property (nonatomic, strong) Theme *theme;
- (void)synchronize;
@end
