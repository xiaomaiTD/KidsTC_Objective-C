//
//  NormalProductDetialCommentItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetialCommentItem.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"

@implementation NormalProductDetialCommentItem
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
