//
//  ServiceDetailConfigView.h
//  KidsTC
//
//  Created by zhanping on 6/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailModel.h"
#import "ServiceDetailConfigModel.h"

@class ServiceDetailConfigView;
@protocol ServiceDetailConfigViewDelegate <NSObject>
- (void)serviceDetailConfigView:(ServiceDetailConfigView *)serviceDetailConfigView didClickBtnWithPid:(long)pid;
- (void)serviceDetailConfigView:(ServiceDetailConfigView *)serviceDetailConfigView closeWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId isNeedToBuy:(BOOL)isNeedToBuy submitWithBuyNum:(NSUInteger)buyNum storeId:(NSString *)storeId;
@end

@interface ServiceDetailConfigView : UIView
@property (nonatomic, strong) ServiceDetailConfigData *data;
@property (nonatomic, weak) id<ServiceDetailConfigViewDelegate> delegate;
- (void)setProduct_standards:(NSArray<ProductStandardsItem *> *)product_standards currentIndex:(int)index;
- (void)show;
- (void)hideWithIsNeedToBuy:(BOOL)isNeedToBuy submitWithBuyNum:(NSUInteger)buyNum storeId:(NSString *)storeId;
@end
