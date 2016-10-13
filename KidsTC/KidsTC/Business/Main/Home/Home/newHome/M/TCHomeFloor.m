//
//  TCHomeFloor.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloor.h"

#import "TCHomeCollectionViewBaseLayout.h"

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
    
    TCHomeCollectionViewBaseLayout *layout = [TCHomeCollectionViewBaseLayout new];
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
            case TCHomeFloorContentTypeFive:
        {
            [self setupFiveLayout:layout];
        }
            break;
    }
    _collectionViewLayout = layout;
}

#pragma mark //= 1,//banner

- (void)setupBannerLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat item_h = img_y + img_h;
    layout.itemSize = CGSizeMake(item_w, item_h);
    
    _floorHeight = item_h + margins.top + margins.bottom;
    
    CGFloat item_y = margins.top;
    __block CGFloat item_x;
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
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
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
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
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    CGFloat columnCount = 3.5;
    int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * marginCountH) / columnCount;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat title_h = 20, title_w = item_w, title_x = 0, title_y = img_h + img_y + 4;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = title_y + title_h;
    
    layout.itemSize = CGSizeMake(item_w, item_h);
    
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

#pragma mark //= 4,//三张图片

- (void)setupThreeLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
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
        TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
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
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, _centerSeparation, _bottomSeparation);
    int columnCount = 2;
    
    int rowCount = (count + columnCount -1) / columnCount ;//按columnCount个一组来分，有几组
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1)) / columnCount;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
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
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

#pragma mark //= 7,//带一张图片的资讯

- (void)setupImageNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    int count = (int)_contents.count;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    CGFloat item_w = SCREEN_WIDTH - margins.left - margins.right;
    
    CGFloat img_w = 80, img_h = img_w * _ratio, img_y = 0, img_x = item_w - img_w;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat article_x = 0, article_h = 20, article_y = img_h - article_h, article_w = item_w - img_w - 4;
    CGRect articleFrame = CGRectMake(article_x, article_y, article_w, article_h);
    
    CGFloat title_x = 0, title_y = 0, title_w = article_w, title_h = img_h - article_h;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, titleFrame, CGRectZero, articleFrame, CGRectZero, CGRectZero);
    
    CGFloat item_h = img_y + img_h;
    CGFloat item_x = margins.left;
    __block CGFloat item_y;
    _floorHeight = margins.top + margins.bottom + (item_h + margins.vertical) * count - margins.vertical;
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray array];
    [_contents enumerateObjectsUsingBlock:^(TCHomeFloorContent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layoutAttributes = contentAtt;
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
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    int columnCount = count;
    int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * marginCountH) / columnCount;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
    CGFloat item_h = img_y + img_h;
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

#pragma mark //= 11,//带一张大图的资讯

- (void)setupWholeImageNewsLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right);
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    CGFloat title_x = 0,title_h = 40, title_y = img_h - title_h, title_w = item_w;
    CGRect titleFrame = CGRectMake(title_x, title_y, title_w, title_h);
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, titleFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
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
    
}

#pragma mark //= 13,//一张大图，下面带左右描述

- (void)setupBigImageTwoDescLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right);
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
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

#pragma mark //= 14,//1~4张图片

- (void)setupOneToFourLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    int count = (int)_contents.count;
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(8, 8, 8, 8, 8, 8);
    int columnCount = count;
    CGFloat item_w = (SCREEN_WIDTH - margins.left - margins.right - margins.horizontal * (columnCount - 1))/columnCount;
    item_w = item_w>0?item_w:0;
    
    CGFloat img_w = item_w, img_h = img_w * _ratio, img_y = 0, img_x = 0;
    CGRect imgFrame = CGRectMake(img_x, img_y, img_w, img_h);
    
    TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
    
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

#pragma mark //=16,//5张图片

- (void)setupFiveLayout:(TCHomeCollectionViewBaseLayout *)layout {
    
    TCHomeLayoutMargins margins = TCHomeLayoutMarginsMake(0, 0, 0, 0, 0, 0);
    int columnCount = 3;
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
        } else {
            item_h = other_item_h;
            if (idx == 1 || idx == 2) {
                item_x = margins.left + (item_w + margins.horizontal) * (idx % columnCount);
                item_y = margins.top + (other_item_h + margins.vertical) * (idx / columnCount);
            }else{
                item_x = margins.left + (item_w + margins.horizontal) * ((idx + 1) % columnCount);
                item_y = margins.top + (other_item_h + margins.vertical) * ((idx + 1) / columnCount);
            }
        }
        CGRect imgFrame = CGRectMake(0, 0, item_w, item_h);
        TCHomeContentLayoutAttributes contentAtt = TCHomeContentLayoutAttributesMake(imgFrame, CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero);
        obj.layoutAttributes = contentAtt;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        att.frame = CGRectMake(item_x, item_y, item_w, item_h);
        [attributes addObject:att];
    }];
    layout.attributes = [NSArray arrayWithArray:attributes];
}


@end
