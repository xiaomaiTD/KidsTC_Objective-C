//
//  ArticleColumnHeader.h
//  KidsTC
//
//  Created by 詹平 on 16/9/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleColumnModel.h"

@class ArticleColumnHeader;
@protocol ArticleColumnHeaderDelegate <NSObject>
- (void)articleColumnHeaderAction:(ArticleColumnHeader *)view;
@end

@interface ArticleColumnHeader : UIView
@property (nonatomic, weak) ArticleColumnInfo *info;
@property (nonatomic, weak) id<ArticleColumnHeaderDelegate> delegate;
@end
