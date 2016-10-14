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
        NSString *stattus = [NSString stringWithFormat:@"%@",@" 进行中"];
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
                attPrice.color = [UIColor darkGrayColor];
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
                case TCHomeFloorContentTypeRecommend:
            {
                NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                attTitle.lineSpacing = 6;
                attTitle.color = [UIColor blackColor];
                attTitle.font = [UIFont systemFontOfSize:17];
                attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attTitle.alignment = NSTextAlignmentLeft;
                _attTitle = attTitle;
                
                NSMutableAttributedString *attSubTitle = [[NSMutableAttributedString alloc] initWithString:subTitle];
                attSubTitle.lineSpacing = 0;
                attSubTitle.color = [UIColor darkGrayColor];
                attSubTitle.font = [UIFont systemFontOfSize:15];
                attSubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                attSubTitle.alignment = NSTextAlignmentLeft;
                _attSubTitle = attSubTitle;
                
                NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                attPrice.lineSpacing = 0;
                attPrice.color = COLOR_PINK;
                attPrice.font = [UIFont systemFontOfSize:18];
                attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                attPrice.alignment = NSTextAlignmentRight;
                _attPrice = attPrice;
                
                NSTextAttachment *imgAtt = [NSTextAttachment new];
                imgAtt.image = [UIImage imageNamed:@"icon_clock"];
                imgAtt.bounds = CGRectMake(0, -3, 15, 15);
                NSAttributedString *imgAttStr = [NSAttributedString attributedStringWithAttachment:imgAtt];
                NSMutableAttributedString *attStatus = [[NSMutableAttributedString alloc] initWithString:stattus];
                [attStatus insertAttributedString:imgAttStr atIndex:0];
                attStatus.lineSpacing = 0;
                attStatus.color = [UIColor darkGrayColor];
                attStatus.font = [UIFont systemFontOfSize:15];
                attStatus.lineBreakMode = NSLineBreakByTruncatingTail;
                attStatus.alignment = NSTextAlignmentRight;
                _attStatus = attStatus;
                
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
