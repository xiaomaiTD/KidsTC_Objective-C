//
//  NSDictionary+Category.m
//  KidsTC
//
//  Created by zhanping on 7/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (NSString *)jsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (nil == registerData) {
            NSLog(@"Json encode error: %@", error);
            return nil;
        }
        return [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSDictionary*) parsetUrl:(NSString*)urlString
{
    if ([urlString length] == 0) {
        return nil;
    }
    NSString *questionSymbol = @"?";
    NSInteger index = [urlString rangeOfString:questionSymbol].location;
    if([urlString length] > index+1)
    {
        urlString = [urlString substringFromIndex:index+1];
    }
    NSString *connectSymbol = @"&";
    NSArray *arrayOfKeyValue = [urlString componentsSeparatedByString:connectSymbol];
    NSString *key = nil;
    NSString *value = nil;
    NSString *equalSymbol = @"=";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for(NSString *str in arrayOfKeyValue)
    {
        NSArray *array = [str componentsSeparatedByString:equalSymbol];
        if([array count] == 2)
        {
            key = [array objectAtIndex:0];
            value = [array objectAtIndex:1];
        }else if([array count] == 1)
        {
            key = [array objectAtIndex:0];
            value = @" ";
        }
        else if([array count]>2)
        {
            key = [array objectAtIndex:0];
            
            NSInteger equalSymbolIndex = [str rangeOfString:equalSymbol].location;
            if([str length] > equalSymbolIndex+1)
            {
                value = [str substringFromIndex:equalSymbolIndex+1];
            }
            else
            {
                value = @" ";
            }
        }
        else
        {
            key = @" ";
            value = @" ";
        }
        [dic setObject:value forKey:key];
    }
    if ([dic count] == 0) {
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:dic];
}

+ (NSDictionary *)dictionaryWithJson:(NSString *)json{
    if (json.length==0) return nil;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) return nil;
    return dic;
}
@end
