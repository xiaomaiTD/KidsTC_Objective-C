//
//  VideoPlayVideoRes.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "VideoPlayVideoRes.h"
#import "NSString+Category.h"

@implementation VideoPlayVideoRes
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productVideos":[VideoPlayVideo class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupVideos];
    return YES;
}
- (void)setupVideos {
    NSMutableArray *videos = [NSMutableArray array];
    [self.productVideos enumerateObjectsUsingBlock:^(VideoPlayVideo *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.videoUrl isNotNull]) {
            [videos addObject:obj];
        }
    }];
    self.productVideos = [NSArray arrayWithArray:videos];
}
@end
