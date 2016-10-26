//
//  ArticleHomeModel.h
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SegueModel.h"
#import "ZPTag.h"
#import "Model.h"

typedef enum : NSUInteger {
    ArticleHomeListTemplateIcon=1,//文章带图标
    ArticleHomeListTemplateNoIcon,//不带图标
    ArticleHomeListTemplateBigImg,//文章带大图，可能带浮层，副标题，描述信息
    ArticleHomeListTemplateTagImg,//带标签大图
    ArticleHomeListTemplateBanner,//banner
    ArticleHomeListTemplateVideo, //视频
    ArticleHomeListTemplateAlbum, //图集
    ArticleHomeListTemplateUserAlbum,   //用户图集
    ArticleHomeListTemplateUserArticle, //用户资讯
    
    ArticleHomeListTemplateHeadBanner  = 1000,//头部bannber
    ArticleHomeListTemplateColumnTitle = 1001,//头部标题
    ArticleHomeListTemplateAlbumEntrys = 1002 //头部图集
} ArticleHomeListTemplate;

@interface ArticleHomeBanner : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
/**SelfDefine*/
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface ArticleHomeColumnTag : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
/**SelfDefine*/
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface ArticleHomeColumnTitle : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ArticleHomeColumnTag *> *tags;
@end

@interface ArticleHomeAlbumEntry : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
/**SelfDefine*/
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface ArticleHomeProduct : NSObject
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *priceTitle;
@property (nonatomic, assign) CGFloat  price;
/**SelfDefine*/
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface ArticleHomeTag : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) ZPTagDirectionByInput direction;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
/**SelfDefine*/
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface ArticleHomeItem : NSObject
@property (nonatomic, strong) NSArray<ArticleHomeBanner *> *banners;
@property (nonatomic, strong) NSArray<NSString *> *imgPicUrls;
@property (nonatomic, strong) NSString *authorImgUrl;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, assign) NSUInteger readNum;
@property (nonatomic, assign) NSUInteger likeNum;
@property (nonatomic, strong) NSArray<ArticleHomeProduct *> *products;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brifContent;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSArray<ArticleHomeTag *> *tags;
@property (nonatomic, assign) ArticleHomeListTemplate listTemplate;
@property (nonatomic, strong) NSString *articleSysNo;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) NSString *columnTitle;
@property (nonatomic, strong) NSString *columnSysNo;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
/**SelfDefine*/
@property (nonatomic, strong) NSArray<ArticleHomeColumnTag *> *columnTags;
@property (nonatomic, strong) NSArray<ArticleHomeAlbumEntry *> *albumEntrys;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, strong) NSAttributedString *titleAttributeStr;
@property (nonatomic, strong) NSAttributedString *brifContentAttributeStr;
@end

@interface ArticleHomeHeader : NSObject
@property (nonatomic, strong) NSString *userHeaderUrl;
@property (nonatomic, strong) NSArray<ArticleHomeBanner *> *banners;
@property (nonatomic, strong) ArticleHomeColumnTitle *columnTitle;
@property (nonatomic, strong) NSArray<ArticleHomeAlbumEntry *> *columnEntrys;
@property (nonatomic, strong) NSArray<ArticleHomeAlbumEntry *> *albumEntrys;
@property (nonatomic, strong) NSString *uid;
@end

@interface ArticleHomeClassItem : Model
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *selectedIcon;
/**SelfDefine*/
@property (nonatomic, assign, getter=isSelcted) BOOL selected;
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
@end

@interface ArticleHomeClass : NSObject
@property (nonatomic, strong) NSArray<ArticleHomeClassItem *> *classes;
@property (nonatomic, strong) NSString *classBgc;
/**SelfDefine*/
@property (nonatomic, strong) UIColor *bgColor;
@end

@interface ArticleHomeData : NSObject
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *articleLst;
@property (nonatomic, strong) ArticleHomeHeader *header;
@property (nonatomic, strong) ArticleHomeClass *clazz;
/**SelfDefine*/
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;
@end

@interface ArticleHomeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ArticleHomeData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger page;
@end



