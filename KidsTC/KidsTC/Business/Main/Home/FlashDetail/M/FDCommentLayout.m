//
//  FDCommentLayout.m
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDCommentLayout.h"

@implementation FDCommentLayout

+(instancetype)commentLayoutWithItem:(FDCommentListItem *)commentListItem{
    FDCommentLayout *layout = [[FDCommentLayout alloc]init];
    layout.commentListItem = commentListItem;
    return layout;
}

-(void)setCommentListItem:(FDCommentListItem *)commentListItem{
    _commentListItem = commentListItem;
    
    CGFloat hight = FDCommentCellMargin;
    hight += UserHeaderImageViewSize;
    hight += FDCommentCellMargin;
    
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 2*FDCommentCellMargin, 1000);
    NSDictionary *contentAttributes = @{NSFontAttributeName:FDCommentCellContentFont};
    CGRect contentRect = [commentListItem.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttributes context:nil];
    
    hight += contentRect.size.height;
    
    NSUInteger count = commentListItem.imageUrl.count;
    if (count > 0) {
        hight += FDCommentCellMargin;
        NSUInteger lineCount = (count-1)/FDCommentCellLineMaxItemsCount +1;//行数，从第一行开始
        _imageContainerHight = (FDCommentCellMargin+FDCommentCellImageViewSize)*lineCount-FDCommentCellMargin;
        hight += _imageContainerHight;
    }
    hight += FDCommentCellMargin;
    hight += FDCommentCellBtnHight;
    hight += FDCommentCellMargin;
    
    _hight = hight;
}
@end
