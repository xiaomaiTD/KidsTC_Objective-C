//
//  ServiceDetailConfigTableHeaderView.h
//  KidsTC
//
//  Created by zhanping on 6/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailConfigModel.h"
#import "ServiceDetailModel.h"
@class ServiceDetailConfigTableHeaderView;
@protocol ServiceDetailConfigTableHeaderViewDelegate <NSObject>
- (void)serviceDetailConfigTableHeaderView:(ServiceDetailConfigTableHeaderView *)view didClickBtnAtIndex:(NSUInteger)index;
- (void)serviceDetailConfigTableHeaderView:(ServiceDetailConfigTableHeaderView *)view didSelectBuyNum:(NSUInteger)num;
@end
@interface ServiceDetailConfigTableHeaderView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLimitLabel;
@property (nonatomic, strong) ServiceDetailConfigData *data;
@property (nonatomic, weak) id<ServiceDetailConfigTableHeaderViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSUInteger buyNum;
- (void)setProduct_standards:(NSArray<ProductStandardsItem *> *)product_standards currentIndex:(int)index;
@end
