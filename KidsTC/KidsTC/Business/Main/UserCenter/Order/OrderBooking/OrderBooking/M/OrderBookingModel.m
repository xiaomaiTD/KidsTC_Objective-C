//
//  OrderBookingModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingModel.h"
#import "NSString+Category.h"
#import "NSDate+ZP.h"
#import "ZPDateFormate.h"
#import "NSNumber+ZP.h"
#import "NSString+ZP.h"

@implementation OrderBookingProductOnlineBespeakConfig


@end

@implementation OrderBookingOnlineBespeakTimeItem

@end

@implementation OrderBookingOnlineBespeakTimeConfigItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"times" : [OrderBookingOnlineBespeakTimeItem class]};
}
@end

@implementation OrderBookingTimeShowModel
+(instancetype)modelWithTimeInterval:(NSTimeInterval)timeInterval timesAry:(NSArray<NSString *> *)timesAry{
    OrderBookingTimeShowModel *model = [self new];
    NSString *dayStr = [NSString zp_stringWithTimeInterval:timeInterval Format:DF_yMd];
    if ([dayStr isNotNull] && timesAry.count>0) {
        model.dayStr = dayStr;
        model.weakStr = [self weakStrWithTimeInterval:timeInterval];
        model.timesAry = timesAry;
        model.timeInterval = timeInterval;
    }else{
        return nil;
    }
    return model;
}

+ (NSString *)weakStrWithTimeInterval:(NSTimeInterval)timeInterval {
    NSUInteger weak = [NSDate getWeak:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    switch (weak) {
        case 1:
        {
            return @"周一";
        }
            break;
        case 2:
        {
            return @"周二";
        }
            break;
        case 3:
        {
            return @"周三";
        }
            break;
        case 4:
        {
            return @"周四";
        }
            break;
        case 5:
        {
            return @"周五";
        }
            break;
        case 6:
        {
            return @"周六";
        }
            break;
        case 7:
        {
            return @"周天";
        }
            break;
            
        default:
        {
            return @"";
        }
            break;
    }
}

@end

@implementation OrderBookingProductInfo


@end

@implementation OrderBookingStoreInfo
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    _storeDesc = [self setupStoreDesc];
    
    return YES;
}

- (NSAttributedString *)setupStoreDesc{
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    
    if ([_storeName isNotNull]) {
        NSAttributedString *storeNameAttStr = [self attStrWith:_storeName fontSize:16 imageName:@"serviceSettle_store_01"];
        [mutableAttStr appendAttributedString:storeNameAttStr];
    }
    if ([_officeHoursDesc isNotNull]) {
        NSAttributedString *officeHoursDescAttStr = [self attStrWith:[NSString stringWithFormat:@"营业时间：%@",_officeHoursDesc] fontSize:16 imageName:@"serviceSettle_store_02"];
        if (mutableAttStr.length>0) [mutableAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [mutableAttStr appendAttributedString:officeHoursDescAttStr];
    }
    if ([_address isNotNull]) {
        NSAttributedString *addressAttStr = [self attStrWith:_address fontSize:16 imageName:@"serviceSettle_store_03"];
        if (mutableAttStr.length>0) [mutableAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [mutableAttStr appendAttributedString:addressAttStr];
    }
    if (mutableAttStr.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 8;
        [mutableAttStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, mutableAttStr.length)];
    }
    
    return mutableAttStr;
}
- (NSAttributedString *)attStrWith:(NSString *)str fontSize:(CGFloat)fontSize imageName:(NSString *)imageName{
    
    UIColor *color = [UIColor darkGrayColor];
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    NSAttributedString *imageAttStr = nil;
    if (imageName.length>0) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image = [UIImage imageNamed:imageName];
        attachment.bounds = CGRectMake(0, -3, font.lineHeight-3, font.lineHeight-3);
        NSMutableAttributedString *mutableImageAttStr = [[NSMutableAttributedString alloc] initWithString:@"  "];
        [mutableImageAttStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        imageAttStr = mutableImageAttStr;
    }
    
    NSDictionary *att = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]initWithString:str attributes:att];
    if(imageAttStr.length>0) [mutableAttStr insertAttributedString:imageAttStr atIndex:0];
    return mutableAttStr;
}
@end

@implementation OrderBookingUserBespeakInfo


@end

@implementation OrderBookingRemarkItem

