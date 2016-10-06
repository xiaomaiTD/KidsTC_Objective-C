//
//  AlbumnModel.m
//  KidsTC
//
//  Created by zhanping on 4/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "AlbumnModel.h"


@implementation ACBigImagesListItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_content isEqualToString:@""] && _content) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 4;
        //paragraph.paragraphSpacingBefore = 24;
        //paragraph.paragraphSpacing = 12;
        paragraph.firstLineHeadIndent = 7;
        paragraph.headIndent = 7;
        //paragraph.tailIndent = 6;
        paragraph.baseWritingDirection = NSWritingDirectionLeftToRight;
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                              NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSParagraphStyleAttributeName:paragraph};
        NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:_content attributes:att];
        _attributeContent = attributeStr;
    }
    return YES;
}
@end


@implementation ADArticleTop

@end


@implementation ADContentsItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"bigImagesList" : [ACBigImagesListItem class]};
}
@end


@implementation ADArticleContent

@end



@implementation ARData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"contents" : [ADContentsItem class]};
}
@end


@implementation AlbumnResponse

@end
