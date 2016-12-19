//
//  ProductStandardHeaderView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductStandardDetailData.h"
@interface ProductStandardHeaderView : UIView
@property (nonatomic, strong) ProductStandardDetailData *standardDetailData;
@property (nonatomic, copy) void(^closeBlock)();
@end
