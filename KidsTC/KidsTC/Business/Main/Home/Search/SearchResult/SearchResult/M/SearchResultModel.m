//
//  SearchResultModel.m
//  KidsTC
//
//  Created by zhanping on 7/5/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultModel.h"
#import "Macro.h"

/**
 *  =========================================================
 */

@implementation SearchResultProductItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"fullCut" : [NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_price.length==0) {
        _price = @"0.00";
    }
    NSAttributedString *sstStr = [self attributeStringTitle:@" 随时退" boolValue:_isSst];
    NSAttributedString *gqtStr = [self attributeStringTitle:@" 过期退" boolValue:_isGqt];
    NSAttributedString *bftStr = [self attributeStringTitle:@" 部分退" boolValue:_isBft];
    
    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc]init];
    if (sstStr.length>0) [tipStr appendAttributedString:sstStr];
    if (gqtStr.length>0) [tipStr appendAttributedString:gqtStr];
    if (bftStr.length>0) [tipStr appendAttributedString:bftStr];
    if (tipStr.length>0) _tipStr = tipStr;
    
    _firstFullCutStr = [self attributeStringWithStringArray:_fullCut attachmentImageName:@"activitylogo_discount"];
    
    _cellHeight = 104;
    if (_firstFullCutStr.length>0) {
        _cellHeight = 137;
    }
    return YES;
}

- (NSAttributedString *)attributeStringTitle:(NSString *)title boolValue:(BOOL)boolValue{
    
    if (boolValue) {
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor colorWithRed:0.347  green:0.820  blue:0.627 alpha:1];
        
        NSAttributedString *emptyStr = [[NSAttributedString alloc]initWithString:@"  "];
        
        NSTextAttachment *imageArrachment = [[NSTextAttachment alloc]init];
        imageArrachment.image = [UIImage imageNamed:@"insurance_checked"];
        NSAttributedString *imageAttributeStr = [NSAttributedString attributedStringWithAttachment:imageArrachment];
        imageArrachment.bounds = CGRectMake(0, -2, font.lineHeight-2, font.lineHeight-2);
        
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:color};
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:title attributes:attributes];
        [attributeString insertAttributedString:imageAttributeStr atIndex:0];
        [attributeString insertAttributedString:emptyStr atIndex:0];
        [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributeString.length)];
        return attributeString;
    }
    return nil;
}

- (NSAttributedString *)attributeStringWithStringArray:(NSArray<NSString *> *)stringArray attachmentImageName:(NSString *)attachmentImageName{
    NSAttributedString *attributeString = nil;
    for (NSString *string in stringArray) {
        NSAttributedString *tempAttributeString = [self attributeStringWithString:string attachmentImageName:attachmentImageName];
        if (tempAttributeString.length>0) {
            attributeString = tempAttributeString;
            break;
        }
    }
    return attributeString;
}

- (NSAttributedString *)attributeStringWithString:(NSString *)string attachmentImageName:(NSString *)attachmentImageName{
    
    if (string.length>0) {
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor colorWithRed:1  green:0.503  blue:0 alpha:1];
        
        NSTextAttachment *imageArrachment = [[NSTextAttachment alloc]init];
        imageArrachment.image = [UIImage imageNamed:attachmentImageName];
        NSAttributedString *imageAttributeStr = [NSAttributedString attributedStringWithAttachment:imageArrachment];
        imageArrachment.bounds = CGRectMake(0, -1.5, font.lineHeight-3, font.lineHeight-3);
        
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:color};
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string] attributes:attributes];
        [attributeString insertAttributedString:imageAttributeStr atIndex:0];
        return attributeString;
    }
    return nil;
}

@end

@implementation SearchResultProductModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [SearchResultProductItem class]};
}

@end


/**
 *  =========================================================
 */

@implementation SearchResultStoreItemEvent
@end

@implementation SearchResultStoreItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"storeGift" : [NSString class],
             @"storeDiscount" : [NSString class],
             @"fullCut" : [NSString class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _commentCountStr = [self attributeStringWithCount:_commentCount tipStr:@"条热评"];
    
    _firstStoreGiftStr = [self attributeStringWithStringArray:_storeGift attachmentImageName:@"activitylogo_gift"];
    
    _firstFullCutStr = [self attributeStringWithStringArray:_fullCut attachmentImageName:@"activitylogo_discount"];
    
    _firstStoreDiscountStr = [self attributeStringWithStringArray:_storeDiscount attachmentImageName:@"activitylogo_preferential"];
    
    _haveActivity = NO;
    if (_firstStoreGiftStr.length>0 ||
        _firstFullCutStr.length>0 ||
        _firstStoreDiscountStr.length>0) {
        _haveActivity = YES;
    }
    
    _cellHeight = 104;
    if (_haveActivity) {
        _cellHeight = 113;
        if (_firstStoreGiftStr.length>0) {
            _cellHeight +=24;
        }
        if (_firstFullCutStr.length>0) {
            _cellHeight +=24;
        }
        if (_firstStoreDiscountStr.length>0) {
            _cellHeight +=24;
        }
    }
    
    return YES;
}

- (NSAttributedString *)attributeStringWithCount:(NSInteger)count tipStr:(NSString *)tipStr{
    if (count>0) {
        NSString *countStr = [NSString stringWithFormat:@"%zd",count];
        UIFont *font = [UIFont systemFontOfSize:13];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:countStr
                                                                                           attributes:@{NSForegroundColorAttributeName:COLOR_BLUE}];
        NSAttributedString *tipAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",tipStr]
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        [attributeString appendAttributedString:tipAttStr];
        [attributeString addAttribute:NSFontAttributeName value:font range:NSRangeFromString(attributeString.string)];
        return attributeString;
    }
    return nil;
}

- (NSAttributedString *)attributeStringWithStringArray:(NSArray<NSString *> *)stringArray attachmentImageName:(NSString *)attachmentImageName{
    NSAttributedString *attributeString = nil;
    for (NSString *string in stringArray) {
        NSAttributedString *tempAttributeString = [self attributeStringWithString:string attachmentImageName:attachmentImageName];
        if (tempAttributeString.length>0) {
            attributeString = tempAttributeString;
            break;
        }
    }
    return attributeString;
}

- (NSAttributedString *)attributeStringWithString:(NSString *)string attachmentImageName:(NSString *)attachmentImageName{
    
    if (string.length>0) {
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *color = [UIColor colorWithRed:1  green:0.503  blue:0 alpha:1];
        
        NSTextAttachment *imageArrachment = [[NSTextAttachment alloc]init];
        imageArrachment.image = [UIImage imageNamed:attachmentImageName];
        NSAttributedString *imageAttributeStr = [NSAttributedString attributedStringWithAttachment:imageArrachment];
        imageArrachment.bounds = CGRectMake(0, -1.5, font.lineHeight-3, font.lineHeight-3);
        
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:color};
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string] attributes:attributes];
        [attributeString insertAttributedString:imageAttributeStr atIndex:0];
        return attributeString;
    }
    return nil;
}

@end

@implementation SearchResultStoreModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"data" : [SearchResultStoreItem class]};
}

@end

/**
 *  =========================================================
 */

@implementation SearchResultArticleItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation SearchResultArticleModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [SearchResultArticleItem class]};
}
@end

