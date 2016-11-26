//
//  CollectProductBaseView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectProductPageCount 10

typedef enum : NSUInteger {
    CollectProductBaseViewActionTypeLoadData = 1,
    CollectProductBaseViewActionTypeSegue
} CollectProductBaseViewActionType;

@class CollectProductBaseView;
@protocol CollectProductBaseViewDelegate <NSObject>
- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value;
@end

@interface CollectProductBaseView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//这里修饰delegate的关键字必须为strong，原因是controller不被navi栈强引用，如果delegate不为strong，则delegate为nil
@property (nonatomic, strong) id<CollectProductBaseViewDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
