//
//  SearchResultFactorTablesContentView.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultFactorShowModel.h"

typedef enum : NSUInteger {
    TablesContentViewOperaDataType_CleanUpSelected=1,//清除
    TablesContentViewOperaDataType_UndoSelected,//还原
    TablesContentViewOperaDataType_MakeSureSelected//确认
} TablesContentViewOperaDataType;

@class SearchResultFactorTablesContentView;
@protocol SearchResultFactorTablesContentViewDelegate <NSObject>
- (void)tablesContentViewDidMakeSureData:(SearchResultFactorTablesContentView *)tablesContentView;
@end

@interface SearchResultFactorTablesContentView : UIView
@property (nonatomic, strong) SearchResultFactorTopItem *item;
@property (nonatomic, weak) id<SearchResultFactorTablesContentViewDelegate> delegate;

- (CGFloat)contentHeight;
- (void)operateDataWith:(TablesContentViewOperaDataType)type;
- (void)reloadData;
- (void)scrollToFirstSelectedItem;
@end
