//
//  SettlementResultNewViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailData.h"

@interface SettlementResultNewViewController : ViewController
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) ProductDetailData *data;

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *openGroupId;
@end
