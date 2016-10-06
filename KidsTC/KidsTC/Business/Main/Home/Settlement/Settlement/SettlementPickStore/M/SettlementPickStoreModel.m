//
//  SettlementPickStoreModel.m
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementPickStoreModel.h"
#import "NSString+Category.h"

@implementation SettlementPickStoreDataItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    if (!_storeId) _storeId = [NSString stringWithFormat:@"%@",dic[@"storeNo"]];
    if (![_officeHoursDesc isNotNull]) _officeHoursDesc = [NSString stringWithFormat:@"%@",dic[@"hoursDesc"]];
    
    _storeDesc = [self setupStoreDesc];
    
    _pickStoreDesc = [self setupPickStoreDesc];
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

- (NSAttributedString *)setupPickStoreDesc{
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    
    if ([_officeHoursDesc isNotNull]) {
        NSAttributedString *officeHoursDescAttStr = [self attStrWith:[NSString stringWithFormat:@"营业时间：%@",_officeHoursDesc] fontSize:16 imageName:nil];
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

@implementation SettlementPickStoreModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [SettlementPickStoreDataItem class]};
}
@end
