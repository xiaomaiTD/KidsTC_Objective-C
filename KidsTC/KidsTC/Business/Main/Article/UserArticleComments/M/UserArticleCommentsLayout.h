//
//  UserArticleCommentsLayout.h
//  KidsTC
//
//  Created by zhanping on 4/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleCommentModel.h"


#define UserArticleCommentsCellMargin 10
#define PriseBtnSize 18
#define SVWidth (SCREEN_WIDTH - 4*UserArticleCommentsCellMargin)
#define SVHight 80
#define ArticleLabelHight 20
#define ContentLabelMaxWith (SCREEN_WIDTH - 4*UserArticleCommentsCellMargin - PriseBtnSize-20)
#define ContentLabelTextFont [UIFont systemFontOfSize:17]

@interface UserArticleCommentsLayout : NSObject
@property (nonatomic, assign) CGFloat hight;
@property (nonatomic, assign) CGFloat contentLabelHight;
@property (nonatomic, assign) CGFloat contentLabelViewHight;
@property (nonatomic, strong) NSAttributedString *attributedContentString;
@property (nonatomic, strong) EvaListItem *item;

@end
