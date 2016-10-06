//
//  NSDictionary+Category.h
//  KidsTC
//
//  Created by zhanping on 7/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)
- (NSString *)jsonString;
+ (NSDictionary*) parsetUrl:(NSString*)urlString;
+ (NSDictionary *)dictionaryWithJson:(NSString *)json;
@end
