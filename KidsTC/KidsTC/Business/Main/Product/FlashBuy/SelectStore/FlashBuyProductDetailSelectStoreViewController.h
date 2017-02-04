//
//  FlashBuyProductDetailSelectStoreViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "FlashBuyProductDetailStore.h"

typedef enum : NSUInteger {
    FlashBuyProductDetailSelectStoreViewControllerActionTypeCommit = 1,
} FlashBuyProductDetailSelectStoreViewControllerActionType;

@class FlashBuyProductDetailSelectStoreViewController;
@protocol FlashBuyProductDetailSelectStoreViewControllerDelegate <NSObject>
- (void)flashBuyProductDetailSelectStoreViewController:(FlashBuyProductDetailSelectStoreViewController*)controller actionType:(FlashBuyProductDetailSelectStoreViewControllerActionType)type value:(id)value;
@end

@interface FlashBuyProductDetailSelectStoreViewController : ViewController
@property (nonatomic, strong) NSArray<FlashBuyProductDetailStore *> *stores;
@property (nonatomic, strong) NSString *prepaidPrice;
@property (nonatomic, weak) id<FlashBuyProductDetailSelectStoreViewControllerDelegate> delegate;
@end
