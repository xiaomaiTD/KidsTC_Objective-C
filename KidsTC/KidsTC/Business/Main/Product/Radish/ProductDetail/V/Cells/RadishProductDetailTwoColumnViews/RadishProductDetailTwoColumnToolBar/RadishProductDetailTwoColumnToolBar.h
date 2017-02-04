//
//  RadishProductDetailTwoColumnToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductDetailData.h"

extern CGFloat const kRadishTwoColumnToolBarH;
@class RadishProductDetailTwoColumnToolBar;
@protocol RadishProductDetailTwoColumnToolBarDelegate <NSObject>
- (void)radishProductDetailTwoColumnToolBar:(RadishProductDetailTwoColumnToolBar *)toolBar ationType:(RadishProductDetailTwoColumnShowType)type value:(id)value;
@end

@interface RadishProductDetailTwoColumnToolBar : UIView
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, weak) id<RadishProductDetailTwoColumnToolBarDelegate> delegate;

@end
