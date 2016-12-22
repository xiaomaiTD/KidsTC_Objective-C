//
//  CollectionSCTBaseView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectionSCTPageCount 10

typedef enum : NSUInteger {
    CollectionSCTBaseViewActionTypeLoadData = 1,
    CollectionSCTBaseViewActionTypeSegue,//通用跳转
    CollectionSCTBaseViewActionTypeUserArticleCenter,
    CollectionSCTBaseViewActionTypeDelete,
    CollectionSCTBaseViewActionTypeCollect,
} CollectionSCTBaseViewActionType;

@class CollectionSCTBaseView;
@protocol CollectionSCTBaseViewDelegate <NSObject>
- (void)collectionSCTBaseView:(CollectionSCTBaseView *)view actionType:(CollectionSCTBaseViewActionType)type value:(id)value completion:(void (^)(id))completion;
@end

@interface CollectionSCTBaseView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//这里修饰delegate的关键字必须为strong，原因是controller不被navi栈强引用，如果delegate不为strong，则delegate为nil
@property (nonatomic, strong) id<CollectionSCTBaseViewDelegate> delegate;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) BOOL noMoreListData;
@property (nonatomic, assign) BOOL noMoreRecommendData;
- (void)resetFooterView;
- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend;
- (void)nilRecommendData;
@end
