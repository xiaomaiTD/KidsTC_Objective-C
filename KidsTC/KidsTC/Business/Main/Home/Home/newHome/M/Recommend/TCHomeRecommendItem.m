//
//  TCHomeRecommendItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeRecommendItem.h"

@implementation TCHomeRecommendItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *pid = [NSString stringWithFormat:@"%@",_serveId];
    NSString *cid = [NSString stringWithFormat:@"%@",_channelId];
    _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:@{@"pid":pid,@"cid":cid}];
    return YES;
}
- (TCHomeFloor *)conventToFloor {
    
    TCHomeFloorContent *content = [TCHomeFloorContent new];
    content.imageUrl = self.imgUrl;
    content.title = self.serveName;
    content.subTitle = self.promotionText;
    content.price = self.price;
    content.segueModel = self.segueModel;
    NSString *tipImgName = nil;
    switch (_reProductType) {
        case TCHomeRecommendProductTypeNew:
        {
            tipImgName = @"rec01";
        }
            break;
        case TCHomeRecommendProductTypeHot:
        {
            tipImgName = @"rec02";
        }
            break;
        case TCHomeRecommendProductTypePopularity:
        {
            tipImgName = @"rec03";
        }
            break;
    }
    content.tipImgName = tipImgName;
    
    TCHomeFloor *floor = [TCHomeFloor new];
    floor.contents = @[content];
    floor.ratio = self.picRate;
    floor.contentType = TCHomeFloorContentTypeRecommend;
    floor.marginTop = LINE_H;
    [floor modelCustomTransformFromDictionary:nil];
    return floor;
}
@end
