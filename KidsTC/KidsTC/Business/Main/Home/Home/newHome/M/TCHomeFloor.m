//
//  TCHomeFloor.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloor.h"

#import "TCHomeCollectionViewBannerLayout.h"
#import "TCHomeCollectionViewTwinklingElfLayout.h"
#import "TCHomeCollectionViewHorizontalListLayout.h"
#import "TCHomeCollectionViewTwoColumnLayout.h"

@implementation TCHomeFloor
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"contents":[TCHomeFloorContent class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _floorHeight = 100;
    _marginTop = _marginTop>0?_marginTop:0.001;
    _ratio = _ratio>0?_ratio:0.6;
    
    switch (_contentType) {
            
        case TCHomeFloorContentTypeBanner://= 1,//banner
        {
            _floorHeight = _ratio * SCREEN_WIDTH;
            _collectionViewLayout = [TCHomeCollectionViewBannerLayout new];
        }
            break;
        case TCHomeFloorContentTypeTwinklingElf://= 2,//多个图标
        {
            int groupNum = ((int)_contents.count +4-1) / 4 ;//按4个一组来分，有几组
            int size = (int)(SCREEN_WIDTH/4);
            _floorHeight = size * groupNum;
            _collectionViewLayout = [TCHomeCollectionViewTwinklingElfLayout new];
        }
            break;
        case TCHomeFloorContentTypeHorizontalList://= 3,//水平多张图片
        {
            _floorHeight = (int)(SCREEN_WIDTH/3.5);
            _collectionViewLayout = [TCHomeCollectionViewHorizontalListLayout new];
        }
            break;
        case TCHomeFloorContentTypeThree://= 4,//三张图片
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeTwoColumn://= 5,//两列
        {
            _centerSeparation = _centerSeparation>0?_centerSeparation:0;
            _bottomSeparation = _bottomSeparation>0?_bottomSeparation:0;
            int groupNum = ((int)_contents.count +2-1) / 2 ;//按2个一组来分，有几组
            int size = (int)((SCREEN_WIDTH - _centerSeparation)*0.5);
            _floorHeight = (size + _bottomSeparation) * groupNum - _bottomSeparation;
            
            TCHomeCollectionViewTwoColumnLayout *layout = [TCHomeCollectionViewTwoColumnLayout new];
            layout.centerSeparation = _centerSeparation;
            layout.bottomSeparation = _bottomSeparation;
            _collectionViewLayout = layout;
        }
            break;
        case TCHomeFloorContentTypeNews://= 6,//不带图片的资讯
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeImageNews://= 7,//带一张图片的资讯
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeThreeImageNews://= 8,//带三张图片的资讯
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeWholeImageNews://= 11,//带一张大图的资讯
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeNotice://= 12,//童成热点，上下无限滚动
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeBigImageTwoDesc://= 13,//一张大图，下面带左右描述
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        case TCHomeFloorContentTypeTwoThreeFour://= 14,//1~4张图片
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
        default:
        {
            _collectionViewLayout = [UICollectionViewFlowLayout new];
        }
            break;
    } 
    
    return YES;
}
@end
