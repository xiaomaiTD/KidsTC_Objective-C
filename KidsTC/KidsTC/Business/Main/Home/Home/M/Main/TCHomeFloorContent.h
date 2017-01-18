//
//  TCHomeFloorContent.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
#import "TCHomeFloorContentArticleParam.h"

typedef enum {
    TCHomeFloorContentTypeBanner = 1,//banner
    TCHomeFloorContentTypeTwinklingElf = 2,//多个图标
    TCHomeFloorContentTypeHorizontalList = 3,//水平多张图片
    TCHomeFloorContentTypeThree = 4,//三张图片
    TCHomeFloorContentTypeTwoColumn = 5,//两列
    TCHomeFloorContentTypeNews = 6,//不带图片的资讯
    TCHomeFloorContentTypeImageNews = 7,//带一张图片的资讯
    TCHomeFloorContentTypeThreeImageNews = 8,//带三张图片的资讯
    TCHomeFloorContentTypeWholeImageNews = 11,//带一张大图的资讯
    TCHomeFloorContentTypeNotice = 12,//童成热点，上下无限滚动
    TCHomeFloorContentTypeBigImageTwoDesc = 13,//一张大图，下面带左右描述
    TCHomeFloorContentTypeOneToFour = 14,//1~4张图片
    TCHomeFloorContentTypeRecommend = 15,//为你推荐
    TCHomeFloorContentTypeFive = 16,//5张图片
    TCHomeFloorContentTypeTwoColumns = 17,//两个一排
    TCHomeFloorContentTypeThreeScroll = 18,//三个半图滚动
}TCHomeFloorContentType;



struct TCHomeContentLayoutAttributes {
    
    BOOL showBGView;
    
    BOOL showImg;
    BOOL showTipImg;
    
    BOOL showPrice;
    BOOL showTitle;
    
    BOOL showSubImg;
    
    BOOL showSaleNum;
    BOOL showSubTitle;
    
    BOOL showStatus;
    BOOL showStoreAddress;
    
    BOOL showDiscount;
    BOOL showBtnDesc;
    
    BOOL isProductRecommend;
    
    BOOL showLine;
    
    CGRect bgViewFrame;
    
    CGRect imgFrame;
    CGRect tipImgFrame;
    
    CGRect priceFrame;
    CGRect titleFrame;
    
    CGRect subImgFrame;
    
    CGRect saleNumFrame;
    CGRect subTitleFrame;
    
    CGRect statusFrame;
    CGRect storeAddressFrme;
    
    CGRect discountFrame;
    CGRect btnDescFrame;
    
    CGRect lineFrame;
};
typedef struct TCHomeContentLayoutAttributes TCHomeContentLayoutAttributes;
CG_INLINE TCHomeContentLayoutAttributes
TCHomeContentLayoutAttributesMake(BOOL showImg,
                                  BOOL showTipImg,
                                  
                                  BOOL showPrice,
                                  BOOL showTitle,
                                  
                                  BOOL showSubImg,
                                  
                                  BOOL showSaleNum,
                                  BOOL showSubTitle,
                                  
                                  BOOL showStatus,
                                  BOOL showStoreAddress,
                                  
                                  BOOL showLine,
                                  
                                  CGRect imgFrame,
                                  CGRect tipImgFrame,
                                  
                                  CGRect priceFrame,
                                  CGRect titleFrame,
                                  
                                  CGRect subImgFrame,
                                  
                                  CGRect saleNumFrame,
                                  CGRect subTitleFrame,
                                  
                                  CGRect statusFrame,
                                  CGRect storeAddressFrme,
                                  
                                  CGRect lineFrame)
{
    TCHomeContentLayoutAttributes att;
    
    att.showImg = showImg;
    att.showTipImg = showTipImg;
    
    att.showPrice = showPrice;
    att.showTitle = showTitle;
    
    att.showSubImg = showSubImg;
    
    att.showSaleNum = showSaleNum;
    att.showSubTitle = showSubTitle;
    
    att.showStatus = showStatus;
    att.showStoreAddress = showStoreAddress;
    
    att.showDiscount = NO;
    att.showBtnDesc = NO;
    att.isProductRecommend = NO;
    
    att.showLine = showLine;
    
    att.imgFrame = imgFrame;
    att.tipImgFrame = tipImgFrame;
    
    att.priceFrame = priceFrame;
    att.titleFrame = titleFrame;
    
    att.subImgFrame = subImgFrame;
    
    att.saleNumFrame = saleNumFrame;
    att.subTitleFrame = subTitleFrame;
    
    att.statusFrame = statusFrame;
    att.storeAddressFrme = storeAddressFrme;
    
    att.lineFrame = lineFrame;
    
    return att;
}

typedef enum : NSUInteger {
    TCHomeFloorContentSubImgTypeLocal=1,
    TCHomeFloorContentSubImgTypeUrl
} TCHomeFloorContentSubImgType;

@interface TCHomeFloorContent : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) TCHomeFloorContentArticleParam *articleParam;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//以下三个属性只有当TCHomeFloor的contentType为13的时候才会有
@property (nonatomic, strong) NSString *subTitle;//右描述
@property (nonatomic, strong) NSString *linkKey;//文字
@property (nonatomic, strong) NSString *color;//linkKey的字体颜色
//以下两个属性只有当TCHomeFloor的contentType为16的时候才会有
@property (nonatomic, assign) CGFloat widthScale;
@property (nonatomic, assign) CGFloat heightScale;
@property (nonatomic, strong) NSString *storePrice;

//selfDefine
@property (nonatomic, strong) NSAttributedString *attTitle;
@property (nonatomic, strong) NSAttributedString *attPrice;
@property (nonatomic, strong) NSAttributedString *attStoreAddress;
@property (nonatomic, strong) NSAttributedString *attSaleNum;
@property (nonatomic, strong) NSAttributedString *attSubTitle;
@property (nonatomic, strong) NSAttributedString *attStatus;
@property (nonatomic, strong) NSAttributedString *attDiscountDesc;
@property (nonatomic, strong) NSAttributedString *attBtnDesc;
@property (nonatomic, strong) NSAttributedString *attStorePrice;
@property (nonatomic, strong) NSString *subImgName;
@property (nonatomic, assign) TCHomeFloorContentSubImgType subImgType;
@property (nonatomic, strong) NSString *tipImgName;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, assign) TCHomeContentLayoutAttributes layoutAttributes;
@property (nonatomic, assign) TCHomeFloorContentType type;
- (void)setupAttTitle;
@end
