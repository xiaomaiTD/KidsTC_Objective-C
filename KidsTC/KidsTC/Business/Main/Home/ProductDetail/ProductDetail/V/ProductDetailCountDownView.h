//
//  ProductDetailCountDownView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

@interface ProductDetailCountDownView : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, copy) void (^countDonwFinishBlock)();
@end
