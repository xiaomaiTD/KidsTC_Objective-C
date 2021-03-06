//
//  CashierDeskViewController.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "CashierDeskModel.h"

@interface CashierDeskViewController : ViewController
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, copy) void (^resultBlock)(BOOL needRefresh);
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *openGroupId;
@end
