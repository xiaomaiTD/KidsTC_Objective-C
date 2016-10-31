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

@implementation TCHomeRecommendItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *pid = [NSString stringWithFormat:@"%@",_serveId];
    NSString *cid = [NSString stringWithFormat:@"%@",_channelId];
    _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:@{@"pid":pid,@"cid":cid}];
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
    
    NSMutableAttributedString *attNum = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%zd",_saleNum]];
    attNum.color = COLOR_BLUE;
    NSMutableAttributedString *attSaleNum= [[NSMutableAttributedString alloc] initWithString:@"已售 "];
    attSaleNum.color = [UIColor lightGrayColor];
    [attSaleNum appendAttributedString:attNum];
    attSaleNum.font = [UIFont systemFontOfSize:15];
    attSaleNum.lineBreakMode = NSLineBreakByTruncatingTail;
    attSaleNum.alignment = NSTextAlignmentRight;
    content.attSaleNum = attSaleNum;
    
    NSString *processDesc = @" 进行中";
    if ([_processDesc isNotNull]) {
        processDesc = [NSString stringWithFormat:@" %@",_processDesc];
    }
    NSTextAttachment *imgAtt = [NSTextAttachment new];
    imgAtt.image = [UIImage imageNamed:@"icon_clock"];
    imgAtt.bounds = CGRectMake(0, -4, 13, 13);
    NSAttributedString *imgAttStr = [NSAttributedString attributedStringWithAttachment:imgAtt];
    NSMutableAttributedString *attStatus = [[NSMutableAttributedString alloc] initWithString:processDesc];
    [attStatus insertAttributedString:imgAttStr atIndex:0];
    attStatus.lineSpacing = 0;
    attStatus.color = [UIColor lightGrayColor];
    attStatus.font = [UIFont systemFontOfSize:14];
    attStatus.alignment = NSTextAlignmentRight;
    content.attStatus = attStatus;
    
    NSString *distance = [_storeDistance isNotNull]?[NSString stringWithFormat:@"距离 %@",_storeDistance]:@"";
    NSString *storeName = [_storeName isNotNull]?_storeName:@"";
    NSString *stoeAddress = [NSString stringWithFormat:@" %@%@",storeName, distance];
    if (stoeAddress.length>0) {
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"ProductDetail_02"];
        attachment.bounds = CGRectMake(0, -4, 13, 16);
        NSAttributedString *attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSMutableAttributedString *attStoreAddress = [[NSMutableAttributedString alloc] initWithString:stoeAddress];
        [attStoreAddress insertAttributedString:attachmentStr atIndex:0];
        attStoreAddress.lineSpacing = 0;
        attStoreAddress.color = [UIColor lightGrayColor];
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
    
    
    TCHomeFloor *floor = [TCHomeFloor new];
    floor.contents = @[content];
    floor.ratio = self.picRate;
    floor.contentType = TCHomeFloorContentTypeRecommend;
    floor.marginTop = 0.001;
    
    return floor;
}
@end
