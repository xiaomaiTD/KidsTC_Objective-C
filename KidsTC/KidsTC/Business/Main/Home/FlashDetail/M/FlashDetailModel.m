//
//  FlashDetailModel.m
//  KidsTC
//
//  Created by zhanping on 5/16/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FlashDetailModel.h"
#import "FDCommentLayout.h"
#import "YYKit.h"

@implementation FDPriceConfigsItem

@end

@implementation FDPromotionLinkItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_color isEqualToString:@""] && _color) {
        NSArray *ary = [_color componentsSeparatedByString:@","];
        if (ary.count>=3) {
            _uiColor = [UIColor colorWithRed:[ary[0] floatValue]/225.0
                                       green:[ary[1] floatValue]/225.0
                                        blue:[ary[2] floatValue]/225.0
                                       alpha:1];
        }
    }
    return YES;
}
@end

@implementation FDStoreItem

@end

@implementation FDComment

@end

@implementation FDNote

@end

@implementation FDBuyNoticeItem

@end

@implementation FSScoreDetailItem

@end

@implementation FCSoreItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"ScoreDetail" : [FSScoreDetailItem class]};
}

@end

@implementation FDCommentListItem
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"cid" : @"id"};
}
@end

@implementation FDShare

@end
/**
 *  NSArray<FDPromotionLinkItem *> *promotionLink;
 */
@implementation FDData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"priceConfigs" : [FDPriceConfigsItem class],
             @"imgUrl" : [NSString class],
             @"narrowImg" : [NSString class],
             @"age" : [NSString class],
             @"promotionLink" : [FDPromotionLinkItem class],
             @"store" : [NSDictionary class],
             @"buyNotice" : [FDBuyNoticeItem class],
             @"commentList" : [NSDictionary class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableArray *storeModels = [NSMutableArray array];
    if (_store && [_store isKindOfClass:[NSArray class]]) {
        [_store enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDStoreItem *storeItem = [FDStoreItem modelWithDictionary:obj];
            [storeModels addObject:storeItem];
        }];
        _storeModels = storeModels;
    }
    
    NSMutableArray *commentModelList = [NSMutableArray array];
    if (_commentList && [_commentList isKindOfClass:[NSArray class]]) {
        [_commentList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDCommentListItem *commentListItem = [FDCommentListItem modelWithDictionary:obj];
            [commentModelList addObject:commentListItem];
        }];
        _commentModelList = commentModelList;
    }
    
    NSMutableArray *commentModelLayouts = [NSMutableArray array];
    if (_commentModelList && [_commentModelList isKindOfClass:[NSArray class]]) {
        [_commentModelList enumerateObjectsUsingBlock:^(FDCommentListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDCommentLayout *layout = [FDCommentLayout commentLayoutWithItem:obj];
            [commentModelLayouts addObject:layout];
        }];
        _commentModelLayouts = commentModelLayouts;
    }
    
    return YES;
}

- (NSAttributedString *)countDownValueString{
    
    UIFont *font = [UIFont systemFontOfSize:13];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:self.countDownValue];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    
    NSString *time = @"";
    if (components.year>0) {
        time = [NSString stringWithFormat:@"%.2zd年%.2zd月%.2zd天%.2zd时%.2zd分%.2zd秒",components.year,components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.month>0){
        time = [NSString stringWithFormat:@"%.2zd月%.2zd天%.2zd时%.2zd分%.2zd秒",components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.day>0){
        time = [NSString stringWithFormat:@"%.2zd天%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        time = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        time = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    
    UIImage *image = [[UIImage imageNamed:@"countdownClock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.bounds = CGRectMake(0, -1.5, font.lineHeight-3, font.lineHeight-3);
    attachment.image = image;
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSAttributedString *timeStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ | %@",self.countDownStr,time]];
    
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc]init];
    [totalStr appendAttributedString:imageStr];
    [totalStr appendAttributedString:timeStr];
    
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:[UIColor colorWithRed:0.688  green:0.621  blue:0.545 alpha:1]};
    [totalStr addAttributes:attributes range:NSMakeRange(0, totalStr.length)];
    
    _countDownValue--;
   
    return totalStr;
}

@end

@implementation FlashDetailModel

@end
