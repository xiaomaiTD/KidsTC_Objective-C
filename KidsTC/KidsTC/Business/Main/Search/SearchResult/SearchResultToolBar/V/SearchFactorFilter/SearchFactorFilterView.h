//
//  SearchFactorFilterView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchFactorFilterView;
@protocol SearchFactorFilterViewDelegate <NSObject>
- (void)searchFactorFilterView:(SearchFactorFilterView *)view didSelectParam:(NSDictionary *)param byClick:(BOOL)byClick;
@end

@interface SearchFactorFilterView : UIView
@property (nonatomic, weak) id<SearchFactorFilterViewDelegate> delegate;
@property (nonatomic, weak) NSDictionary *insetParam;
- (CGFloat)contentHeight;
- (void)reset;
@end
