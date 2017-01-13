//
//  ActivityProductData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductData.h"

@implementation ActivityProductData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"floorItems":[ActivityProductFloorItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupShowItems];
    
    [self setupShareObj];
    
    return YES;
}

- (void)setupShowItems {
    NSMutableArray<ActivityProductFloorItem *> *showFloorItems = [NSMutableArray array];
    [self.floorItems enumerateObjectsUsingBlock:^(ActivityProductFloorItem *obj, NSUInteger idx, BOOL *stop) {
        
        NSUInteger count = obj.contents.count;
        
        switch (obj.contentType) {
            case ActivityProductContentTypeBanner://banner
            {
                if (count>0) {
                    [showFloorItems addObject:obj];
                }
            }
                break;
            case ActivityProductContentTypeCoupon://优惠券
            {
                if (count>0) {
                    ActivityProductContent *content = obj.contents.firstObject;
                    if (content.couponModels.count>0) {
                        [showFloorItems addObject:obj];
                    }
                }
            }
                break;
            case ActivityProductContentTypeLarge:
            case ActivityProductContentTypeSmall:
            case ActivityProductContentTypeMedium:
            {
                if (count>0) {
                    ActivityProductContent *content = obj.contents.firstObject;
                    if (content.productItems.count>0) {
                        [showFloorItems addObject:obj];
                    }
                }
            }
                break;
            case ActivityProductContentTypeCountDown:
            {
                if (count>0) {
                    ActivityProductContent *content = obj.contents.firstObject;
                    if (content.isShowCountDown && content.countDownValue>0) {
                        [showFloorItems addObject:obj];
                    }
                }
            }
                break;
            case ActivityProductContentTypeToolBar:
            {
                if (count>0) {
                    ActivityProductContent *content = obj.contents.firstObject;
                    if (content.tabItems.count>0) {
                        self.toolBarContent = content;
                    }
                }
            }
                break;
            case ActivityProductContentTypeSlider:
            {
                if (count>0) {
                    ActivityProductContent *content = obj.contents.firstObject;
                    if (content.tabItems.count>0) {
                        self.sliderContent = content;
                    }
                }
            }
                break;
            default:
                break;
        }
        
    }];
    self.showFloorItems = [NSArray arrayWithArray:showFloorItems];
}

- (void)setupShareObj {
    ActivityProductShare *shareInfo = self.shareInfo;
    self.shareObj = [CommonShareObject shareObjectWithTitle:shareInfo.title description:shareInfo.desc thumbImageUrl:[NSURL URLWithString:shareInfo.imgIcon] urlString:shareInfo.linkUrl];
}

@end
