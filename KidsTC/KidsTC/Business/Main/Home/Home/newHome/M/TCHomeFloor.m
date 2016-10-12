//
//  TCHomeFloor.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloor.h"

#import "TCHomeCollectionViewBaseLayout.h"
#import "TCHomeCollectionViewBannerLayout.h"
#import "TCHomeCollectionViewTwinklingElfLayout.h"
#import "TCHomeCollectionViewHorizontalListLayout.h"
#import "TCHomeCollectionViewThreeLayout.h"
#import "TCHomeCollectionViewTwoColumnLayout.h"
#import "TCHomeCollectionViewOneToFourLayout.h"

@implementation TCHomeFloor
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"contents":[TCHomeFloorContent class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _floorHeight = 100;
    _marginTop = _marginTop>0?_marginTop:0.001;
    _ratio = _ratio>0?_ratio:0.6;
    int count = (int)_contents.count;
    
    TCHomeCollectionViewBaseLayout *layout;
    switch (_contentType) {
            
        case TCHomeFloorContentTypeBanner://= 1,//banner
        {
            layout = [TCHomeCollectionViewBannerLayout layoutWithCount:count
                                                           columnCount:count
                                                      layoutAttributes:TCHomeLayoutAttributesMake(8, 8, 8, 8, 0, 0)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat item_w = SCREEN_WIDTH - att.left - att.right;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = item_h + att.top + att.bottom;
        }
            break;
        case TCHomeFloorContentTypeTwinklingElf://= 2,//多个图标
        {
            layout = [TCHomeCollectionViewTwinklingElfLayout layoutWithCount:count
                                                                 columnCount:4
                                                            layoutAttributes:TCHomeLayoutAttributesMake(8, 8, 8, 8, 8, 8)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat columnCount = layout.columnCount;//列数
            int rowCount = (count + columnCount - 1) / columnCount; //按columnCount个一组来分，有几组,行数
            CGFloat item_w = (SCREEN_WIDTH - att.left - att.right - att.horizontal * (columnCount - 1)) / columnCount;
            item_w = item_w>0?item_w:0;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = att.top + att.bottom + (item_h + att.vertical) * rowCount - att.vertical;//collectionView的高度
        }
            break;
        case TCHomeFloorContentTypeHorizontalList://= 3,//水平多张图片
        {
            layout = [TCHomeCollectionViewHorizontalListLayout layoutWithCount:count
                                                                   columnCount:3.5
                                                              layoutAttributes:TCHomeLayoutAttributesMake(8, 8, 8, 8, 8, 8)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat columnCount = layout.columnCount;
            int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
            CGFloat item_w = (SCREEN_WIDTH - att.left - att.right - att.horizontal * marginCountH) / columnCount;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = item_h + att.top + att.bottom;
        }
            break;
        case TCHomeFloorContentTypeThree://= 4,//三张图片
        {
            layout = [TCHomeCollectionViewThreeLayout layoutWithCount:count
                                                          columnCount:2
                                                     layoutAttributes:TCHomeLayoutAttributesMake(8, 8, 8, 8, 8, 8)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat columnCount = layout.columnCount;
            CGFloat item_w = (SCREEN_WIDTH - att.left - att.right - att.horizontal * (columnCount - 1)) / columnCount;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = item_h + att.top + att.bottom;
        }
            break;
        case TCHomeFloorContentTypeTwoColumn://= 5,//两列
        {
            _centerSeparation = _centerSeparation>0?_centerSeparation:0;
            _bottomSeparation = _bottomSeparation>0?_bottomSeparation:0;
            
            layout = [TCHomeCollectionViewTwoColumnLayout layoutWithCount:count
                                                              columnCount:2
                                                         layoutAttributes:TCHomeLayoutAttributesMake(8, 8, 8, 8, _centerSeparation, _bottomSeparation)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat columnCount = layout.columnCount;
            
            int rowCount = (count + columnCount -1) / columnCount ;//按columnCount个一组来分，有几组
            CGFloat item_w = (SCREEN_WIDTH - att.left - att.right - att.horizontal * (columnCount - 1)) / columnCount;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = att.top + att.bottom + (item_h + att.vertical) * rowCount - att.vertical;
        }
            break;
        case TCHomeFloorContentTypeNews://= 6,//不带图片的资讯
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeImageNews://= 7,//带一张图片的资讯
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeThreeImageNews://= 8,//带三张图片的资讯
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeWholeImageNews://= 11,//带一张大图的资讯
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeNotice://= 12,//童成热点，上下无限滚动
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeBigImageTwoDesc://= 13,//一张大图，下面带左右描述
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
        case TCHomeFloorContentTypeOneToFour://= 14,//1~4张图片
        {
            layout = [TCHomeCollectionViewOneToFourLayout layoutWithCount:count
                                                              columnCount:count
                                                         layoutAttributes:TCHomeLayoutAttributesMake(12, 12, 12, 12, 12, 12)];
            TCHomeLayoutAttributes att = layout.layoutAttributes;
            CGFloat columnCount = layout.columnCount;
            CGFloat item_w = (SCREEN_WIDTH - att.left - att.right - att.horizontal * (columnCount - 1))/columnCount;
            item_w = item_w>0?item_w:0;
            CGFloat item_h = item_w * _ratio;
            _floorHeight = item_h + att.top + att.bottom;
        }
            break;
        default:
        {
            layout = [TCHomeCollectionViewBaseLayout new];
        }
            break;
    }
    
    _collectionViewLayout = layout;
    
    return YES;
}
@end
