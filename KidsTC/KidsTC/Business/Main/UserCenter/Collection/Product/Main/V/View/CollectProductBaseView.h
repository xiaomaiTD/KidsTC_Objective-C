//
//  CollectProductBaseView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CollectProductBaseViewActionTypeLoadData = 1,
} CollectProductBaseViewActionType;

@class CollectProductBaseView;
@protocol CollectProductBaseViewActionTypeDelegate <NSObject>
- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value;
@end

@interface CollectProductBaseView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<CollectProductBaseViewActionTypeDelegate> delegate;
@end