@end

@implementation OrderBookingData

- (OrderBookingUserBespeakInfo *)userBespeakInfo {
    if (!_userBespeakInfo) {
        _userBespeakInfo = [OrderBookingUserBespeakInfo new];
    }
    return _userBespeakInfo;
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"onlineBespeakTimeConfig" : [OrderBookingOnlineBespeakTimeConfigItem class],
             @"supplierRemark":[OrderBookingRemarkItem class],
             @"userRemark":[OrderBookingRemarkItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    [self setupTimeShowModels];
    
    [self setupCurrentTimeShowModel];
    
    _supplierRemarkStr = [self setupRemark:_supplierRemark];
    
    return YES;
}

- (NSAttributedString *)setupRemark:(NSArray<OrderBookingRemarkItem *> *)remarks {
    if (remarks.count>0) {
        __block NSMutableAttributedString *remaksAttStr = [[NSMutableAttributedString alloc]init];
        [remarks enumerateObjectsUsingBlock:^(OrderBookingRemarkItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.remark isNotNull]) {
                NSString *remarkStr = [NSString stringWithFormat:@"%@%@",idx==0?@"":@"\n",obj.remark];
                NSAttributedString *remarkAttStr = [[NSAttributedString alloc]initWithString:remarkStr];
                [remaksAttStr appendAttributedString:remarkAttStr];
            }
        }];
        if (remaksAttStr.length>0) {
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                  NSParagraphStyleAttributeName:paragraph};
            [remaksAttStr addAttributes:att range:NSMakeRange(0, remaksAttStr.length)];
            return remaksAttStr;
        }
    }
    return nil;
}

- (void)setupCurrentTimeShowModel {
    [self setupTimeShowModel:_bespeakTime getModelBlock:^(OrderBookingTimeShowModel *model) {
        _currentTimeShowModel = model;
    }];
}

- (void)setupTimeShowModels {
    NSMutableArray<OrderBookingTimeShowModel *> *ary = [NSMutableArray array];
    [_onlineBespeakTimeConfig enumerateObjectsUsingBlock:^(OrderBookingOnlineBespeakTimeConfigItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupTimeShowModel:obj getModelBlock:^(OrderBookingTimeShowModel *model) {
            if (model) {
                [ary addObject:model];
            }
        }];
    }];
    _timeShowModels = ary;
}

- (void)setupTimeShowModel:(OrderBookingOnlineBespeakTimeConfigItem *)item getModelBlock:(void(^)(OrderBookingTimeShowModel *model))getModelBlock {
    NSString *startDate = item.startDate;
    NSString *endDate = item.endDate;
    
    if ([startDate isNotNull] && [endDate isNotNull]) {
        NSDate *sDate = [NSDate zp_dateWithTimeString:startDate withDateFormat:DF_yMd];
        NSDate *eDate = [NSDate zp_dateWithTimeString:endDate withDateFormat:DF_yMd];
        if (sDate && eDate) {
            NSMutableArray<NSString *> *timesAry = [NSMutableArray array];
            NSArray<OrderBookingOnlineBespeakTimeItem *> *times = item.times;
            [times enumerateObjectsUsingBlock:^(OrderBookingOnlineBespeakTimeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *startTime = obj.startTime;
                NSString *endTime = obj.endTime;
                if ([startTime isNotNull] && [endTime isNotNull]) {
                    NSDate *sTime = [NSDate zp_dateWithTimeString:startTime withDateFormat:DF_hm];
                    NSDate *eTime = [NSDate zp_dateWithTimeString:endTime withDateFormat:DF_hm];
                    if (sTime && eTime) {
                        NSString *timeStr = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
                        [timesAry addObject:timeStr];
                    }
                }
            }];
            if (timesAry.count>0) {
                NSTimeInterval sTimeInterval = [sDate timeIntervalSince1970];
                NSTimeInterval eTimeInterval = [eDate timeIntervalSince1970];
                while (sTimeInterval<=eTimeInterval) {
                    OrderBookingTimeShowModel *model = [OrderBookingTimeShowModel modelWithTimeInterval:sTimeInterval timesAry:timesAry];
                    if (model && getModelBlock) {
                        getModelBlock(model);
                    }
                    sTimeInterval += 60*60*24;
                }
            }
        }
    }
}

@end


@implementation OrderBookingModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
