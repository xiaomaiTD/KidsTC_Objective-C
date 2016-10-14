//
//  TCHomeRecommendItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeRecommendItem.h"

@implementation TCHomeRecommendItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *pid = [NSString stringWithFormat:@"%@",_serveId];
    NSString *cid = [NSString stringWithFormat:@"%@",_channelId];
    _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:@{@"pid":pid,@"cid":cid}];
    return YES;
}
- (TCHomeFloor *)conventToFloor {
    
    /*
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
     @property (nonatomic, strong) SegueModel *segueModel;
     @property (nonatomic, assign) TCHomeContentLayoutAttributes layoutAttributes;
     @property (nonatomic, assign) TCHomeFloorContentType type;
     */
    
    /*
     //@property (nonatomic, assign) <#type#> reProductType;
     @property (nonatomic, strong) NSString *serveName;
     @property (nonatomic, strong) NSString *price;
     @property (nonatomic, strong) NSString *imgUrl;
     @property (nonatomic, assign) CGFloat picRate;
     @property (nonatomic, strong) NSString *promotionText;
     */
    
    TCHomeFloorContent *content = [TCHomeFloorContent new];
    content.imageUrl = self.imgUrl;
    content.title = self.serveName;
    content.subTitle = self.promotionText;
    content.price = self.price;
    content.segueModel = self.segueModel;
    
    TCHomeFloor *floor = [TCHomeFloor new];
    floor.contents = @[content];
    floor.ratio = self.picRate;
    floor.contentType = TCHomeFloorContentTypeRecommend;
    floor.marginTop = LINE_H;
    [floor modelCustomTransformFromDictionary:nil];
    return floor;
}
@end
