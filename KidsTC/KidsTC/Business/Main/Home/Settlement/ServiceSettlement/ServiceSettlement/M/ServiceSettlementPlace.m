//
//  ServiceSettlementPlace.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementPlace.h"
#import "NSString+Category.h"

@implementation ServiceSettlementPlace

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    _placeDesc = [self setupPlaceDesc];
    
    return YES;
}

- (NSAttributedString *)setupPlaceDesc{
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    
    if ([_name isNotNull]) {
        NSAttributedString *storeNameAttStr = [self attStrWith:_name fontSize:14 imageName:@"serviceSettle_store_01"];
        [mutableAttStr appendAttributedString:storeNameAttStr];
    }
    
    if ([_address isNotNull]) {
        NSAttributedString *addressAttStr = [self attStrWith:_address fontSize:14 imageName:@"serviceSettle_store_03"];
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

+ (instancetype)placeWith:(WholesaleSettlementPlace *)place {
    ServiceSettlementPlace *obj = [ServiceSettlementPlace new];
    obj.sysNo = place.sysNo;
    obj.name = place.name;
    obj.address = place.address;
    obj.mapAddress = place.mapAddress;
    obj.distance = place.distance;
    return obj;
}
@end
