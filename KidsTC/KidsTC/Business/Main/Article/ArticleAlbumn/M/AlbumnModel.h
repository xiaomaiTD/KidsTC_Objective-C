//
//  AlbumnModel.h
//  KidsTC
//
//  Created by zhanping on 4/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACBigImagesListItem : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *smallImgUrl;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSAttributedString *attributeContent;
@end

@interface ADArticleTop : NSObject
@property (nonatomic, assign) NSInteger topTemplate;
@end

@interface ADContentsItem : NSObject
@property (nonatomic, strong) NSArray *bigImagesList;
@property (nonatomic, assign) NSInteger contentDetailType;
@property (nonatomic, assign) NSInteger sortNo;
@end

@interface ADArticleContent : NSObject
@property (nonatomic, strong) NSString *sysNo;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger articleKind;
@property (nonatomic, assign) NSInteger viewTimes;
@property (nonatomic, strong) NSString *simply;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, assign) NSInteger collectNum;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) NSInteger shareCount;
@property (nonatomic, strong) NSString *linkUrl;
@end

@interface ARData : NSObject
@property (nonatomic, strong) ADArticleTop *articleTop;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) ADArticleContent *articleContent;
@end

@interface AlbumnResponse : NSObject
@property (nonatomic, strong) ARData *data;
@end
