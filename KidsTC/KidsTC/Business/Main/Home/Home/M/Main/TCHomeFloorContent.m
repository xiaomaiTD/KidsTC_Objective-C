//
//  TCHomeFloorContent.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorContent.h"
#import "NSAttributedString+YYText.h"
#import "Colours.h"
#import "NSString+Category.h"

@implementation TCHomeFloorContent
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    return YES;
}

- (void)setupAttTitle {
    if (!_attTitle) {
        NSString *title = [NSString stringWithFormat:@"%@",_title];
        NSString *subTitle = [NSString stringWithFormat:@"%@",_subTitle];
        NSString *price = [NSString stringWithFormat:@"%@",_price];
        switch (_type) {
            case TCHomeFloorContentTypeBanner:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
            case TCHomeFloorContentTypeTwinklingElf:
            {
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 0;
                    attTitle.color = [UIColor darkGrayColor];
                    attTitle.font = [UIFont systemFontOfSize:14];
                    attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                    attTitle.alignment = NSTextAlignmentCenter;
                    _attTitle = attTitle;
                }
            }
                break;
            case TCHomeFloorContentTypeHorizontalList:
            {
                if ([price isNotNull]) {
                    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                    attPrice.lineSpacing = 0;
                    attPrice.color = [UIColor colorFromHexString:@"f36863"];
                    attPrice.font = [UIFont systemFontOfSize:15];
                    attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                    attPrice.alignment = NSTextAlignmentCenter;
                    _attPrice = attPrice;
                }
                if ([_storePrice isNotNull]) {
                    NSMutableAttributedString *attStorePrice = [[NSMutableAttributedString alloc] initWithString:_storePrice];
                    attStorePrice.lineSpacing = 0;
                    attStorePrice.color = [UIColor colorFromHexString:@"a9a9a9"];
                    attStorePrice.font = [UIFont systemFontOfSize:11];
                    attStorePrice.lineBreakMode = NSLineBreakByTruncatingTail;
                    attStorePrice.alignment = NSTextAlignmentCenter;
                    [attStorePrice setStrikethroughStyle:NSUnderlineStyleSingle];

                    _attTitle = attStorePrice;
                }
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
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 4;
                    attTitle.color = [UIColor darkGrayColor];
                    attTitle.font = [UIFont systemFontOfSize:17];
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
                
                _attSubTitle = _articleParam.articleStr;
            }
                break;
            case TCHomeFloorContentTypeThreeImageNews:
            {
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 4;
                    attTitle.color = [UIColor darkGrayColor];
                    attTitle.font = [UIFont systemFontOfSize:17];
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
                
                _attSubTitle = _articleParam.articleStr;
            }
                break;
            case TCHomeFloorContentTypeWholeImageNews:
            {
                if ([title isNotNull]) {
                    title = [NSString stringWithFormat:@"  %@",title];
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 4;
                    attTitle.color = [UIColor whiteColor];
                    attTitle.font = [UIFont systemFontOfSize:17];
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
            }
                break;
            case TCHomeFloorContentTypeNotice:
            {
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 0;
                    attTitle.color = [UIColor darkGrayColor];
                    attTitle.font = [UIFont systemFontOfSize:17];
                    attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
            }
                break;
            case TCHomeFloorContentTypeBigImageTwoDesc:
            {
                if ([title isNotNull]) {
                    NSRange range = [title rangeOfString:_linkKey];
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 0;
                    attTitle.color = [UIColor darkGrayColor];
                    attTitle.font = [UIFont systemFontOfSize:15];
                    attTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                    attTitle.alignment = NSTextAlignmentLeft;
                    [attTitle setColor:COLOR_PINK range:range];
                    _attTitle = attTitle;
                }
                if ([subTitle isNotNull]) {
                    NSMutableAttributedString *attSubTitle = [[NSMutableAttributedString alloc] initWithString:subTitle];
                    attSubTitle.lineSpacing = 0;
                    attSubTitle.color = [UIColor lightGrayColor];
                    attSubTitle.font = [UIFont systemFontOfSize:15];
                    attSubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                    attSubTitle.alignment = NSTextAlignmentLeft;
                    _attSubTitle = attSubTitle;
                }
            }
                break;
            case TCHomeFloorContentTypeOneToFour:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
                case TCHomeFloorContentTypeRecommend:
            {
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.lineSpacing = 4;
                    attTitle.color = [UIColor colorFromHexString:@"222222"];
                    attTitle.font = [UIFont systemFontOfSize:17];
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
                if ([price isNotNull]) {
                    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                    attPrice.lineSpacing = 0;
                    attPrice.color = [UIColor colorFromHexString:@"F36863"];
                    attPrice.font = [UIFont systemFontOfSize:17];
                    attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                    attPrice.alignment = NSTextAlignmentRight;
                    
                    if ([_priceSuffix isNotNull]) {
                        NSMutableAttributedString *attPriceSuffix = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",_priceSuffix]];
                        attPriceSuffix.lineSpacing = 0;
                        attPriceSuffix.color = [UIColor colorFromHexString:@"444444"];
                        attPriceSuffix.font = [UIFont systemFontOfSize:12];
                        attPriceSuffix.lineBreakMode = NSLineBreakByTruncatingTail;
                        attPriceSuffix.alignment = NSTextAlignmentRight;
                        [attPrice appendAttributedString:attPriceSuffix];
                    }
                    
                    _attPrice = attPrice;
                }
                if ([subTitle isNotNull]) {
                    NSMutableAttributedString *attSubTitle = [[NSMutableAttributedString alloc] initWithString:subTitle];
                    attSubTitle.lineSpacing = 0;
                    attSubTitle.color = [UIColor colorFromHexString:@"9C9C9C"];
                    attSubTitle.font = [UIFont systemFontOfSize:14];
                    attSubTitle.lineBreakMode = NSLineBreakByTruncatingTail;
                    attSubTitle.alignment = NSTextAlignmentLeft;
                    _attSubTitle = attSubTitle;
                }
            }
                break;
            case TCHomeFloorContentTypeFive:
            {
                _attTitle = [NSAttributedString new];
            }
                break;
            case TCHomeFloorContentTypeTwoColumns:
            {
                
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.color = [UIColor colorFromHexString:@"333333"];
                    attTitle.font = [UIFont systemFontOfSize:14];
                    _attTitle = attTitle;
                }
                
                if ([_discount isNotNull]) {
                    NSMutableAttributedString *attDiscountDesc = [[NSMutableAttributedString alloc] initWithString:_discount];
                    attDiscountDesc.color = [UIColor whiteColor];
                    attDiscountDesc.font = [UIFont systemFontOfSize:11];
                    attDiscountDesc.alignment = NSTextAlignmentCenter;
                    _attDiscountDesc = attDiscountDesc;
                }
                
                if ([price isNotNull]) {
                    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                    attPrice.lineSpacing = 0;
                    attPrice.color = [UIColor colorFromHexString:@"ff4a47"];
                    attPrice.font = [UIFont systemFontOfSize:15];
                    attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                    attPrice.alignment = NSTextAlignmentLeft;
                    
                    if ([_priceSuffix isNotNull]) {
                        NSMutableAttributedString *attPriceTip = [[NSMutableAttributedString alloc] initWithString:_priceSuffix];
                        attPriceTip.lineSpacing = 0;
                        attPriceTip.color = [UIColor colorFromHexString:@"555555"];
                        attPriceTip.font = [UIFont systemFontOfSize:11];
                        attPriceTip.lineBreakMode = NSLineBreakByTruncatingTail;
                        attPriceTip.alignment = NSTextAlignmentLeft;
                        [attPrice appendAttributedString:attPriceTip];
                    }
                    _attPrice = attPrice;
                }
            }
                break;
            case TCHomeFloorContentTypeThreeScroll:
            {
                if ([title isNotNull]) {
                    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    attTitle.color = [UIColor colorFromHexString:@"333333"];
                    attTitle.font = [UIFont systemFontOfSize:15];
                    attTitle.alignment = NSTextAlignmentLeft;
                    _attTitle = attTitle;
                }
                
                if (_address) {
                    NSMutableAttributedString *attStoreAddress = [[NSMutableAttributedString alloc] initWithString:title];
                    attStoreAddress.color = [UIColor colorFromHexString:@"A9A9A9"];
                    attStoreAddress.font = [UIFont systemFontOfSize:11];
                    attStoreAddress.alignment = NSTextAlignmentLeft;
                    _attStoreAddress = attStoreAddress;
                }
                
                if ([price isNotNull]) {
                    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:price];
                    attPrice.lineSpacing = 0;
                    attPrice.color = [UIColor colorFromHexString:@"FF4A47"];
                    attPrice.font = [UIFont systemFontOfSize:15];
                    attPrice.lineBreakMode = NSLineBreakByTruncatingTail;
                    attPrice.alignment = NSTextAlignmentLeft;
                    
                    if ([_priceSuffix isNotNull]) {
                        NSMutableAttributedString *attPriceTip = [[NSMutableAttributedString alloc] initWithString:_priceSuffix];
                        attPriceTip.lineSpacing = 0;
                        attPriceTip.color = [UIColor colorFromHexString:@"555555"];
                        attPriceTip.font = [UIFont systemFontOfSize:10];
                        attPriceTip.lineBreakMode = NSLineBreakByTruncatingTail;
                        attPriceTip.alignment = NSTextAlignmentLeft;
                        [attPrice appendAttributedString:attPriceTip];
                    }
                    _attPrice = attPrice;
                }
                
            }
                break;
        }
    }
}

@end
