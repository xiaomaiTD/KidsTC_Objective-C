//
//  ArticleHomeClassView.h
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"

@class ArticleHomeClassView;
@protocol ArticleHomeClassViewDelegate <NSObject>
- (void)articleHomeClassView:(ArticleHomeClassView *)view didSelectItem:(ArticleHomeClassItem *)item;
@end

@interface ArticleHomeClassView : UIView
@property (nonatomic, strong) ArticleHomeClass *clazz;
@property (nonatomic, weak) id<ArticleHomeClassViewDelegate> delegate;
@end
