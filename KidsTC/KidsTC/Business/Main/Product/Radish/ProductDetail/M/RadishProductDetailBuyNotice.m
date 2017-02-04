//
//  RadishProductDetailBuyNotice.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailBuyNotice.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"

@implementation RadishProductDetailBuyNotice
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"notice":[RadishProductDetailNotice class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _title = [_title isNotNull]?_title:@"";
    
    return YES;
}

@end
