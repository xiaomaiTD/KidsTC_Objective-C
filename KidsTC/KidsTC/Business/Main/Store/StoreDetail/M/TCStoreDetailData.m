//
//  TCStoreDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailData.h"

@implementation TCStoreDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"facilities":[TCStoreDetailFacility class],
             @"storeGifts":[NSString class],
             @"coupons":[NSString class],
             @"comments":[TCStoreDetailCommentItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupShareObj:dic];
    
    return YES;
}

- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.title description:_share.desc thumbImageUrl:[NSURL URLWithString:_share.imgUrl] urlString:_share.linkUrl];
    if (self.shareObject) {
        self.shareObject.identifier = _storeBase.storeId;
        self.shareObject.followingContent = @"【童成】";
    }
}

@end
