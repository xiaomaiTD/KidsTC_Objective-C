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
}TCHomeFloorContentType;

struct TCHomeContentLayoutAttributes {
    CGRect imgFrame;
    CGRect titleFrame;
    CGRect priceFrame;
    CGRect subTitleFrame;
    CGRect statusFrame;
};
typedef struct TCHomeContentLayoutAttributes TCHomeContentLayoutAttributes;
CG_INLINE TCHomeContentLayoutAttributes
TCHomeContentLayoutAttributesMake(CGRect imgFrame,
                                  CGRect titleFrame,
                                  CGRect priceFrame,
                                  CGRect subTitleFrame,
                                  CGRect statusFrame)
{
    TCHomeContentLayoutAttributes att;
    att.imgFrame = imgFrame;
    att.titleFrame = titleFrame;
    att.priceFrame = priceFrame;
    att.subTitleFrame = subTitleFrame;
    att.statusFrame = statusFrame;
    return att;
}

@interface TCHomeFloorContent : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) TCHomeFloorContentArticleParam *articleParam;
//以下三个属性只有当TCHomeFloor的contentType为13的时候才会有
@property (nonatomic, strong) NSString *subTitle;//右描述
@property (nonatomic, strong) NSString *linkKey;//文字
@property (nonatomic, strong) NSString *color;//linkKey的字体颜色
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attTitle;
@property (nonatomic, strong) NSAttributedString *attSubTitle;
@property (nonatomic, strong) NSAttributedString *attPrice;
@property (nonatomic, strong) NSAttributedString *attStatus;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, assign) TCHomeContentLayoutAttributes layoutAttributes;
@property (nonatomic, assign) TCHomeFloorContentType type;
- (void)setupAttTitle;
@end
