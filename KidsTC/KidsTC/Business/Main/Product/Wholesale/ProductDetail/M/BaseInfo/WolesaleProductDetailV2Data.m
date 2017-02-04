//
//  WolesaleProductDetailV2Data.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2Data.h"
#import "NSString+Category.h"
#import "NSAttributedString+YYText.h"

@implementation WolesaleProductDetailV2Data
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banners" : [NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _picRate = _picRate>0?_picRate:0.6;
    [self setupAttPpromotionText];
    return YES;
}

- (void)setupAttPpromotionText {
    if ([_promotionText isNotNull]) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_promotionText];
        attStr.lineSpacing = 4;
        attStr.color = [UIColor colorFromHexString:@"FF8888"];
        attStr.font = [UIFont systemFontOfSize:12];
        _attPpromotionText = [[NSAttributedString alloc] initWithAttributedString:attStr];
    }
}
@end
