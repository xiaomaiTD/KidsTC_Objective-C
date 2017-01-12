//
//  SeckillTimeData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillTimeData.h"
#import "NSString+Category.h"

@implementation SeckillTimeData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tabs":[SeckillTimeDate class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupToolBarItems];
    
    [self setupSelect];
    
    [self setupShareObj];
    
    return YES;
}

- (void)setupToolBarItems {
    NSMutableArray *ary = [NSMutableArray array];
    SeckillTimeToolBarItem *home = [SeckillTimeToolBarItem itemWithTitle:@"首页" img:@"Seckill_home" type:SeckillTimeToolBarItemActionTypeHome];
    if (home) [ary addObject:home];
    SeckillTimeToolBarItem *orderList = [SeckillTimeToolBarItem itemWithTitle:@"我的购物袋" img:@"Seckill_pocket" type:SeckillTimeToolBarItemActionTypePocket];
    if (orderList) [ary addObject:orderList];
    NSString *fid = [NSString stringWithFormat:@"%@",self.eventMenu.param[@"fid"]];
    if (self.eventMenu.linkType == 105 && [fid isNotNull]) {
        SeckillTimeToolBarItem *other = [SeckillTimeToolBarItem itemWithTitle:@"其他优惠活动" img:@"Seckill_other" type:SeckillTimeToolBarItemActionTypeOther];
        if (other) [ary addObject:other];
    }
    self.toolBarItems = [NSArray arrayWithArray:ary];
}

- (void)setupSelect {
    __block BOOL hasIsChecked = NO;
    [self.tabs enumerateObjectsUsingBlock:^(SeckillTimeDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!hasIsChecked && obj.isChecked) {
            hasIsChecked = YES;
        }else{
            obj.isChecked = NO;
        }
    }];
    if (!hasIsChecked) {
        if (self.tabs.count>0) {
            self.tabs.firstObject.isChecked = YES;
        }
    }
}

- (void)setupShareObj {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.shareTitle
                                                   description:_share.shareDesc
                                                 thumbImageUrl:[NSURL URLWithString:_share.shareImg]
                                                     urlString:_share.shareurl];
}

@end
