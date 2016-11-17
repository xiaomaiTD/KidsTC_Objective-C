//
//  ProductDetailNotice.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailNotice.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "Colours.h"

@implementation ProductDetailNotice
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _clause = [_clause isNotNull]?[NSString stringWithFormat:@"%@：",_clause]:@"";
    
    if ([_notice isNotNull]) {
        NSMutableAttributedString *attNotice = [[NSMutableAttributedString alloc] initWithString:_notice];
        attNotice.lineSpacing = 4;
        attNotice.color = [UIColor colorFromHexString:@"555555"];
        attNotice.font = [UIFont systemFontOfSize:14];
        _attNotice = [[NSAttributedString alloc] initWithAttributedString:attNotice];
    }
    
    return YES;
}
@end
