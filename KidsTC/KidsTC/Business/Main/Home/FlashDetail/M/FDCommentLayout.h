//
//  FDCommentLayout.h
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashDetailModel.h"
#define FDCommentCellMargin 12
#define UserHeaderImageViewSize 30
#define FDCommentCellBtnHight 20
#define FDCommentCellContentFont [UIFont systemFontOfSize:15]
#define FDCommentCellImageViewSize ((SCREEN_WIDTH - 5*FDCommentCellMargin)/4.0)
#define FDCommentCellMaxCount 9//最大图片数量
#define FDCommentCellLineMaxItemsCount 4//每行最多显示张数

@interface FDCommentLayout : NSObject
@property (nonatomic, strong) FDCommentListItem *commentListItem;
@property (nonatomic, assign) CGFloat imageContainerHight;
@property (nonatomic, assign) CGFloat hight;
+(instancetype)commentLayoutWithItem:(FDCommentListItem *)commentListItem;
@end
