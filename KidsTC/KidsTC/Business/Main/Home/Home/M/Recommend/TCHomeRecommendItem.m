//
//  TCHomeRecommendItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeRecommendItem.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "Colours.h"
#import "ProductDetailSegueParser.h"

@implementation TCHomeRecommendItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productRedirect productId:_serveId channelId:_channelId openGroupId:nil];
    return YES;
}
- (TCHomeFloor *)conventToFloor {
    
    TCHomeFloorContent *content = [TCHomeFloorContent new];
    content.imageUrl = self.imgUrl;
    content.title = self.serveName;
    content.subTitle = self.promotionText;
    content.price = self.price;
    content.segueModel = self.segueModel;
    NSString *tipImgName = nil;
    switch (_reProductType) {
        case TCHomeRecommendProductTypeNew:
        {
            tipImgName = @"rec01";
        }
            break;
        case TCHomeRecommendProductTypeHot:
        {
            tipImgName = @"rec02";
        }
            break;
        case TCHomeRecommendProductTypePopularity:
        {
            tipImgName = @"rec03";
        }
            break;
        case TCHomeRecommendProductTypePreference:
        {
            tipImgName = @"rec05";
        }
            break;
    }
    content.tipImgName = tipImgName;
    
    if ([_joinDesc isNotNull]) {
        NSMutableAttributedString *attSaleNum= [[NSMutableAttributedString alloc] initWithString:_joinDesc];
        attSaleNum.color = [UIColor colorFromHexString:@"222222"];
        attSaleNum.font = [UIFont systemFontOfSize:14];
        attSaleNum.lineBreakMode = NSLineBreakByTruncatingTail;
        attSaleNum.alignment = NSTextAlignmentRight;
        content.attSaleNum = attSaleNum;
    }
    
    NSString *processDesc = @" 进行中";
    if ([_processDesc isNotNull]) {
        processDesc = [NSString stringWithFormat:@" %@",_processDesc];
    }
    NSTextAttachment *imgAtt = [NSTextAttachment new];
    imgAtt.image = [UIImage imageNamed:@"icon_clock"];
    imgAtt.bounds = CGRectMake(0, -1, 13, 13);
    NSAttributedString *imgAttStr = [NSAttributedString attributedStringWithAttachment:imgAtt];
    NSMutableAttributedString *attStatus = [[NSMutableAttributedString alloc] initWithString:processDesc];
    [attStatus insertAttributedString:imgAttStr atIndex:0];
    attStatus.lineSpacing = 0;
    attStatus.color = [UIColor colorFromHexString:@"333333"];
    attStatus.font = [UIFont systemFontOfSize:14];
    attStatus.alignment = NSTextAlignmentLeft;
    content.attStatus = attStatus;
    
    NSString *distance = [_storeDistance isNotNull]?[NSString stringWithFormat:@"距离 %@",_storeDistance]:@"";
    NSString *storeName = [_storeName isNotNull]?_storeName:@"";
    if ([storeName isNotNull] && [distance isNotNull]) {
        
        NSString *stoeAddress = [NSString stringWithFormat:@" %@%@",storeName, distance];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"home_recommend_local"];
        attachment.bounds = CGRectMake(0, -2, 11, 14);
        NSAttributedString *attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSMutableAttributedString *attStoreAddress = [[NSMutableAttributedString alloc] initWithString:stoeAddress];
        [attStoreAddress insertAttributedString:attachmentStr atIndex:0];
        attStoreAddress.lineSpacing = 0;
        attStoreAddress.color = [UIColor colorFromHexString:@"333333"];
        attStoreAddress.font = [UIFont systemFontOfSize:14];
        attStoreAddress.lineBreakMode = NSLineBreakByTruncatingTail;
        attStoreAddress.alignment = NSTextAlignmentLeft;
        content.attStoreAddress = attStoreAddress;
    }else{
        content.attStoreAddress = nil;
    }
    
    NSString *subImgName = nil;
    if (_promotionIcon) {
        switch (_promotionIcon.iconType) {
            case TCHomeRecommendPromotionIconTypeLocal:
            {
                subImgName = @"home_sub_01";
                content.subImgType = TCHomeFloorContentSubImgTypeLocal;
            }
                break;
            case TCHomeRecommendPromotionIconTypeUrl:
            {
                if ([_promotionIcon.iconUrl isNotNull]) {
                    subImgName = _promotionIcon.iconUrl;
                    content.subImgType = TCHomeFloorContentSubImgTypeUrl;
                }else{
                    subImgName = @"home_sub_01";
                    content.subImgType = TCHomeFloorContentSubImgTypeLocal;
                }
            }
                break;
            default:
            {
                subImgName = nil;
            }
                break;
        }
    }
    content.subImgName = subImgName;
    
    if ([_priceRate isNotNull]) {
        NSMutableAttributedString *attDiscountDesc = [[NSMutableAttributedString alloc] initWithString:_priceRate];
        attDiscountDesc.lineSpacing = 1;
        attDiscountDesc.color = [UIColor whiteColor];
        attDiscountDesc.font = [UIFont systemFontOfSize:10];
        attDiscountDesc.lineBreakMode = NSLineBreakByTruncatingTail;
        attDiscountDesc.alignment = NSTextAlignmentCenter;
        content.attDiscountDesc = attDiscountDesc;
    }
    
    if ([_btnName isNotNull]) {
        NSMutableAttributedString *attBtnDesc = [[NSMutableAttributedString alloc] initWithString:_btnName];
        attBtnDesc.lineSpacing = 1;
        attBtnDesc.color = [UIColor whiteColor];
        attBtnDesc.font = [UIFont systemFontOfSize:16];
        attBtnDesc.lineBreakMode = NSLineBreakByTruncatingTail;
        attBtnDesc.alignment = NSTextAlignmentCenter;
        content.attBtnDesc = attBtnDesc;
    }
    
    TCHomeFloor *floor = [TCHomeFloor new];
    floor.contents = @[content];
    floor.ratio = self.picRate;
    floor.contentType = TCHomeFloorContentTypeRecommend;
    floor.marginTop = 0.001;
    
    return floor;
}
@end
