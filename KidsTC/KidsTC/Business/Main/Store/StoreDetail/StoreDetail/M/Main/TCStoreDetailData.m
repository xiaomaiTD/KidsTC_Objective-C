//
//  TCStoreDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailData.h"
#import "NSString+Category.h"

@implementation TCStoreDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"facilities":[TCStoreDetailFacility class],
             @"storeGifts":[NSString class],
             @"coupons":[TCStoreDetailCoupon class],
             @"comments":[TCStoreDetailCommentItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupShareObj:dic];
    [self setupCommentList:dic];
    [self setupHasColumns];
    [self setupActiveModelsArray];
    [self setupNearbyFacilities:dic];
    return YES;
}

- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.title description:_share.desc thumbImageUrl:[NSURL URLWithString:_share.imgUrl] urlString:_share.linkUrl];
    if (self.shareObject) {
        self.shareObject.identifier = _storeBase.storeId;
        self.shareObject.followingContent = @"【童成】";
    }
}

- (void)setupCommentList:(NSDictionary *)data {
    NSArray *commentsArray = [data objectForKey:@"comments"];
    NSMutableArray *commentItemsTempArray = [[NSMutableArray alloc] init];
    if ([commentsArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *singleDic in commentsArray) {
            CommentListItemModel *item = [[CommentListItemModel alloc] initWithRawData:singleDic];
            [commentItemsTempArray addObject:item];
        }
    }
    self.commentItemsArray = [NSArray arrayWithArray:commentItemsTempArray];
}

- (void)setupHasColumns {
    if ([_storeBase.detailUrl isNotNull] || _comments.count>0 || _facilities.count>0) {
        self.hasColumn = YES;
        NSMutableArray<TCStoreDetailColumn *> *columns = [NSMutableArray new];
        if ([_storeBase.detailUrl isNotNull]) {
            TCStoreDetailColumn *column = [TCStoreDetailColumn columnWithType:TCStoreDetailColumnColumnTypeWebDetail title:@"商户环境" select:YES indexPath:nil];
            if (column) [columns addObject:column];
        }
        
        TCStoreDetailColumn *column = [TCStoreDetailColumn columnWithType:TCStoreDetailColumnColumnTypeComment title:@"网友评论" select:NO indexPath:nil];
        if (column) [columns addObject:column];
        
        if (_facilities.count>0) {
            TCStoreDetailColumn *column = [TCStoreDetailColumn columnWithType:TCStoreDetailColumnColumnTypeFacility title:@"商户周边" select:NO indexPath:nil];
            if (column) [columns addObject:column];
        }
        _columns = [NSArray arrayWithArray:columns];
    }
}

- (void)setupActiveModelsArray {
    NSMutableArray *ary = [NSMutableArray array];
    [self.storeGifts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ActivityLogoItem *item = [[ActivityLogoItem alloc] initWithType:ActivityLogoItemTypeGift description:obj];
        if (item) [ary addObject:item];
    }];
    self.activeModelsArray = [NSArray arrayWithArray:ary];
}

- (void)setupNearbyFacilities:(NSDictionary *)data {
    NSArray *nearbys = [data objectForKey:@"facilities"];
    if ([nearbys isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *nearbyDic in nearbys) {
            StoreDetailNearbyModel *model = [[StoreDetailNearbyModel alloc] initWithRawData:nearbyDic];
            if (model) {
                [tempArray addObject:model];
            }
        }
        self.nearbyFacilities = [NSArray arrayWithArray:tempArray];
    }
}
@end
