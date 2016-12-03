//
//  ProductOrderListView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProductOrderListPageCount 10

typedef enum : NSUInteger {
    ProductOrderListViewActionTypeLoadData = 1,
} ProductOrderListViewActionType;

@class ProductOrderListView;
@protocol ProductOrderListViewDelegate <NSObject>
- (void)productOrderListView:(ProductOrderListView *)view actionType:(ProductOrderListViewActionType)type value:(id)value;
@end

@interface ProductOrderListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//这里修饰delegate的关键字必须为strong，原因是controller不被navi栈强引用，如果delegate不为strong，则delegate为nil
@property (nonatomic, weak) id<ProductOrderListViewDelegate> delegate;
@property (nonatomic, assign) NSArray *items;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
