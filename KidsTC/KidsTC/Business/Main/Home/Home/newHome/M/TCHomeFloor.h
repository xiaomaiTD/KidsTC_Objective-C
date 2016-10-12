//
//  TCHomeFloor.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloorTitleContent.h"
#import "TCHomeFloorContent.h"
typedef enum {
    TCHomeFloorTitleContentTypeNormalTitle = 1,
    TCHomeFloorTitleContentTypeMoreTitle,
    TCHomeFloorTitleContentTypeCountDownTitle,
    TCHomeFloorTitleContentTypeCountDownMoreTitle
}TCHomeFloorTitleContentType;

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
}TCHomeFloorContentType;

@interface TCHomeFloor : NSObject
@property (nonatomic, assign) BOOL hasTitle;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) TCHomeFloorTitleContentType titleType;
@property (nonatomic, strong) TCHomeFloorTitleContent *titleContent;
@property (nonatomic, assign) TCHomeFloorContentType contentType;
@property (nonatomic, strong) NSArray<TCHomeFloorContent *> *contents;
//以下这个属性只有在contentType为2的时候才会有
@property (nonatomic, strong) NSString *bgImgUrl;
//以下两个属性只有在contentType为5的时候才会有
@property (nonatomic, assign) CGFloat centerSeparation;//左右间距
@property (nonatomic, assign) CGFloat bottomSeparation;//底部间距
/**SelfDefine*/
@property (nonatomic, assign) CGFloat floorHeight;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
@end
