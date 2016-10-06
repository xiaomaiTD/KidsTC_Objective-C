//
//  UserCenterModel.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserCenterModel.h"
#import "User.h"

@implementation UserCenterUserCount 

@end

@implementation UserCenterInvite 

@end

@implementation UserCenterRadish 

@end

@implementation UserCenterExHistory 

@end

@implementation UserCenterFsList 

@end

@implementation UserCenterUserInfo 

@end

@implementation UserCenterBannersItem 
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end

@implementation UserCenterProductLsItem 

@end

@implementation UserCenterHotProduct 
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"productLs" : [UserCenterProductLsItem class]};
}
@end

@implementation UserCenterConfig
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    CGFloat ratio = 140.0/320;
    if (_banners.count>0) {
        UserCenterBannersItem *bannersItem = _banners.firstObject;
        if (bannersItem.Ratio>0) ratio = bannersItem.Ratio;
    }
    _bannersHeight = ratio * SCREEN_WIDTH;
    
    _hotProductHeight = 30+((SCREEN_WIDTH-4*8)/3 +4+20+4)+8+10;
    
    return YES;
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"icons" : [NSString class],
             @"banners":[UserCenterBannersItem class]};
}
@end

@implementation UserCenterData 

@end

@implementation UserCenterModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
