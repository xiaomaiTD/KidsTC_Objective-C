//
//  CookieManager.h
//  KidsTC
//
//  Created by zhanping on 4/8/16.
//  Copyright © 2016 ping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
@interface CookieManager : NSObject
singleH(CookieManager)
- (void)setCookies;
- (void)setCookieWithName:(NSString *)name andValue:(NSString *)value;
- (void)deleteCookieWithName:(NSString *)name;
@end
