//
//  FlashBuyProductDetailColumnsHeader.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashBuyProductDetailData.h"
@interface FlashBuyProductDetailColumnsHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@property (nonatomic, copy) void(^actionBlock)();
@end
