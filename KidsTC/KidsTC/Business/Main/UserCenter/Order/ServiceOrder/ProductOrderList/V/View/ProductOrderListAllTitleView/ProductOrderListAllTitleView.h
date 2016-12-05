//
//  ProductOrderListAllTitle.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductOrderListAllTitleView : UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) void (^acitonBlock)(BOOL open);
- (void)setupSelected;
@end
