//
//  UserArticleCommentsLayout.m
//  KidsTC
//
//  Created by zhanping on 4/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "UserArticleCommentsLayout.h"

@implementation UserArticleCommentsLayout

- (void)setItem:(EvaListItem *)item{
    _item = item;
    if (_item.content && _item.content.length > 0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        //行间距
        paragraph.lineSpacing = 8;
        paragraph.alignment = NSTextAlignmentLeft;
        NSDictionary *attributes = @{NSFontAttributeName:ContentLabelTextFont,
                                     NSParagraphStyleAttributeName:paragraph};
        
        _attributedContentString = [[NSAttributedString alloc]initWithString:_item.content attributes:attributes];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ContentLabelMaxWith, 0)];
        tempLabel.numberOfLines = 0;
        tempLabel.attributedText = _attributedContentString;
        [tempLabel sizeToFit];
        
        _contentLabelHight = tempLabel.frame.size.height;
    }
    
    
    if (item.imgUrls.count>0) {
        _contentLabelViewHight = 4*UserArticleCommentsCellMargin + _contentLabelHight+SVHight;
        _hight = 7*UserArticleCommentsCellMargin + _contentLabelHight + SVHight + ArticleLabelHight;
    }else{
        _contentLabelViewHight = 3*UserArticleCommentsCellMargin + _contentLabelHight;
        _hight = 6*UserArticleCommentsCellMargin + _contentLabelHight + ArticleLabelHight;
    }
    
    
}

@end
