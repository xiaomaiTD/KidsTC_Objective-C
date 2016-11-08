//
//  AccountCenterHotProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterHotProductItem.h"

typedef enum : NSUInteger {
    AccountCenterHotProductTypeUnknow,//未知，不作跳转
    AccountCenterHotProductTypeNormolProduct,//普通商品 跳商品详情
    AccountCenterHotProductTypeCarrot,//萝卜商品 跳H5
    AccountCenterHotProductTypeFlashBy//闪购商品 跳原生闪购
} AccountCenterHotProductType;

@interface AccountCenterHotProduct : NSObject
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, assign) AccountCenterHotProductType productType;
@property (nonatomic, strong) NSArray<AccountCenterHotProductItem *> *productLs;
@end
