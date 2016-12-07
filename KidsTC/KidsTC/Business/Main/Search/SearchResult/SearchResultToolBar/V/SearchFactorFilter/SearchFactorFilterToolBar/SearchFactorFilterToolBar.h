//
//  SearchFactorFilterToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kSearchFactorFilterToolBarH;

typedef enum : NSUInteger {
    SearchFactorFilterToolBarActionTypeClean = 1,
    SearchFactorFilterToolBarActionTypeSure,
} SearchFactorFilterToolBarActionType;

@class SearchFactorFilterToolBar;
@protocol SearchFactorFilterToolBarDelegate <NSObject>
- (void)searchFactorFilterToolBar:(SearchFactorFilterToolBar *)toolBar actionType:(SearchFactorFilterToolBarActionType)type value:(id)value;
@end

@interface SearchFactorFilterToolBar : UIView
@property (nonatomic, weak) id<SearchFactorFilterToolBarDelegate> delegate;
@end
