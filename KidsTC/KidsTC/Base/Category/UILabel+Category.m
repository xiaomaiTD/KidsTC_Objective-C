//
//  UILabel+Category.m
//  KidsTC
//
//  Created by zhanping on 7/29/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
- (CGFloat)sizeToFitWithMaximumNumberOfLines:(NSInteger)lines
{
    return [self sizeOfSizeToFitWithMaximumNumberOfLines:lines].height;
}
- (CGSize)sizeOfSizeToFitWithMaximumNumberOfLines:(NSInteger)lines {
    self.numberOfLines = lines;
    CGSize maxSize = CGSizeMake(self.frame.size.width, lines * self.font.lineHeight);
    /////////edit by Altair, 20150320, for iOS 7+
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 1.0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.font, NSFontAttributeName,
                               paragraphStyle, NSParagraphStyleAttributeName, nil];
    CGSize size = [self.text boundingRectWithSize:maxSize
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:attribute
                                          context:nil].size;
    ///////////////////////////////////////////////
    //CGSize size = [self.text sizeWithFont:self.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByTruncatingTail];
    //self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    return size;
}
@end
