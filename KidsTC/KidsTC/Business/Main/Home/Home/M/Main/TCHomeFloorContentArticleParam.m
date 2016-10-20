//
//  TCHomeFloorContentArticleParam.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorContentArticleParam.h"
#import "NSAttributedString+YYText.h"

@implementation TCHomeFloorContentArticleParam
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupArticleAttStr];
    
    return YES;
}

- (void) setupArticleAttStr {
    
    CGFloat fontSize = 15;
    
    NSMutableAttributedString *totalAttStr = [NSMutableAttributedString new];
    if (_isHot) {
        NSMutableAttributedString *hotAttStr = [[NSMutableAttributedString alloc] initWithString:@"热"];
        hotAttStr.color = COLOR_PINK;
        hotAttStr.font = [UIFont systemFontOfSize:fontSize];
        YYTextBorder *border = [YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:LINE_H strokeColor:COLOR_PINK];
        border.cornerRadius = fontSize * 0.5;
        hotAttStr.textBorder = border;
        [totalAttStr appendAttributedString:hotAttStr];
    }
    if (_isRecommend) {
        NSMutableAttributedString *recommendAttStr = [[NSMutableAttributedString alloc] initWithString:@"荐"];
        recommendAttStr.color = COLOR_BLUE;
        recommendAttStr.font = [UIFont systemFontOfSize:fontSize];
        YYTextBorder *border = [YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:LINE_H strokeColor:COLOR_BLUE];
        border.cornerRadius = fontSize * 0.5;
        recommendAttStr.textBorder = border;
        [totalAttStr appendAttributedString:recommendAttStr];
    }
    
    if (totalAttStr.length>0) {
        [totalAttStr appendAttributedString:self.emptyAttStr];
        [totalAttStr appendAttributedString:self.emptyAttStr];
    }
    
    UIImage *viewImg = [UIImage imageNamed:@"icon_news_look"];
    NSMutableAttributedString *viewImgAttStr = [NSMutableAttributedString attachmentStringWithContent:viewImg contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(fontSize, fontSize) alignToFont:[UIFont systemFontOfSize:fontSize] alignment:YYTextVerticalAlignmentCenter];
    [totalAttStr appendAttributedString:viewImgAttStr];
    
    [totalAttStr appendAttributedString:self.emptyAttStr];
    
    NSMutableAttributedString *viewCountAttStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%zd",_viewTimes]];
    viewCountAttStr.color = [UIColor lightGrayColor];
    viewCountAttStr.font = [UIFont systemFontOfSize:fontSize];
    [totalAttStr appendAttributedString:viewCountAttStr];
    
    [totalAttStr appendAttributedString:self.emptyAttStr];
    [totalAttStr appendAttributedString:self.emptyAttStr];
    
    UIImage *commentImg = [UIImage imageNamed:@"home_cell_comment"];
    NSMutableAttributedString *commentImgAttStr = [NSMutableAttributedString attachmentStringWithContent:commentImg contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(fontSize, fontSize) alignToFont:[UIFont systemFontOfSize:fontSize] alignment:YYTextVerticalAlignmentCenter];
    [totalAttStr appendAttributedString:commentImgAttStr];
    
    [totalAttStr appendAttributedString:self.emptyAttStr];
    
    NSMutableAttributedString *commentCountAttStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%zd",_commentCount]];
    commentCountAttStr.color = [UIColor lightGrayColor];
    commentCountAttStr.font = [UIFont systemFontOfSize:fontSize];
    [totalAttStr appendAttributedString:commentCountAttStr];
    
    _articleStr = totalAttStr;
}

- (NSAttributedString *)emptyAttStr {
    NSMutableAttributedString *emptyAttStr = [[NSMutableAttributedString alloc] initWithString:@" "];
    return emptyAttStr;
}

@end
