//
//  FavouriteServiceItemModel.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "FavouriteServiceItemModel.h"
#import "NSString+Category.h"

@implementation FavouriteServiceItemModel

- (instancetype)initWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        if ([data objectForKey:@"serveId"]) {
            self.identifier = [NSString stringWithFormat:@"%@", [data objectForKey:@"serveId"]];
        }
        if ([data objectForKey:@"chId"]) {
            self.channelId = [NSString stringWithFormat:@"%@", [data objectForKey:@"chId"]];
        }
        NSString *imageurl = [NSString stringWithFormat:@"%@",[data objectForKey:@"imgurl"]];
        if ([imageurl isNotNull]) {
            self.imageUrl = [NSURL URLWithString:imageurl];
        }
        self.name = [data objectForKey:@"serveName"];
        self.starNumber = [[data objectForKey:@"level"] integerValue];
        self.price = [[data objectForKey:@"price"] floatValue];
    }
    return self;
}

@end
