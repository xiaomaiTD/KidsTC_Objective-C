//
//  MessageCenterLayout.h
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleCommentModel.h"
#define MCContentLabelFont [UIFont systemFontOfSize:17]
#define MCCellMarginInsets 12
#define MCCImageViewSize 60
#define MCCHeadImageViewSize 40
#define MCCNameLabelHight 20
#define MCCLineHight (1/[[UIScreen mainScreen] scale])
#define MCContentLabelWidth (SCREEN_WIDTH - 2*MCCellMarginInsets)

@interface MessageCenterLayout : NSObject
@property (nonatomic, strong) EvaListItem *item;
@property (nonatomic, assign) CGFloat hight;

@property (nonatomic, strong) NSMutableAttributedString *contentTotalAttributeStr;
@property (nonatomic, assign) CGFloat contentTotalAttributeStrHight;
@property (nonatomic, assign) NSRange actionRange;
@end
