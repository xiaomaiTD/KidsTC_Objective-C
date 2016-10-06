//
//  ArticleLayout.h
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "ArticleModel.h"

#define marginInsets 12 //距离屏幕边缘的内间距

#define ArticleCellLingHeight 8

#define ListTemplate_tag_img_imgWidth (SCREEN_WIDTH - 2*marginInsets) //带标签大图的大图宽度
#define ListTemplate_tag_img_productImgSize 50 //带标签大图的每个product的img宽高度
#define ListTemplate_tag_img_productTextWidth 200 //带标签大图的每个product的每行文本宽高度
/**
 布局排版应该在后台线程完成。
 */

@interface ArticleLayout : NSObject
@property (nonatomic, strong) ALstItem *item;

@property (nonatomic, assign) CGFloat height;//cell的总高度

/**
 *  1
 *
 *  ListTemplate_icon = 1,//文章带图标
 */
@property (nonatomic, strong) NSDictionary *columnTitleAttributes;  //栏目标题的字体大小
@property (nonatomic, assign) CGRect columnTitleRect;               //栏目标题
@property (nonatomic, strong) NSDictionary *titleAttributes;        //标题的字体大小
@property (nonatomic, assign) CGRect titleRect;                     //标题
@property (nonatomic, strong) NSMutableAttributedString *brifContentAttributeStr;
@property (nonatomic, strong) NSDictionary *brifContentAttributes;  //简介的字体大小
@property (nonatomic, assign) CGRect brifContentRect;               //简介
@property (nonatomic, assign) CGRect authorImgRect;                 //作者头像
@property (nonatomic, strong) NSDictionary *authorNameAttributes;    //作者名称字体大小
@property (nonatomic, assign) CGRect authorNameRect;                //作者名称
@property (nonatomic, assign) CGRect redNumIconRect;                //显示已读的小图标
@property (nonatomic, strong) NSDictionary *readNumAttributes;       //显示已读的数量的字体大小
@property (nonatomic, assign) CGRect readNumRect;                   //显示已读的数量
@property (nonatomic, assign) CGRect likeNumIconRect;               //显示喜欢的小图标
@property (nonatomic, strong) NSDictionary *likeNumAttributes;       //显示喜欢的数量的字体大小
@property (nonatomic, assign) CGRect likeNumRect;                    //显示喜欢的数量
@property (nonatomic, assign) CGRect imgRect;                       //单张图片的位置


/**
 *  2
 *
 *  ListTemplate_no_icon,//不带图标
 */

//比 [ListTemplate_icon = 1,//文章带图标] 少一个 imgRect 的赋值



/**
 *  3
 *
 *  ListTemplate_bigImg,//文章带大图，可能带浮层，副标题，描述信息
 */



/**
 *  4
 *
 *  ListTemplate_tag_img,//带标签大图
 */
@property (nonatomic, strong) NSArray *tagPoints;//所有标签在图片中的位置
@property (nonatomic, strong) NSArray *productRects;//所有product在Cell中的frame


/**
 *  5
 *
 *  ListTemplate_bannner,//banner
 */

@property (nonatomic, assign) CGRect bannerRect;//banner


/**
 *  6
 *
 *  ListTemplate_video,//视频
 */
@property (nonatomic, assign) CGRect audioPlayImgViewRect;

/**
 *  7
 *
 *  ListTemplate_album,//图集
 */
@property (nonatomic, strong) NSArray *imgPicRects;
@property (nonatomic, assign) CGRect imgPicUrlsScrollViewRect;
@property (nonatomic, assign) CGSize imgPicUrlsScrollViewContentSize;


/**
 *  1000
 *
 *  ListTemplate_headColumnTitle = 1000,//头部标题
 */

@property (nonatomic, strong) NSArray *headColumnTitleTagRects;
@property (nonatomic, strong) NSDictionary *headColumnTitleTagBtnAttributes;

/**
 *  1001
 *
 *  ListTemplate_columnEntrys = 1001,//头部带蒙层的图集
 */


/**
 *  1002
 *
 *  ListTemplate_albumEntrys = 1002//头部图集
 */

@end
