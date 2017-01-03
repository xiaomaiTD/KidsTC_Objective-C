//
//  TCHomeFloor.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloor.h"
#import "Colours.h"
#import "TCHomeCollectionViewBaseLayout.h"
#import "NSString+Category.h"

int const kTCHomeCollectionViewCellMaxSections = 3;

@implementation TCHomeFloor

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"contents":[TCHomeFloorContent class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self insetType];
    
    [self setupLayout];
    
    return YES;
}

- (void)insetType {
    
    _titleContent.type = _titleType;
    [_titleContent setupAttributes];
    
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent *obj, NSUInteger idx, BOOL *stop) {
        obj.type = _contentType;
        [obj setupAttTitle];
    }];
}

#pragma mark - setupLayout

- (void)setupLayout{
    _floorHeight = 100;
    _marginTop = _marginTop>0?_marginTop:0.001;
    _ratio = _ratio>0?_ratio:0.6;
    _showTitleContainer = _hasTitle && _titleContent;
    _showBgImageView = _contentType == TCHomeFloorContentTypeTwinklingElf;
    _showPageControl = _contentType == TCHomeFloorContentTypeBanner && _contents.count>0;
    _canAddYYTimer = (_contentType == TCHomeFloorContentTypeBanner ||
                      _contentType == TCHomeFloorContentTypeNotice) && (_contents.count>1);
    _showNotiImageView = _contentType == TCHomeFloorContentTypeNotice;
    
    TCHomeCollectionViewBaseLayout *layout = [TCHomeCollectionViewBaseLayout new];
    layout.autoScroll = _canAddYYTimer;
    
    switch (_contentType) {
            
            case TCHomeFloorContentTypeBanner://= 1,//banner
        {
            [self setupBannerLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeTwinklingElf://= 2,//多个图标
        {
            [self setupTwinklingElfLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeHorizontalList://= 3,//水平多张图片
        {
            [self setupHorizontalListLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeThree://= 4,//三张图片
        {
            [self setupThreeLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeTwoColumn://= 5,//两列
        {
            [self setupTwoColumnLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeNews://= 6,//不带图片的资讯
        {
            [self setupNewsLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeImageNews://= 7,//带一张图片的资讯
        {
            [self setupImageNewsLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeThreeImageNews://= 8,//带三张图片的资讯
        {
            [self setupThreeImageNewsLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeWholeImageNews://= 11,//带一张大图的资讯
        {
            [self setupWholeImageNewsLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeNotice://= 12,//童成热点，上下无限滚动
        {
            [self setupNoticeLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeBigImageTwoDesc://= 13,//一张大图，下面带左右描述
        {
            [self setupBigImageTwoDescLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeOneToFour://= 14,//1~4张图片
        {
            [self setupOneToFourLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeRecommend://= 15,//为你推荐
        {
            [self setupRecommendLayout:layout];
        }
            break;
            case TCHomeFloorContentTypeFive://= 16,//五张图片
        {
            [self setupFiveLayout:layout];
        }
            break;
    }
    _collectionViewFrame = CGRectMake(0, _showTitleContainer?kTCHomeFloorTitleContentH:0, SCREEN_WIDTH, _floorHeight);
    _floorHeight += _showTitleContainer?kTCHomeFloorTitleContentH:0;
    _collectionViewLayout = layout;
}

#pragma mark //= 1,//banner

- (void)setupBannerLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(margins.top, margins.left, margins.bottom, margins.right);
    layout.minimumLineSpacing = margins.vertical;
    layout.minimumInteritemSpacing = margins.horizontal;
    
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat item_h = img_y + img_h;
    layout.itemSize = CGSizeMake(item_w, item_h);
    
    _floorHeight = item_h + margins.top + margins.bottom;
    
    CGFloat item_y = margins.top;
    __block CGFloat item_x;
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, NO, NO, NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + idx * SCREEN_WIDTH;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}


#pragma mark //= 2,//多个图标

- (void)setupTwinklingElfLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    int count = (int)_contents.count;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 20, 8, 20, 34, 8);
    int columnCount = 4;//列数
    int rowCount = (count + columnCount - 1) / columnCount; //按columnCount个一组来分，有几组,行数
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1)) / columnCount;
    item_w = item_w>0?item_w:0;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat title_h = 20, title_w = item_w + margins.horizontal, title_x = (item_w - title_w) * 0.5, title_y = img_h + img_y + 4;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, NO, YES,NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, CGRectZero, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = title_y + title_h;
    _floorHeight = margins.top + margins.bottom + (item_h + margins.vertical) * rowCount - margins.vertical;//collectionView的高度
    
    __block CGFloat item_x, item_y;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + (item_w + margins.horizontal) * (idx % columnCount);
        item_y = margins.top + (item_h + margins.vertical) * (idx / columnCount);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 3,//水平多张图片

- (void)setupHorizontalListLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(margins.top, margins.left, margins.bottom, margins.right);
    layout.minimumLineSpacing = margins.vertical;
    layout.minimumInteritemSpacing = margins.horizontal;
    
    CGFloat columnCount = 3.5;
    int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * marginCountH) / columnCount;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat price_h = 20, price_w = item_w, price_x = 0, price_y = img_h + img_y + 4;
    CGRect priceFrame = CGRectMake(price_x, price_y, price_w, price_h);
    
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, YES, NO, NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, priceFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = _contents.count>0?CGRectGetMaxY(priceFrame):0;
    
    layout.itemSize = CGSizeMake(item_w, item_h);
    
    _floorHeight = item_h>0?(item_h + margins.top + margins.bottom):0;
    
    CGFloat item_y = margins.top;
    __block CGFloat item_x;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + (item_w + margins.horizontal) * idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 4,//三张图片

- (void)setupThreeLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 8, 8);
    int columnCount = 2;
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1)) / columnCount;
    
    CGFloat first_item_h = item_w * _ratio;
    _floorHeight = first_item_h + margins.top + margins.bottom;
    
    CGFloat other_item_h = (first_item_h - margins.vertical)/2;
    __block CGFloat item_x, item_y,item_h;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            item_x = margins.left;
            item_y = margins.top;
            item_h = first_item_h;
        }else if (idx == 1) {
            item_x = margins.left + (item_w + margins.horizontal);
            item_y = margins.top;
            item_h = other_item_h;
        }else{
            item_x = margins.left + (item_w + margins.horizontal);
            item_y = margins.top + other_item_h + margins.vertical;
            item_h = other_item_h;
        }
        
        CGRect imgFrame = CGRectMake(0, 0, item_w, item_h);
        
        TCHomeContentLayoutAttributes contentAtt =
        TCHomeContentLayoutAttributesMake(YES, NO, NO, NO,NO, NO, NO, NO, NO, NO,
                                          imgFrame,CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
        obj.layoutAttributes = contentAtt;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 5,//两列

- (void)setupTwoColumnLayout:(TCHomeCollectionViewBaseLayout *)layout {
    int count = (int)_contents.count;
    
    _centerSeparation = _centerSeparation>0?_centerSeparation:0;
    _bottomSeparation = _bottomSeparation>0?_bottomSeparation:0;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 8, 0, 8, _centerSeparation, _bottomSeparation);
    int columnCount = 2;
    
    int rowCount = (count + columnCount -1) / columnCount ;//按columnCount个一组来分，有几组
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1)) / columnCount;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, NO, NO, NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, CGRectZero, CGRectZero,CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = img_y + img_h;
    _floorHeight = margins.top + margins.bottom + (item_h + margins.vertical) * rowCount - margins.vertical;
    
    __block CGFloat item_x, item_y;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + (item_w + margins.horizontal) * (idx % columnCount);
        item_y = margins.top + (item_h + margins.vertical) * (idx / columnCount);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 6,//不带图片的资讯

- (void)setupNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    CGFloat item_x = margins.left;
    
    CGFloat margin = 8;
    
    __block CGFloat item_y = margins.top;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat title_x = margin;
        CGFloat title_y = margin;
        CGFloat title_w = item_w - margin * 2;
        CGFloat title_h = [obj.attTitle boundingRectWithSize:CGSizeMake(item_w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        CGRect title_frame = CGRectMake(title_x, title_y, title_w, title_h);
        
        CGFloat subTitle_x = margin;
        CGFloat subTitle_h = 20;
        CGFloat subTitle_w = title_w;
        CGFloat subTitle_y = CGRectGetMaxY(title_frame) + margin;
        CGRect subTitle_frame = CGRectMake(subTitle_x, subTitle_y, subTitle_w, subTitle_h);
        
        CGFloat line_x = margin;
        CGFloat line_h = LINE_H;
        CGFloat line_y = CGRectGetMaxY(subTitle_frame) + margin - line_h;
        CGFloat line_w = item_w - 2 * margin;
        CGRect lineFrame = CGRectMake(line_x, line_y, line_w, line_h);
        
        obj.layoutAttributes = TCHomeContentLayoutAttributesMake(NO, NO, NO, YES, NO, NO, YES, NO, NO, YES,
                                                                 CGRectZero, CGRectZero, CGRectZero, title_frame, CGRectZero, CGRectZero, subTitle_frame, CGRectZero, CGRectZero, lineFrame);
        CGFloat item_h = CGRectGetMaxY(subTitle_frame) + margin;
        CGRect item_frame = CGRectMake(item_x, item_y, item_w, item_h);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = item_frame;
        [attributes addObject:att];
        
        item_y += item_h + margins.vertical;
    }];
    _floorHeight = item_y - margins.vertical + margins.bottom;
    layout.attributes = attributes;
}

#pragma mark //= 7,//带一张图片的资讯

- (void)setupImageNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    int count = (int)_contents.count;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    
    CGFloat margin = 8;
    
    CGFloat img_w = 80;
    CGFloat img_h = img_w * _ratio;
    CGFloat img_y = margin;
    CGFloat img_x = item_w - img_w - margin;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat subTitle_x = margin;
    CGFloat subTitle_h = 20;
    CGFloat subTitle_y = CGRectGetMaxY(imgFrame) - subTitle_h;
    CGFloat subTitle_w = item_w - subTitle_x - img_w - margin * 2;
    CGRect subTitleFrame = CGRectMake(subTitle_x, subTitle_y, subTitle_w, subTitle_h);
    
    CGFloat title_x = margin;
    CGFloat title_y = margin;
    CGFloat title_w = subTitle_w;
    CGFloat titleMax_h = img_h - subTitle_h - margin;
    
    CGFloat line_x = margin;
    CGFloat line_h = LINE_H;
    CGFloat line_y = CGRectGetMaxY(subTitleFrame) + margin - line_h;
    CGFloat line_w = item_w - 2 * margin;
    CGRect lineFrame = CGRectMake(line_x, line_y, line_w, line_h);
    
    CGFloat item_h = CGRectGetMaxY(imgFrame) + margin;
    
    CGFloat item_x = margins.left;
    __block CGFloat item_y;
    __block CGFloat title_h;
    _floorHeight = margins.top + margins.bottom + (item_h + margins.vertical) * count - margins.vertical;
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        title_h = [obj.attTitle boundingRectWithSize:CGSizeMake(title_w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        title_h = title_h>titleMax_h?titleMax_h:title_h;
        CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
        
        obj.layoutAttributes = TCHomeContentLayoutAttributesMake(YES, NO, NO, YES,NO, NO, YES, NO, NO, YES,
                                                                 imgFrame, CGRectZero,CGRectZero, titleFrame, CGRectZero, CGRectZero, subTitleFrame, CGRectZero, CGRectZero, lineFrame);
        
        item_y = margins.top + (item_h + margins.vertical) * idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 8,//带三张图片的资讯

- (void)setupThreeImageNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    int count = (int)_contents.count;
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 8, 0, 8, 8, 0);
    int columnCount = count;
    int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * marginCountH) / columnCount;
    
    CGFloat margin = 8;
    
    CGFloat title_x = 0;
    CGFloat title_y = margin;
    CGFloat title_w = SCREEN_WIDTH - 2 * margin;
    CGFloat title_h = 21;
    CGRect title_f = CGRectMake(title_x, title_y, title_w, title_h);
    
    CGFloat img_x = 0;
    CGFloat img_w = item_w;
    CGFloat img_h = img_w * _ratio;
    CGFloat img_y = CGRectGetMaxY(title_f) + margin;
    CGRect img_f = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat subTitle_x = 0;
    CGFloat subTitle_y = CGRectGetMaxY(img_f) + margin;
    CGFloat subTitle_w = SCREEN_WIDTH - 2 * margin;
    CGFloat subTitle_h = 21;
    CGRect subTitle_f = CGRectMake(subTitle_x, subTitle_y, subTitle_w, subTitle_h);
    
    CGFloat item_h = CGRectGetMaxY(subTitle_f) + margin;
    _floorHeight = item_h + margins.top + margins.bottom;
    CGFloat item_y = margins.top;
    __block CGFloat item_x;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent *obj, NSUInteger idx, BOOL *stop) {
        TCHomeContentLayoutAttributes contentAtt;
        if (idx == 0) {
            contentAtt = TCHomeContentLayoutAttributesMake(YES, NO, NO, YES, NO, NO, YES, NO, NO, NO, img_f, CGRectZero, CGRectZero, title_f, CGRectZero, CGRectZero, subTitle_f, CGRectZero, CGRectZero, CGRectZero);
        }else{
            contentAtt = TCHomeContentLayoutAttributesMake(YES, NO, NO, NO,NO, NO, NO, NO, NO, NO, img_f, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
        }
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + (item_w + margins.horizontal) * idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 11,//带一张大图的资讯

- (void)setupWholeImageNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right);
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat title_x = 0,title_h = 40, title_y = img_h - title_h, title_w = item_w;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, NO, YES, NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, CGRectZero, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = img_y + img_h;
    _floorHeight = item_h + margins.top + margins.bottom;
    CGFloat item_y = margins.top;
    CGFloat item_x = margins.left;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];

    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 12,//童成热点，上下无限滚动

- (void)setupNoticeLayout:(TCHomeCollectionViewBaseLayout *)layout {
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(margins.top, margins.left, margins.bottom, margins.right);
    layout.minimumLineSpacing = margins.horizontal;
    layout.minimumInteritemSpacing = margins.vertical;
    
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right);
    CGFloat item_h = 50;
    layout.itemSize = CGSizeMake(item_w, item_h);
    
    CGFloat margin = 8;
    
    CGFloat title_x = item_w * 0.2 + margin,title_h = 21, title_y = (item_h - title_h) * 0.5, title_w = item_w - title_x - margin;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(NO, NO, NO, YES, NO, NO, NO, NO, NO, NO,
                                      CGRectZero, CGRectZero, CGRectZero, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    _floorHeight = item_h;
    CGFloat item_x = margins.left;
    __block CGFloat item_y;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent *obj, NSUInteger idx, BOOL *stop) {
        if (idx==0) {
            _notiImgUrl = obj.imageUrl;
        }
        obj.layoutAttributes = contentAtt;
        item_y = idx * item_h;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 13,//一张大图，下面带左右描述

- (void)setupBigImageTwoDescLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right);
    
    CGFloat margin = 8;
    __block CGFloat last_item_y = _contents.count>0?margins.top:0;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat img_w = item_w;
        CGFloat img_h = img_w * _ratio;
        CGFloat img_y = 0;
        CGFloat img_x = 0;
        CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
        
        CGSize title_s = [obj.attTitle size];
        CGFloat title_x = margin;
        CGFloat title_y = CGRectGetMaxY(imgFrame) + margin;
        CGFloat title_w = title_s.width;
        CGFloat title_h = title_s.height;
        CGRect title_f = CGRectMake(title_x, title_y, title_w, title_h);
        
        CGSize subTitle_s = [obj.attSubTitle size];
        CGFloat subTitle_w = subTitle_s.width;
        CGFloat subTitle_h = subTitle_s.height;
        CGFloat subTitle_y = CGRectGetMaxY(imgFrame) + margin;
        CGFloat subTitle_x = item_w - margin - subTitle_w;
        CGRect subTitle_f = CGRectMake(subTitle_x, subTitle_y, subTitle_w, subTitle_h);
        
        CGFloat line_x = margin;
        CGFloat line_h = LINE_H;
        CGFloat line_y = CGRectGetMaxY(title_f) + margin - line_h;
        CGFloat line_w = item_w - 2 * margin;
        CGRect lineFrame = CGRectMake(line_x, line_y, line_w, line_h);
        
        obj.layoutAttributes =
        TCHomeContentLayoutAttributesMake(YES, NO, NO, YES, NO, NO, YES, NO, NO, YES,
                                          imgFrame, CGRectZero, CGRectZero, title_f, CGRectZero, CGRectZero, subTitle_f, CGRectZero, CGRectZero, lineFrame);
        
        CGFloat item_x = margins.left;
        CGFloat item_y = last_item_y;
        CGFloat item_h = CGRectGetMaxY(lineFrame);
        last_item_y = item_h + item_y + margins.vertical;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    
    _floorHeight = last_item_y>0?(last_item_y + margins.bottom - margins.vertical):0;
    
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 14,//1~4张图片

- (void)setupOneToFourLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    int count = (int)_contents.count;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 0);
    int columnCount = count;
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1))/columnCount;
    item_w = item_w>0?item_w:0;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    TCHomeContentLayoutAttributes contentAtt =
    TCHomeContentLayoutAttributesMake(YES, NO, NO, NO, NO, NO, NO, NO, NO, NO,
                                      imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = item_w * _ratio;
    _floorHeight = item_h + margins.top + margins.bottom;
    CGFloat item_y = margins.top;
    __block CGFloat item_x;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
        item_x = margins.left + (item_w + margins.horizontal) * idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //= 15,//为您推荐

- (void)setupRecommendLayout:(TCHomeCollectionViewBaseLayout *)layout {
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    
    CGFloat margin = 15 + 10;
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent *obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat bgView_x = 10;
        CGFloat bgView_y = 10;
        CGFloat bgView_w = SCREEN_WIDTH - 20;
        
        CGFloat img_x = 10;
        CGFloat img_y = 10;
        CGFloat img_w = SCREEN_WIDTH-20;
        CGFloat img_h = img_w * _ratio;
        CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
        
        CGRect tipImgFrame = CGRectMake(margin, img_y - 3.6, 51, 41);
        
        CGFloat title_y = CGRectGetMaxY(imgFrame) + 16;
        CGFloat title_x = margin;
        CGFloat title_w = SCREEN_WIDTH - 2*margin;
        CGSize title_size = [obj.attTitle boundingRectWithSize:CGSizeMake(title_w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        CGFloat title_h = title_size.height;
        CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
        
        BOOL subImgShow = [obj.subImgName isNotNull];
        CGFloat subImg_x = margin;
        CGFloat subImg_y = CGRectGetMaxY(titleFrame) + 12;
        CGFloat subImg_w = 15;
        CGFloat subImg_h = 15;
        CGRect subImgFrame = CGRectMake(subImg_x, subImg_y, subImg_w, subImg_h);
        if (!subImgShow) {
            subImgFrame = CGRectZero;
        }
        
        CGFloat subTitle_y = CGRectGetMaxY(titleFrame) + 10;
        CGFloat subTitle_x = subImgShow?(CGRectGetMaxX(subImgFrame) + 2):margin;
        CGFloat subTitle_w = SCREEN_WIDTH-2*margin;
        CGFloat subTitle_h = 21;
        CGRect subTtitleFrme = CGRectMake(subTitle_x, subTitle_y, subTitle_w, subTitle_h);
        
        CGRect storeAddressFrme, statusFrame, saleNumFrame, priceFrame, discountFrame, btnDescFrame;
        if ([obj.attPrice.string isNotNull]) {
            
            CGSize storeAddress_s = [obj.attStoreAddress size];
            CGSize status_size = [obj.attStatus size];
            
            CGFloat storeAddress_w = storeAddress_s.width;
            CGFloat status_w = status_size.width;
            
            if (storeAddress_w + status_w > subTitle_w) {
                storeAddress_w = subTitle_w - status_w;
                if (storeAddress_w<subTitle_w*0.5) {
                    storeAddress_w = subTitle_w*0.5;
                }
            }
            status_w = subTitle_w - storeAddress_w;
            
            CGFloat storeAddress_x = margin;
            CGFloat storeAddress_y = obj.attSubTitle.length>0?(CGRectGetMaxY(subTtitleFrme) + 10):CGRectGetMaxY(titleFrame) + 10;
            CGFloat storeAddress_h = 21;
            storeAddressFrme = CGRectMake(storeAddress_x, storeAddress_y, storeAddress_w, storeAddress_h);
            
            CGFloat status_h = storeAddress_h;
            CGFloat status_x = CGRectGetMaxX(storeAddressFrme) + 8;
            CGFloat status_y = storeAddress_y;
            statusFrame = CGRectMake(status_x, status_y, status_w, status_h);
            
            CGSize saleNum_s = [obj.attSaleNum size];
            CGFloat saleNum_w = saleNum_s.width;
            CGFloat saleNum_h = saleNum_s.height;
            CGFloat saleNum_x = margin;
            CGFloat saleNum_y = CGRectGetMaxY(storeAddressFrme) + 12;
            saleNumFrame = CGRectMake(saleNum_x, saleNum_y, saleNum_w, saleNum_h);
            
            CGSize price_size = [obj.attPrice size];
            CGFloat price_w = price_size.width;
            CGFloat price_x = CGRectGetMaxX(saleNumFrame);
            CGFloat price_h = price_size.height;
            CGFloat price_y = CGRectGetMaxY(storeAddressFrme) + 10;
            priceFrame = CGRectMake(price_x, price_y, price_w, price_h);
            
            CGSize discount_size = [obj.attDiscountDesc size];
            CGFloat discount_w = discount_size.width + 8;
            CGFloat discount_x = CGRectGetMaxX(priceFrame) + 8;
            CGFloat discount_h = discount_size.height;
            CGFloat discount_y = price_y + (price_h - discount_h)*0.5;
            discountFrame = CGRectMake(discount_x, discount_y, discount_w, discount_h);
            
            CGSize btnDesc_size = [obj.attBtnDesc size];
            CGFloat btnDesc_w = btnDesc_size.width + 16;
            CGFloat btnDesc_x = SCREEN_WIDTH - margin - btnDesc_w;
            CGFloat btnDesc_h = 30;
            CGFloat btnDesc_y = price_y + (price_h - btnDesc_h)*0.5;
            btnDescFrame = CGRectMake(btnDesc_x, btnDesc_y, btnDesc_w, btnDesc_h);
            
        }else{
            
            CGSize storeAddress_s = [obj.attStoreAddress size];
            CGSize status_size = [obj.attStatus size];
            CGSize btnDesc_size = [obj.attBtnDesc size];
            
            
            CGFloat storeAddress_w = storeAddress_s.width;
            CGFloat status_w = status_size.width;
            CGFloat btnDesc_w = btnDesc_size.width + 16;
            
            if ((storeAddress_w + status_w + btnDesc_w + 24) > subTitle_w) {
                storeAddress_w = subTitle_w - (status_w + btnDesc_w + 24);
                if (storeAddress_w<subTitle_w*0.3) storeAddress_w = subTitle_w*0.3;
            }
            status_w = subTitle_w - (storeAddress_w + btnDesc_w + 24);
            if (status_w<0) status_w = 0;
            
            CGFloat storeAddress_x = margin;
            CGFloat storeAddress_y = obj.attSubTitle.length>0?(CGRectGetMaxY(subTtitleFrme) + 10):CGRectGetMaxY(titleFrame) + 10;
            CGFloat storeAddress_h = 21;
            storeAddressFrme = CGRectMake(storeAddress_x, storeAddress_y, storeAddress_w, storeAddress_h);
            
            CGFloat status_h = storeAddress_h;
            CGFloat status_x = CGRectGetMaxX(storeAddressFrme) + 8;
            CGFloat status_y = storeAddress_y;
            statusFrame = CGRectMake(status_x, status_y, status_w, status_h);
            
            CGSize saleNum_s = [obj.attSaleNum size];
            CGFloat saleNum_w = saleNum_s.width;
            CGFloat saleNum_h = saleNum_s.height;
            CGFloat saleNum_x = margin;
            CGFloat saleNum_y = CGRectGetMaxY(storeAddressFrme) + 12;
            saleNumFrame = CGRectMake(saleNum_x, saleNum_y, saleNum_w, saleNum_h);
            
            priceFrame = CGRectZero;
            
            discountFrame = CGRectZero;
            
            CGFloat btnDesc_x = SCREEN_WIDTH - margin - btnDesc_w;
            CGFloat btnDesc_h = 30;
            CGFloat btnDesc_y = status_y + (status_h - btnDesc_h)*0.5;
            btnDescFrame = CGRectMake(btnDesc_x, btnDesc_y, btnDesc_w, btnDesc_h);
        }
        
        CGFloat line_x = 0;
        CGFloat line_h = LINE_H;
        CGFloat line_y = CGRectGetMaxY(btnDescFrame) + 10 - line_h;
        CGFloat line_w = item_w - 2 * line_x;
        CGRect lineFrame = CGRectMake(line_x, line_y, line_w, line_h);
        
        CGFloat bgView_h = CGRectGetMaxY(lineFrame);
        CGRect bgViewFrame = CGRectMake(bgView_x, bgView_y, bgView_w, bgView_h);
        
        TCHomeContentLayoutAttributes layoutAttributes =
        TCHomeContentLayoutAttributesMake(YES, [obj.tipImgName isNotNull], YES, YES, subImgShow, YES, YES, YES, YES,NO,
                                          imgFrame, tipImgFrame, priceFrame, titleFrame, subImgFrame, saleNumFrame, subTtitleFrme, statusFrame, storeAddressFrme, lineFrame);
        layoutAttributes.showDiscount = obj.attDiscountDesc.length>0;
        layoutAttributes.discountFrame = discountFrame;
        layoutAttributes.showBtnDesc = obj.attBtnDesc.length>0;
        layoutAttributes.btnDescFrame = btnDescFrame;
        layoutAttributes.showBGView = YES;
        layoutAttributes.bgViewFrame = bgViewFrame;
        layoutAttributes.isProductRecommend = YES;
        
        obj.layoutAttributes = layoutAttributes;
        
        _floorHeight = CGRectGetMaxY(lineFrame);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(0, 0, item_w, _floorHeight);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}

#pragma mark //=16,//5张图片

- (void)setupFiveLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 8, 8);
    
    CGFloat left_w = (SCREEN_WIDTH - margins.left - margins.right - 2 * margins.horizontal);
    __block CGFloat item_x, item_y, item_w, item_h;
    __block CGFloat left_h;
    __block CGRect last_f;
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            item_x = margins.left;
            item_y = margins.top;
            item_w = left_w * obj.widthScale;
            item_h = item_w * _ratio;
            left_h = item_h - margins.vertical;
            _floorHeight = item_h + margins.top + margins.bottom;
        } else if (idx == 1) {
            item_x = CGRectGetMaxX(last_f) + margins.horizontal;
            item_y = margins.top;
            item_w = left_w * obj.widthScale;
            item_h = left_h * obj.heightScale;
        } else if (idx == 2) {
            item_x = CGRectGetMinX(last_f);
            item_y = CGRectGetMaxY(last_f) + margins.vertical;
            item_w = left_w * obj.widthScale;
            item_h = left_h * obj.heightScale;
        } else if (idx == 3) {
            item_x = CGRectGetMaxX(last_f) + margins.horizontal;
            item_y = margins.top;
            item_w = left_w * obj.widthScale;
            item_h = left_h * obj.heightScale;
        } else if (idx == 4) {
            item_x = CGRectGetMinX(last_f);
            item_y = CGRectGetMaxY(last_f) + margins.vertical;
            item_w = left_w * obj.widthScale;
            item_h = left_h * obj.heightScale;
        }
        last_f = CGRectMake(item_x, item_y, item_w, item_h);
        CGRect imgFrame = CGRectMake(0, 0, item_w, item_h);
        
        obj.layoutAttributes =
        TCHomeContentLayoutAttributesMake(YES, NO, NO, NO, NO, NO, NO, NO, NO, NO,
                                          imgFrame, CGRectZero, CGRectZero,CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = last_f;
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}


@end
