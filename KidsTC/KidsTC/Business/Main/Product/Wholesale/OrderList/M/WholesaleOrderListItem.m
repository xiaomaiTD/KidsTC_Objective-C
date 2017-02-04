//
//  WholesaleOrderListItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListItem.h"
#import "NSString+Category.h"

@implementation WholesaleOrderListItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"btns":[NSNumber class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupBtns];
    [self setupShareObj:dic];
    if(_isRedirect)[self setupSegueModel];
    return YES;
}
- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.title
                                                   description:_share.descption
                                                 thumbImageUrl:[NSURL URLWithString:_share.img]
                                                     urlString:_share.url];
    if (self.shareObject) {
        self.shareObject.identifier = _orderNo;
        self.shareObject.followingContent = @"【童成】";
    }
}
- (void)setupBtns {
    NSMutableArray *orderBtns = [NSMutableArray array];
    int count = (int)_btns.count;
    for (int i = 1; i<=4; i++) {
        int index = count - i;
        if (index>=0) {
            NSNumber *obj = _btns[index];
            WholesaleOrderListBtnType btnType = obj.integerValue;
            WholesaleOrderListBtn *btn = [WholesaleOrderListBtn btnWithType:btnType isHighLight:btnType == _defaultBtn];
            if (btn) [orderBtns addObject:btn];
        }
    }
    _orderBtns = [NSArray arrayWithArray:orderBtns];
}
- (void)setupSegueModel {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_fightGroupSysNo isNotNull]) {
        [params setObject:_fightGroupSysNo forKey:@"pid"];
    }
    if ([_fightGroupOpenGroupSysNo isNotNull]) {
        [params setObject:_fightGroupOpenGroupSysNo forKey:@"gid"];
    }
    _segueModel = [SegueModel modelWithDestination:SegueDestinationOrderWholesaleDetail paramRawData:params];
}
@end
