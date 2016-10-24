//
//  TCHomeFloorContent.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorContent.h"
#import "NSAttributedString+YYText.h"

@implementation TCHomeFloorContent
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    return YES;
}

- (void)setupAttTitle {
    if (!_attTitle) {
        NSString *title = [NSString stringWithFormat:@"%@",_title];
        NSString *subTitle = [NSString stringWithFormat:@"%@",_subTitle];
        NSString *price = [NSString stringWithFormat:@"¥ %@",_price];
        switch (_type) {
            case TCHomeFloorContentTypeBanner:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
            case TCHomeFloorContentTypeTwinklingElf:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 0;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:14];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentCenter;
                _attTitle = attTitle;
            }
                break;
            case TCHomeFloorContentTypeHorizontalList:
            {
                NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                attPrice.lineSpacing = 0;
                attPrice.color = COLOR_PINK;
                attPrice.font = [UIFont systemFontOfSize:15];
                attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                attPrice.alignment = NSTextAlignmentCenter;
                _attPrice = attPrice;
            }
                break;
            case TCHomeFloorContentTypeThree:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
            case TCHomeFloorContentTypeTwoColumn:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
            case TCHomeFloorContentTypeNews:
            case TCHomeFloorContentTypeImageNews:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 4;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
                
                _attSubTitle = _articleParam.articleStr;
            }
                break;
            case TCHomeFloorContentTypeThreeImageNews:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 4;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
                
                _attSubTitle = _articleParam.articleStr;
            }
                break;
            case TCHomeFloorContentTypeWholeImageNews:
            {
                title = [NSString stringWithFormat:@"  %@",title];
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 4;
                attTitle.color = [UIColor whiteColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
            }
                break;
            case TCHomeFloorContentTypeNotice:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 0;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
            }
                break;
            case TCHomeFloorContentTypeBigImageTwoDesc:
            {
                NSRange range = [title rangeOfString:_linkKey];
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 0;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:15];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentLeft;
                [attTitle setColor:COLOR_PINK range:range];
                _attTitle = attTitle;
                
                NSMutableAttributedString *attSubTitle = [[NSMutableAttributedString alloc] initWithString:subTitle];
                attSubTitle.lineSpacing = 0;
                attSubTitle.color = [UIColor lightGrayColor];
                attSubTitle.font = [UIFont systemFontOfSize:15];
                attSubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attSubTitle.alignment = NSTextAlignmentLeft;
                _attSubTitle = attSubTitle;
                
            }
                break;
            case TCHomeFloorContentTypeOneToFour:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
                case TCHomeFloorContentTypeRecommend:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 4;
                attTitle.color = [UIColor blackColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
                
                NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                attPrice.lineSpacing = 0;
                attPrice.color = COLOR_PINK;
                attPrice.font = [UIFont systemFontOfSize:18];
                attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                attPrice.alignment = NSTextAlignmentRight;
                _attPrice = attPrice;
                
                NSMutableAttributedString *attSubTitle = [[NSMutableAttributedString alloc] initWithString:subTitle];
                attSubTitle.lineSpacing = 0;
                attSubTitle.color = [UIColor lightGrayColor];
                attSubTitle.font = [UIFont systemFontOfSize:15];
                attSubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attSubTitle.alignment = NSTextAlignmentLeft;
                _attSubTitle = attSubTitle;
                
            }
                break;
            case TCHomeFloorContentTypeFive:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
        }
    }
}

@end
