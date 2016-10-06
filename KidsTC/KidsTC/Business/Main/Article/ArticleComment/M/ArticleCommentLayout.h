//
//  ArticleCommentLayout.h
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleCommentModel.h"



#define ArticleCommentCellMarginInsets 12
#define HeadImageViewSize 40
#define NamesLabelHight 20
#define SVHight 80
#define PraiseCountLabelWidht 60
#define PraiseCountLabelMargin 4
#define ContentLabelX (ArticleCommentCellMarginInsets*2+HeadImageViewSize)
#define ContentLabelWidht (SCREEN_WIDTH - (HeadImageViewSize+ArticleCommentCellMarginInsets*3))
#define StyleBtnWidth 40
#define StyleBtnHight 20
#define ContentLabelFont [UIFont systemFontOfSize:15]


@interface ArticleCommentLayout : NSObject
@property (nonatomic, strong)  EvaListItem *item;
@property (nonatomic, assign) BOOL isAboutMe;

@property (nonatomic, assign) BOOL isCanShowStyleBtn;

@property (nonatomic, assign) BOOL isStyleOpen;

@property (nonatomic, strong) NSMutableAttributedString *content;
@property (nonatomic, assign) CGFloat contentLabelNormalHight;
@property (nonatomic, assign) CGFloat contentLabelOpenHight;
@property (nonatomic, assign) CGFloat contentLabelY;

@property (nonatomic, assign) CGFloat styleBtnNormalY;
@property (nonatomic, assign) CGFloat styleBtnOpenY;

@property (nonatomic, assign) BOOL isHaveImageView;
@property (nonatomic, assign) CGFloat SVNormalY;
@property (nonatomic, assign) CGFloat SVOpenY;

@property (nonatomic, assign) CGFloat normalHight;
@property (nonatomic, assign) CGFloat openHight;

@property (nonatomic, assign) NSRange actionRange;

@end
