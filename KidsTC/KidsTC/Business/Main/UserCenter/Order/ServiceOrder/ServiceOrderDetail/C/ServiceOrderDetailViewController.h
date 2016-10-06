//
//  ServiceOrderDetailViewController.h
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

@class ServiceOrderDetailViewController;
@protocol ServiceOrderDetailViewControllerDelegate <NSObject>
- (void)serviceOrderDetailStateChanged:(NSString *)orderId needRefresh:(BOOL)needRefresh;
@end

@interface ServiceOrderDetailViewController : ViewController
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, weak) id<ServiceOrderDetailViewControllerDelegate> delegate;
@end
