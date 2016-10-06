//
//  ArticleCommentLayout.m
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCommentLayout.h"
#import <CoreText/CoreText.h>
@implementation ArticleCommentLayout
-(void)setItem:(EvaListItem *)item{
    _item = item;
    
    NSMutableAttributedString *content = nil;
    if (_item.reply) {
        NSString *contentoneStr = [NSString stringWithFormat:@"%@ // ",item.content];
        NSString *replyUserNameStr = [NSString stringWithFormat:@"%@: ",item.reply.userName];
        NSString *replyContentStr = item.reply.content;
        NSString *contentStr = [NSString stringWithFormat:@"%@%@%@",contentoneStr,replyUserNameStr,replyContentStr];
        
        content = [[NSMutableAttributedString alloc]initWithString:contentStr];
        
        [content addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.502  green:0.502  blue:0.502 alpha:1] range:[contentStr rangeOfString:contentoneStr]];
        
        _actionRange = [contentStr rangeOfString:replyUserNameStr];
        [content addAttribute:NSForegroundColorAttributeName value:COLOR_BLUE range:_actionRange];
        
        [content addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.502  green:0.502  blue:0.502 alpha:1] range:[contentStr rangeOfString:replyContentStr]];
    }else{
        NSDictionary *contentOneAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.502  green:0.502  blue:0.502 alpha:1]};
        content = [[NSMutableAttributedString alloc]initWithString:item.content attributes:contentOneAttributes];
    }
    NSRange contentRange = NSMakeRange(0, content.length);
    
    [content addAttribute:NSFontAttributeName value:ContentLabelFont range:contentRange];
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    //行间距
    paragraph.lineSpacing = 8;
    //段落间距
    //paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    //paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
    //paragraph.headIndent = 10;
    
    //添加段落设置
    [content addAttribute:NSParagraphStyleAttributeName value:paragraph range:contentRange];
    
    _content = content;
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ContentLabelWidht, 0)];
    tempLabel.attributedText = _content;
    
     tempLabel.numberOfLines = 4;
     [tempLabel sizeToFit];
    CGFloat contentHightOne = tempLabel.frame.size.height;
    
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGFloat contentHightTwo = tempLabel.frame.size.height;

    if (contentHightTwo>contentHightOne) {//有按钮
        _contentLabelNormalHight = contentHightOne;
        _contentLabelOpenHight = contentHightTwo;
        _isCanShowStyleBtn = YES;
    }else{
        _isCanShowStyleBtn = NO;
        _contentLabelNormalHight = contentHightTwo;
    }
    
    
    if (_item.imgUrls.count>0) {
        _isHaveImageView = YES;
    }else{
        _isHaveImageView = NO;
    }
    
    if (_isAboutMe) {
        _contentLabelY = ArticleCommentCellMarginInsets;
        
        if (_isCanShowStyleBtn) {//有按钮
            
            _styleBtnNormalY = ArticleCommentCellMarginInsets + _contentLabelNormalHight;
            _styleBtnOpenY = ArticleCommentCellMarginInsets + _contentLabelOpenHight;
            
            if (_isHaveImageView) {//有按钮，有图片
                _SVNormalY = _styleBtnNormalY + StyleBtnHight + ArticleCommentCellMarginInsets;
                _SVOpenY = _styleBtnOpenY + StyleBtnHight + ArticleCommentCellMarginInsets;
                
                _normalHight = _SVNormalY + SVHight + ArticleCommentCellMarginInsets;
                _openHight = _SVOpenY + SVHight + ArticleCommentCellMarginInsets;
                
            }else{//有按钮，没有图片
                _normalHight = _styleBtnNormalY + StyleBtnHight + ArticleCommentCellMarginInsets;
                _openHight = _styleBtnOpenY + StyleBtnHight + ArticleCommentCellMarginInsets;
            }
            
        }else{//没有按钮
            
            if (_isHaveImageView) {//没有按钮，有图片
                _SVNormalY =  2*ArticleCommentCellMarginInsets + _contentLabelNormalHight;
                _SVOpenY = 2*ArticleCommentCellMarginInsets + _contentLabelOpenHight;
                
                _normalHight = _SVNormalY + SVHight + ArticleCommentCellMarginInsets;
                _openHight = _SVOpenY + SVHight + ArticleCommentCellMarginInsets;
            }else{//没有按钮，没有图片
                CGFloat normalHighter = _contentLabelNormalHight>HeadImageViewSize?_contentLabelNormalHight:HeadImageViewSize;
                CGFloat openHighter = _contentLabelOpenHight>HeadImageViewSize?_contentLabelOpenHight:HeadImageViewSize;
                _normalHight = 2*ArticleCommentCellMarginInsets + normalHighter;
                _openHight = 2*ArticleCommentCellMarginInsets + openHighter;
            }
        }
    }else{
        _contentLabelY = NamesLabelHight+ArticleCommentCellMarginInsets*1.5;
        if (_isCanShowStyleBtn) {//有按钮
            
            _styleBtnNormalY = 1.5*ArticleCommentCellMarginInsets + NamesLabelHight + _contentLabelNormalHight;
            _styleBtnOpenY = 1.5*ArticleCommentCellMarginInsets + NamesLabelHight + _contentLabelOpenHight;
            
            if (_isHaveImageView) {//有按钮，有图片
                _SVNormalY = _styleBtnNormalY + StyleBtnHight + ArticleCommentCellMarginInsets;
                _SVOpenY = _styleBtnOpenY + StyleBtnHight + ArticleCommentCellMarginInsets;
                
                _normalHight = _SVNormalY + SVHight + ArticleCommentCellMarginInsets;
                _openHight = _SVOpenY + SVHight + ArticleCommentCellMarginInsets;
                
            }else{//有按钮，没有图片
                _normalHight = _styleBtnNormalY + StyleBtnHight + ArticleCommentCellMarginInsets;
                _openHight = _styleBtnOpenY + StyleBtnHight + ArticleCommentCellMarginInsets;
            }
            
        }else{//没有按钮
            
            if (_isHaveImageView) {//没有按钮，有图片
                _SVNormalY =  2.5*ArticleCommentCellMarginInsets + NamesLabelHight + _contentLabelNormalHight;
                NSLog(@"_SVNormalY:%f",_SVNormalY);
                _SVOpenY = 2.5*ArticleCommentCellMarginInsets + NamesLabelHight + _contentLabelOpenHight;
                
                _normalHight = _SVNormalY + SVHight + ArticleCommentCellMarginInsets;
                _openHight = _SVOpenY + SVHight + ArticleCommentCellMarginInsets;
            }else{//没有按钮，没有图片
                CGFloat normalHighter = (NamesLabelHight + _contentLabelNormalHight)>HeadImageViewSize?(NamesLabelHight + _contentLabelNormalHight):HeadImageViewSize;
                CGFloat openHighter = (NamesLabelHight + _contentLabelOpenHight)>HeadImageViewSize?(NamesLabelHight + _contentLabelOpenHight):HeadImageViewSize;
                _normalHight = 2.5*ArticleCommentCellMarginInsets + normalHighter;
                _openHight = 2.5*ArticleCommentCellMarginInsets + openHighter;
            }
        }
    }
}

- (int)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

@end



