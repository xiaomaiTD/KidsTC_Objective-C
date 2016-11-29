//
//  CouponListBaseView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CouponListPageCount 10

typedef enum : NSUInteger {
    CouponListBaseViewActionTypeLoadData = 1,
    CouponListBaseViewActionTypeUseCoupon,
} CouponListBaseViewActionType;

@class CouponListBaseView;
@protocol CouponListBaseViewDelegate <NSObject>
- (void)couponListBaseView:(CouponListBaseView *)view actionType:(CouponListBaseViewActionType)type value:(id)value;
@end

@interface CouponListBaseView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//这里修饰delegate的关键字必须为strong，原因是controller不被navi栈强引用，如果delegate不为strong，则delegate为nil
@property (nonatomic, strong) id<CouponListBaseViewDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
