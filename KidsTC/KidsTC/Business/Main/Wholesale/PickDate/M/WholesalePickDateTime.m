//
//  WholesalePickDateTime.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateTime.h"
#import "NSString+Category.h"
#import "YYKit.h"

@implementation WholesalePickDateTime
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_time isNotNull]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_time];
        str.color = [UIColor colorFromHexString:@"555555"];
        str.font = [UIFont systemFontOfSize:14];
        str.lineSpacing = 6;
        str.alignment = NSTextAlignmentCenter;
        self.attTimeStr = [[NSAttributedString alloc] initWithAttributedString:str];
    }else _time = @"";
    
    return YES;
}
@end
