//
//  MessageCenterLayout.m
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MessageCenterLayout.h"
#import <CoreText/CoreText.h>

@implementation MessageCenterLayout
-(void)setItem:(EvaListItem *)item{
    _item = item;
    
    NSString *contentstr = [NSString stringWithFormat:@"%@ // ",_item.content];
    NSString *nameStr = [NSString stringWithFormat:@"%@: ",item.reply.userName];
    NSString *replyStr = _item.reply.content;
    NSString *contentTotalStr = [NSString stringWithFormat:@"%@%@%@",contentstr,nameStr,replyStr];
    
    _contentTotalAttributeStr = [[NSMutableAttributedString alloc]initWithString:contentTotalStr];
    
    NSDictionary *contentAttributes = @{NSFontAttributeName:MCContentLabelFont,
                                 NSForegroundColorAttributeName:[UIColor colorWithRed:0.243 green:0.227 blue:0.224 alpha:1]};
    [_contentTotalAttributeStr addAttributes:contentAttributes range:[contentTotalStr rangeOfString:contentstr]];
    
    NSDictionary *nameAttributes = @{NSFontAttributeName:MCContentLabelFont,
                                     NSForegroundColorAttributeName:COLOR_BLUE};
    [_contentTotalAttributeStr addAttributes:nameAttributes range:[contentTotalStr rangeOfString:nameStr]];
    
    NSDictionary *replyAttributes = @{NSFontAttributeName:MCContentLabelFont,
                                     NSForegroundColorAttributeName:[UIColor colorWithRed:0.243 green:0.227 blue:0.224 alpha:1]};
    [_contentTotalAttributeStr addAttributes:replyAttributes range:[contentTotalStr rangeOfString:replyStr]];
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    //行间距
    paragraph.lineSpacing = 8;
    //段落间距
    //paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
//    paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
//    paragraph.headIndent = 10;
    
    //添加段落设置
    [_contentTotalAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _contentTotalAttributeStr.length)];
    
    
    _actionRange = [contentTotalStr rangeOfString:nameStr];
    
    
     UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MCContentLabelWidth, 0)];
     tempLabel.numberOfLines = 0;
     tempLabel.attributedText = _contentTotalAttributeStr;
     [tempLabel sizeToFit];
     
    
    _contentTotalAttributeStrHight = tempLabel.frame.size.height; //[self getAttributedStringHeightWithString:_contentTotalAttributeStr WidthValue:MCContentLabelWidth];
    
    _hight = MCCellMarginInsets*2 + MCCHeadImageViewSize + MCCellMarginInsets +  _contentTotalAttributeStrHight +MCCellMarginInsets+ MCCellMarginInsets*2+MCCImageViewSize +MCCellMarginInsets+MCCellMarginInsets;
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
