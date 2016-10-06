//
//  Article.h
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  strongright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ListTemplate) {
    
    ListTemplate_icon = 1,//文章带图标
    ListTemplate_no_icon,//不带图标
    ListTemplate_bigImg,//文章带大图，可能带浮层，副标题，描述信息
    ListTemplate_tag_img,//带标签大图
    ListTemplate_bannner,//banner
    ListTemplate_video,//视频
    ListTemplate_album,//图集
    ListTemplate_UserAlbum,//用户图集
    ListTemplate_UserArticle,//用户资讯
    
    ListTemplate_headColumnTitle = 1000,//头部标题
    ListTemplate_albumEntrys = 1001     //头部图集
};

@interface AITagsItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) NSUInteger direction;
@property (nonatomic, assign) NSUInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end

@interface AIProductsItem : NSObject
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *priceTitle;
@property (nonatomic, assign) CGFloat price;
@end

@class AHColumnTitle;
@interface ALstItem : NSObject
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, assign) ListTemplate listTemplate;
@property (nonatomic, strong) NSString *articleSysNo;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) NSString *columnTitle;
@property (nonatomic, strong) NSString *columnSysNo;
@property (nonatomic, strong) NSString *authorImgUrl;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, assign) NSInteger readNum;
@property (nonatomic, assign) NSInteger likeNum;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brifContent;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSArray *imgPicUrls;//list普通图集
@property (nonatomic, strong) NSArray *products;//产品
@property (nonatomic, strong) NSArray *tags;//图片标签

@property (nonatomic, strong) AHColumnTitle *headColumnTitle;   //头部title 不用参与自动解析
@property (nonatomic, strong) NSArray *albumEntrys;             //头部图集 不用参与自动解析

@property (nonatomic, assign) BOOL isHaveBottomMargin; //底部是否有间距
@property (nonatomic, assign) BOOL isHaveTopMargin; //顶部是否有间距
@property (nonatomic, assign) BOOL isLineHide; //底部线条是否隐藏
@property (nonatomic, assign) BOOL isBannerHaveInset; //Banner是否有内边距
@end

@interface AHBannersItem : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end

@interface ACTagsItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@end
@interface AHColumnTitle : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *tags;
@end

@interface AHAlbumEntrysItem : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end

@interface AHeader : NSObject
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) AHColumnTitle *columnTitle;
@property (nonatomic, strong) NSArray *columnEntrys;
@property (nonatomic, strong) NSArray *albumEntrys;
@property (nonatomic, strong) NSString *userHeaderUrl;
@property (nonatomic, assign) NSInteger uid;
@end

@interface AData : NSObject
@property (nonatomic, strong) NSArray   *articleLst;
@property (nonatomic, strong) AHeader   *header;
@end

@interface ArticleResponse : NSObject
@property (nonatomic, strong) AData     *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString  *page;
@end



/**
 *  喜欢
 */

@interface ADHeader : NSObject
@property (nonatomic, strong) NSString *userHeaderUrl;
@property (nonatomic, assign) NSInteger uid;
@end

@interface ALData : NSObject
@property (nonatomic, strong) NSArray *article;
@property (nonatomic, strong) ADHeader *header;
@end

@interface ArticleLikeResponse : NSObject
@property (nonatomic, strong) ALData *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString  *page;
@end


/**
 *  收藏
 */
@interface ArticleCollectionResponse : NSObject
@property (nonatomic, strong) NSArray   *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString  *page;
@end

/**
 *  user_base_info
 */
@interface UBData : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *headUrl;
@end

@interface UserBaseInfoResponse : NSObject
@property (nonatomic, strong) UBData *data;
@end












