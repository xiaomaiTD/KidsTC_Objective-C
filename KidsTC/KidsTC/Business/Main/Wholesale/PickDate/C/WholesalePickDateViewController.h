//
//  WholesalePickDateViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "WholesalePickDateSKU.h"

typedef enum : NSUInteger {
    WholesalePickDateViewControllerActionTypeBuy = 1,
    WholesalePickDateViewControllerActionTypeMakeSure,
} WholesalePickDateViewControllerActionType;

@class WholesalePickDateViewController;
@protocol WholesalePickDateViewControllerDelegate <NSObject>
- (void)wholesalePickDateViewController:(WholesalePickDateViewController *)controller actionType:(WholesalePickDateViewControllerActionType)type value:(id)value;
@end

@interface WholesalePickDateViewController : ViewController
@property (nonatomic, strong) WholesalePickDateSKU *sku;
@property (nonatomic, weak) id<WholesalePickDateViewControllerDelegate> delegate;
@end
