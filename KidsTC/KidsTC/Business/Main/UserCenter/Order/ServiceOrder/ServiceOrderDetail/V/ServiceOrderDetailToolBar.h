//
//  ServiceOrderDetailToolBar.h
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceOrderDetailModel.h"
#import "ServiceOrderDetailToolBarButton.h"

@class ServiceOrderDetailToolBar;
@protocol ServiceOrderDetailToolBarDelegate <NSObject>
- (void)serviceOrderDetailToolBar:(ServiceOrderDetailToolBar *)toolBar btn:(ServiceOrderDetailToolBarButton *)btn actionType:(ServiceOrderDetailToolBarButtonActionType)type value:(id)value;
@end

@interface ServiceOrderDetailToolBar : UIView
@property (nonatomic, weak) ServiceOrderDetailData *data;
@property (nonatomic, weak) id<ServiceOrderDetailToolBarDelegate> delegate;
@end
