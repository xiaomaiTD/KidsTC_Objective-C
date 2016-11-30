//
//  ArticleHomeModel.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeModel.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "NSObject+YYModel.h"
#import "Colours.h"

@implementation ArticleHomeBanner
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _ratio = _ratio>0?_ratio:0.4;
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end

@implementation ArticleHomeColumnTag
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:SegueDestinationColumnDetail paramRawData:@{@"cid":_ID}];
    return YES;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _width = [_title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width + 4;
}
@end

@implementation ArticleHomeColumnTitle
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"tags":[ArticleHomeColumnTag class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableArray *tags = [NSMutableArray array];
    [tags addObjectsFromArray:_tags];
    ArticleHomeColumnTag *tag = [[ArticleHomeColumnTag alloc]init];
    tag.title = @"更多";
    tag.segueModel = [SegueModel modelWithDestination:SegueDestinationColumnList];
    [tags addObject:tag];
    _tags = [NSArray arrayWithArray:tags];
    return YES;
}
@end


@implementation ArticleHomeAlbumEntry
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end

@implementation ArticleHomeProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *pid = [_pid isNotNull]?_pid:@"";
    NSString *cid = [_cid isNotNull]?_cid:@"";
    _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:@{@"pid":pid,@"cid":cid}];
    return YES;
}
@end

@implementation ArticleHomeTag
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end

@implementation ArticleHomeItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banners":[ArticleHomeBanner class],
             @"imgPicUrls":[NSString class],
             @"products":[ArticleHomeProduct class],
             @"tags":[ArticleHomeTag class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    NSMutableAttributedString *titleAttributeStr = [[NSMutableAttributedString alloc] initWithString:[_title isNotNull]?_title:@""];
    titleAttributeStr.lineSpacing = 8;
    titleAttributeStr.color = [UIColor darkGrayColor];
    titleAttributeStr.font = [UIFont systemFontOfSize:17];
    titleAttributeStr.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleAttributeStr = titleAttributeStr;
    NSMutableAttributedString *brifContentAttributeStr = [[NSMutableAttributedString alloc] initWithString:[_brifContent isNotNull]?_brifContent:@""];
    brifContentAttributeStr.color = [UIColor lightGrayColor];
    brifContentAttributeStr.font = [UIFont systemFontOfSize:15];
    brifContentAttributeStr.lineSpacing = 8;
    brifContentAttributeStr.lineBreakMode = NSLineBreakByTruncatingTail;
    _brifContentAttributeStr = brifContentAttributeStr;
    if (_ratio<=0) {
        if (_banners.count>0) {
            _ratio = _banners.firstObject.ratio;
        }
    }
    if (_ratio<=0) {
        _ratio = 0.4;
    }
    return YES;
}
@end

@implementation ArticleHomeHeader
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banners":[ArticleHomeBanner class],
             @"columnEntrys":[ArticleHomeAlbumEntry class],
             @"albumEntrys":[ArticleHomeAlbumEntry class]};
}
@end

@implementation ArticleHomeClassItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _icon = [_icon isNotNull]?_icon:_selectedIcon;
    _selectedIcon = [_selectedIcon isNotNull]?_selectedIcon:_icon;
    return YES;
}
@end

@implementation ArticleHomeClass
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"classes":@"class"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"classes":[ArticleHomeClassItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupColor];
    return YES;
}

- (void)setupColor {
    UIColor *color;
    if ([_classBgc isNotNull]) {
        color = [UIColor colorFromHexString:_classBgc];
    }else{
        color = [UIColor whiteColor];
    }
    _bgColor = [color colorWithAlphaComponent:0.9];
}

@end

@implementation ArticleHomeData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"clazz":@"class"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"articleLst":[ArticleHomeItem class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_articleLst.count<=0) {
        _articleLst = [NSArray modelArrayWithClass:[ArticleHomeItem class] json:dic[@"article"]];
    }
    
    NSMutableArray<NSMutableArray<ArticleHomeItem *> *> *sections = [NSMutableArray array];
    
    NSMutableArray<ArticleHomeItem *> *section_header = [NSMutableArray array];
    NSArray<ArticleHomeBanner *> *banners = _header.banners;
    if (banners.count>0) {
        ArticleHomeItem *item = [[ArticleHomeItem alloc] init];
        item.listTemplate     = ArticleHomeListTemplateHeadBanner;
        item.banners          = banners;
        CGFloat ratio         = banners[0].ratio;
        item.ratio            = ratio>0?ratio:0.4;
        [section_header addObject:item];
    }
    ArticleHomeColumnTitle *columnTitle = _header.columnTitle;
    if (columnTitle) {
        ArticleHomeItem *item = [[ArticleHomeItem alloc] init];
        item.listTemplate     = ArticleHomeListTemplateColumnTitle;
        item.imgUrl           = columnTitle.imgUrl;
        item.title            = columnTitle.title;
        item.columnTags       = columnTitle.tags;
        [section_header addObject:item];
    }
    NSArray<ArticleHomeAlbumEntry *> *columnEntrys = _header.columnEntrys;
    if (columnEntrys.count>0) {
        ArticleHomeItem *item = [[ArticleHomeItem alloc] init];
        item.listTemplate     = ArticleHomeListTemplateAlbumEntrys;
        item.albumEntrys      = columnEntrys;
        [section_header addObject:item];
    }
    NSArray<ArticleHomeAlbumEntry *> *albumEntrys = _header.albumEntrys;
    if (albumEntrys.count>0) {
        ArticleHomeItem *item = [[ArticleHomeItem alloc] init];
        item.listTemplate     = ArticleHomeListTemplateAlbumEntrys;
        item.albumEntrys      = albumEntrys;
        [section_header addObject:item];
    }
    if (section_header.count>0) {
        [sections addObject:section_header];
    }
    
    [_articleLst enumerateObjectsUsingBlock:^(ArticleHomeItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray<ArticleHomeItem *> *section_item = [NSMutableArray array];
        [section_item addObject:obj];
        [sections addObject:section_item];
    }];
    
    _sections = sections.count>0?[NSArray arrayWithArray:sections]:nil;
    
    return YES;
}
@end

@implementation ArticleHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
