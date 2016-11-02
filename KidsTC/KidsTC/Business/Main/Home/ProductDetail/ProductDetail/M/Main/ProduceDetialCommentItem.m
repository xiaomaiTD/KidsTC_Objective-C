
//
//  ProduceDetialCommentItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProduceDetialCommentItem.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "Colours.h"

@implementation ProduceDetialCommentItem
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
        attContent.lineSpacing = 6;
        attContent.color = [UIColor colorFromHexString:@"#666666"];
        attContent.font = [UIFont systemFontOfSize:19];
        _attContent = [[NSAttributedString alloc] initWithAttributedString:attContent];
    }
}
@end
