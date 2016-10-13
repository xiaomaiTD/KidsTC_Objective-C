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
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:price];
                attTitle.lineSpacing = 0;
                attTitle.color = COLOR_PINK;
                attTitle.font = [UIFont systemFontOfSize:15];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentCenter;
                _attTitle = attTitle;
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
            case TCHomeFloorContentTypeThreeImageNews:
            case TCHomeFloorContentTypeWholeImageNews:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 6;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
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
                attTitle.alignment = NSTextAlignmentCenter;
                _attTitle = attTitle;
            }
                break;
            case TCHomeFloorContentTypeBigImageTwoDesc:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 0;
                attTitle.color = [UIColor darkGrayColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentCenter;
                _attTitle = attTitle;
            }
                break;
            case TCHomeFloorContentTypeOneToFour:
            {
                _attTitle = [NSAttributedString new];
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
