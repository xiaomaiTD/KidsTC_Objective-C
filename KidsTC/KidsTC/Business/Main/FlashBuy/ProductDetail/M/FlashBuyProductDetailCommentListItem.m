//
//  FlashBuyProductDetailCommentListItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailCommentListItem.h"
#import "NSString+Category.h"
#import "YYKit.h"

@implementation FlashBuyProductDetailCommentListItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"imageUrl":[NSArray<NSString *> class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupContent];
    
    return YES;
}

- (void)setupContent {
    if ([_content isNotNull]) {
        NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:_content];
        attContent.lineSpacing = 4;
        attContent.color = [UIColor colorFromHexString:@"#666666"];
        attContent.font = [UIFont systemFontOfSize:12];
        _attContent = [[NSAttributedString alloc] initWithAttributedString:attContent];
    }
}
@end
