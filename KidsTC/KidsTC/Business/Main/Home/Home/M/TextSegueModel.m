//
//  TextSegueModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TextSegueModel.h"
#import "NSString+Category.h"

@implementation TextSegueModel
- (instancetype)initWithLinkParam:(NSDictionary *)param promotionWords:(NSString *)words {
    if (!param || ![param isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    if (![words isKindOfClass:[NSString class]] || [words length] == 0) {
        return nil;
    }
    self = [super init];
    if (self) {
        _linkColor = [NSString colorWithString:[param objectForKey:@"color"]];
        if (!_linkColor) {
            _linkColor = [UIColor blueColor];
        }
        _promotionWords = words;
        _linkWords = [param objectForKey:@"linkKey"];
        _linkRangeStrings = [NSString rangeStringsOfSubString:self.linkWords inString:self.promotionWords];
        SegueDestination destination = (SegueDestination)[[param objectForKey:@"linkType"] integerValue];
        if (destination != SegueDestinationNone) {
            _segueModel = [SegueModel modelWithDestination:destination paramRawData:[param objectForKey:@"params"]];
        }
    }
    return self;
}
@end
