//
//  WholesaleProductDetailBase.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailBase.h"

@implementation WholesaleProductDetailBase
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"buyNotice" : [WholesaleProductDetailBuyNotice class],
             @"place":[WolesaleProductDetailPlace class],
             @"stores":[WholesaleProductDetailStoreItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupShareObj:dic];
    return YES;
}
- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.title
                                                   description:_share.descption
                                                 thumbImageUrl:[NSURL URLWithString:_share.img]
                                                     urlString:_share.url];
    if (self.shareObject) {
        self.shareObject.identifier = _productNo;
        self.shareObject.followingContent = @"【童成】";
    }
}
@end
