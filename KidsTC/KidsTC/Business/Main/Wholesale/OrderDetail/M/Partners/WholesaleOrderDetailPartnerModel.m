//
//  WholesaleOrderDetailPartnerModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailPartnerModel.h"

@implementation WholesaleOrderDetailPartnerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[WholesaleOrderDetailPartner class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupCounts];
    return YES;
}

- (void)setupCounts {
    NSInteger pageSize = 5;
    NSInteger numberOfPage = (_count + pageSize - 1 ) / pageSize;
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger i = 0; i<numberOfPage; i++) {
        NSString *title = [NSString stringWithFormat:@"%zd~%zd",(1+i*pageSize),(pageSize+i*pageSize)];
        WholesaleProductDetailCount *item = [WholesaleProductDetailCount itemWithTitle:title index:i];
        if (i == 0) item.selected = YES;
        if (item) [ary addObject:item];
    }
    self.counts = [NSArray arrayWithArray:ary];
}
@end
