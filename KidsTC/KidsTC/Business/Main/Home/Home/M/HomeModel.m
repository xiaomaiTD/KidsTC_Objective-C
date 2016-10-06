//
//  HomeModel.m
//  KidsTC
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeModel.h"
#import "YYKit.h"
#import "UILabel+Additions.h"
#import "NSString+Category.h"


@implementation TextSegueModel

- (instancetype)initWithLinkParam:(NSDictionary *)param promotionWords:(NSString *)words {
    if (!param || ![param isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    if (![words isKindOfClass:[NSString class]] || [words length] == 0) {
        return nil;
    }
    self = [super init];
    if (self) {
        _linkColor = [NSString colorWithString:[param objectForKey:@"color"]];
        if (!_linkColor) {
            _linkColor = [UIColor blueColor];
        }
        _promotionWords = words;
        _linkWords = [param objectForKey:@"linkKey"];
        _linkRangeStrings = [NSString rangeStringsOfSubString:self.linkWords inString:self.promotionWords];
        SegueDestination destination = (SegueDestination)[[param objectForKey:@"linkType"] integerValue];
        if (destination != SegueDestinationNone) {
            _segueModel = [SegueModel modelWithDestination:destination paramRawData:[param objectForKey:@"params"]];
        }
    }
    return self;
}

@end


@implementation HomeNewRecItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    if(_picRate.floatValue <= 0 ) _picRate = @"0.6";
    NSDictionary *parma = @{@"pid":@(_serveId),@"cid":@(_channelId)};
    _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:parma];
    return YES;
}

@end

@implementation HomeRecommendModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [HomeNewRecItem class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end

@implementation HomeItemArticleParamItem

@end

@implementation HomeItemParamItem

@end

@implementation HomeItemTitleItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _titleSegue = [SegueModel modelWithDestination:(SegueDestination)_linkType.integerValue paramRawData:_params];
    return YES;
}
@end

@implementation HomeItemContentItem


- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _contentSegue = [SegueModel modelWithDestination:(SegueDestination)_linkType paramRawData:_params];
    return YES;
}
@end


@implementation HomeFloorsItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"contents" : [HomeItemContentItem class]};
}


- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_hasTitle) {
        _titleHeight = 44;
    }else
        _titleHeight = 0;
    
    switch (_contentType) {
        case HomeContentCellTypeBanner://1
        case HomeContentCellTypeWholeImageNews://11
        {
            _rowHeight = SCREEN_WIDTH * _ratio.floatValue;
        }
            break;
        case HomeContentCellTypeBigImageTwoDesc://13
        {
            _rowHeight = SCREEN_WIDTH * _ratio.floatValue + 10;
        }
            break;
        case HomeContentCellTypeTwinklingElf:
        {
            NSUInteger count = [_contents count];
            CGFloat elfHeight = SCREEN_WIDTH / 4 + 15;
            if (count > 0) {
                NSUInteger left = count % 4;
                if (left > 0) {
                    _rowHeight = elfHeight * ((count / 4) + 1);
                } else {
                    _rowHeight = elfHeight * count / 4;
                }
            }
        }
            break;
        case HomeContentCellTypeHorizontalList:{
            _rowHeight = 120;
        }
            break;
        case HomeContentCellTypeThree:
        {
            CGFloat width = (SCREEN_WIDTH - 30) / 2;
            _rowHeight = _ratio.floatValue * width + 10;
        }
            break;
        case HomeContentCellTypeTwoColumn:// 2X图
        {
            NSUInteger count = [_contents count];
            if (count > 0) {
                NSUInteger row = count / 2;
                NSUInteger left = count % 2;
                if (left > 0) {
                    row ++;
                }
                CGFloat hMargin = 10;
                CGFloat vMargin = 5;
                
                CGFloat width = (SCREEN_WIDTH - _centerSeparation - hMargin * 2) * 0.5;
                CGFloat singleHeight = _ratio.floatValue * width;
                _rowHeight = singleHeight * row + vMargin * 2 + (row - 1) * self.bottomSeparation;
            }
        }
            break;
        case HomeContentCellTypeNews:{
            _rowHeight = 70;
        }
            break;
        case HomeContentCellTypeImageNews:{
            _rowHeight = 110;
        }
            break;
        case HomeContentCellTypeThreeImageNews:
        {
            CGFloat width = (SCREEN_WIDTH - 30) / 3;
            _rowHeight = _ratio.floatValue * width + 50;
        }
            break;
        case HomeContentCellTypeNotice:{
            _rowHeight = 50;
        }
            break;
        case HomeContentCellTypeTwoThreeFour:{
            NSUInteger count = [_contents count];
            CGFloat hMargin = 10;
            CGFloat hGap = 5;
            CGFloat vMargin = 5;
            CGFloat cellWidth = (SCREEN_WIDTH - 2 * hMargin - (count - 1) * hGap) / count;
            _rowHeight = _ratio.floatValue * cellWidth  + 2 * vMargin;
        }
            break;
        default:
            _rowHeight = 0.01;
            break;
    }
        return YES;
}
@end

@implementation HomeDataItem

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"floors" : [HomeFloorsItem class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    for (NSInteger i = 0; i < _floors.count; i++) {
        HomeFloorsItem * floorsItem = _floors[i];
        floorsItem.floorIndex = i;
    }
    return YES;

}
@end

@implementation HomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [HomeDataItem class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableArray *naviDataArr = [NSMutableArray array];
    NSMutableArray *allFloors = [NSMutableArray array];
    for (NSInteger i = 0; i < _data.count; i++) {
        HomeDataItem * dataItem = _data[i];
        dataItem.dataIndex = i;
        
        [allFloors addObjectsFromArray:dataItem.floors];
        if (dataItem.floorType) {//需要导航 建立导航数组
            [naviDataArr addObject:dataItem];
        }
    }
    _naviDatas = naviDataArr.copy;
    _allFloors = allFloors.copy;
    return YES;
}

-(NSString *)description{
    
    NSArray *keys = @[@"errNo", @"data", @"md5"];
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end
