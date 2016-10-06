//
//  SearchResultFactorView.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultFactorShowModel.h"
#define SearchResultFactorTopViewHight 36

@class SearchResultFactorView;
@protocol SearchResultFactorViewDelegate <NSObject>
- (void)factorViewDidMakeSureData:(SearchResultFactorView *)factorView;
@end

@interface SearchResultFactorView : UIView
@property (nonatomic, strong) SearchResultFactorShowModel *model;
@property (nonatomic, weak) id<SearchResultFactorViewDelegate> delegate;
@end
