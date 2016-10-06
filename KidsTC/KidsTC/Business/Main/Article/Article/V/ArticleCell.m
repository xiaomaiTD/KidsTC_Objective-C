//
//  ArticleCell.m
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCell.h"
#import "ArticleAutoRollView.h"
#import "ZPTag.h"
#import "ToolBox.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@implementation ACProductView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*marginInsets, LINE_H)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(0, marginInsets, ListTemplate_tag_img_productImgSize, ListTemplate_tag_img_productImgSize);
        [self addSubview:imgView];
        self.imgView = imgView;
    }
    return self;
}
-(void)setProductsItem:(AIProductsItem *)productsItem{
    _productsItem = productsItem;
    
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_productsItem.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    
    NSDictionary *arrtibutes = @{NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:15]};
    //title
    CGFloat titleRectX = CGRectGetMaxX(self.imgView.frame) + marginInsets;
    CGFloat titleRectHight = [_productsItem.title sizeWithAttributes:arrtibutes].height;
    CGFloat titleRectY = self.imgView.center.y - titleRectHight -marginInsets/2.0;
    CGRect titleRect = CGRectMake(titleRectX, titleRectY, ListTemplate_tag_img_productTextWidth, titleRectHight);
    [_productsItem.title drawInRect:titleRect withAttributes:arrtibutes];
    
    //priceTitle
    NSString *priceTitle = [NSString stringWithFormat:@"%@:",_productsItem.priceTitle];
    CGSize priceTitleSize = [priceTitle sizeWithAttributes:arrtibutes];
    CGFloat priceTitleY = self.imgView.center.y + marginInsets/2.0;
    CGRect priceTitleRect = CGRectMake(titleRectX, priceTitleY, priceTitleSize.width, priceTitleSize.height);
    [priceTitle drawInRect:priceTitleRect withAttributes:arrtibutes];
    
    //price
    UIColor *color = COLOR_PINK;
    NSDictionary *priceArrtibutes = @{NSForegroundColorAttributeName:color,
                                 NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSString *priceStr = [NSString stringWithFormat:@"¥%.1f",_productsItem.price];
    CGSize priceSize = [priceStr sizeWithAttributes:priceArrtibutes];
    CGFloat priceRectY = priceTitleRect.origin.y + (priceTitleRect.size.height - priceSize.height)/2.0;
    CGRect priceRect = CGRectMake(CGRectGetMaxX(priceTitleRect), priceRectY, priceSize.width, priceSize.height);
    [priceStr drawInRect:priceRect withAttributes:priceArrtibutes];
    
    // TODO IMG
    UIImage *img = [UIImage imageNamed:@"arrow_r"];
    CGFloat imgWidth = 18;
    CGFloat imgHight = 15;
    CGFloat imgRectX = CGRectGetWidth(self.frame) - marginInsets - imgWidth;
    CGFloat imgRectY = self.imgView.frame.origin.y + (CGRectGetHeight(self.imgView.frame)-imgHight)/2.0;
    CGRect imgRect = CGRectMake(imgRectX, imgRectY, imgWidth, imgHight);
    [img drawInRect:imgRect];
    
}
@end

#define ArticleCellSubviewStyleScale 100
#define ImgPicUrlsScrollViewSubviewStyleScale 10000

typedef NS_ENUM(NSInteger, ArticleCellSubviewStyle) {
    ArticleCellSubviewStyle_autoRollView = 10,       //banner滚动视图
    ArticleCellSubviewStyle_headColumnTitleTagBtn,   //头部标题中的按钮
    
    ArticleCellSubviewStyle_imgPicUrlsScrollView,    //图集的滚动视图
    ArticleCellSubviewStyle_ImgPic,                  //图集里面的imageView的tag值
    
    ArticleCellSubviewStyle_productView,             //productView
    ArticleCellSubviewStyle_zpTag,                   //zpTag
    ArticleCellSubviewStyle_titleLabelInImgView,     //在大图上的label
    ArticleCellSubviewStyle_AudioPlayImgView         //播放的图标
};
@interface ArticleCell ()<ArticleAutoRollViewDelegate,ZPTagDelegate>
@property (nonatomic, weak) UIImageView *authorImageView;
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation ArticleCell

//banner滚动视图
static NSMutableSet *_autoRollViews;
+(NSMutableSet *)shareAutoRollViews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _autoRollViews = [NSMutableSet new];
    });
    return _autoRollViews;
}
//头部标题中的按钮
static NSMutableSet *_headColumnTitleTagBtns;
+(NSMutableSet *)shareHeadColumnTitleTagBtns{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _headColumnTitleTagBtns = [NSMutableSet new];
    });
    return _headColumnTitleTagBtns;
}
//图集的滚动视图
static NSMutableSet *_imgPicUrlsScrollViews;
+(NSMutableSet *)shareImgPicUrlsScrollViews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imgPicUrlsScrollViews = [NSMutableSet new];
    });
    return _imgPicUrlsScrollViews;
}
//productView
static NSMutableSet *_productViews;
+(NSMutableSet *)shareProductViews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _productViews = [NSMutableSet new];
    });
    return _productViews;
}
//图集里面的图片
static NSMutableSet *_imgPics;
+(NSMutableSet *)shareImgPics{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imgPics = [NSMutableSet new];
    });
    return _imgPics;
}
//titleLabelInImgView
static NSMutableSet *_titleLabelInImgViews;
+(NSMutableSet *)shareTitleLabelInImgViews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titleLabelInImgViews = [NSMutableSet new];
    });
    return _titleLabelInImgViews;
}
//audioPlayImgView
static NSMutableSet *_audioPlayImgViews;
+(NSMutableSet *)shareAudioPlayImgViews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioPlayImgViews = [NSMutableSet new];
    });
    return _audioPlayImgViews;
}
//作者头像
-(UIImageView *)authorImageView{
    if (!_authorImageView) {
        UIImageView *authorImageView = [[UIImageView alloc]init];
        authorImageView.clipsToBounds = YES;
        //authorImageView.backgroundColor = [UIColor redColor];
        authorImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:authorImageView];
        authorImageView.hidden = YES;
        _authorImageView = authorImageView;
    }
    return _authorImageView;
}
//单张的图片
-(UIImageView *)imgView{
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        //imgView.backgroundColor = [UIColor redColor];
        imgView.clipsToBounds = YES;
        imgView.hidden = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *brifContentLabel = [[UILabel alloc]init];
        brifContentLabel.numberOfLines = 0;
        [self addSubview:brifContentLabel];
       
        self.brifContentLabel = brifContentLabel;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}


-(void)setLayout:(ArticleLayout *)layout{
    _layout = layout;
    
    [self prepareForDraw];
    [self setNeedsDisplay];
}
-(void)prepareForDraw{
    ALstItem *item = _layout.item;
    
    //改变底部线条的位置
    if (!item.isHaveBottomMargin) {
        self.line.frame = CGRectMake(marginInsets, _layout.height, SCREEN_WIDTH-marginInsets*2, LINE_H);
    }else{
        self.line.frame = CGRectMake(0, _layout.height-ArticleCellLingHeight, SCREEN_WIDTH, ArticleCellLingHeight);
    }
    
    self.line.hidden = item.isLineHide;
    
    if (self.authorImageView) self.authorImageView.hidden = YES;
    if (self.imgView) self.imgView.hidden = YES;
    self.brifContentLabel.hidden = YES;
    
    self.brifContentLabel.frame = _layout.brifContentRect;
    
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
        switch (view.tag/ArticleCellSubviewStyleScale) {
            case ArticleCellSubviewStyle_autoRollView://banner滚动视图
            {
                [[ArticleCell shareAutoRollViews] addObject:view];
                [view removeFromSuperview];
            }
                break;
            case ArticleCellSubviewStyle_headColumnTitleTagBtn://头部标题中的按钮
            {
                [[ArticleCell shareHeadColumnTitleTagBtns] addObject:view];
                [view removeFromSuperview];
                [(UIButton *)view removeTarget:self action:@selector(headColumnTitleTagBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case ArticleCellSubviewStyle_imgPicUrlsScrollView://图集的滚动视图
            {
                [[ArticleCell shareImgPicUrlsScrollViews] addObject:view];
                NSArray *svSubviews = view.subviews;
                for (UIView *svSubview in svSubviews) {
                    switch (svSubview.tag/ImgPicUrlsScrollViewSubviewStyleScale) {
                        case ArticleCellSubviewStyle_ImgPic://图集里面的imageView的tag值
                        {
                            [[ArticleCell shareImgPics] addObject:svSubview];
                            if (svSubview.gestureRecognizers.count>0)[svSubview removeGestureRecognizer:svSubview.gestureRecognizers[0]];
                            [svSubview removeFromSuperview];
                        }
                            break;
                        default:
                            break;
                    }
                }
                [view removeFromSuperview];
            }
                break;
            case ArticleCellSubviewStyle_productView://productView
            {
                [[ArticleCell shareProductViews] addObject:view];
                if (view.gestureRecognizers.count>0) [view removeGestureRecognizer:view.gestureRecognizers[0]];
                [view removeFromSuperview];
            }
                break;
            case ArticleCellSubviewStyle_zpTag:
            {
                [view removeFromSuperview];
            }
                break;
            case ArticleCellSubviewStyle_titleLabelInImgView:
            {
                [[ArticleCell shareTitleLabelInImgViews] addObject:view];
                [view removeFromSuperview];
            }
                break;
            case ArticleCellSubviewStyle_AudioPlayImgView:
            {
                [[ArticleCell shareAudioPlayImgViews] addObject:view];
                [view removeFromSuperview];
            }
                break;
            default:
                break;
        }
    }
}

-(void)drawRect:(CGRect)rect{
    [self draw];
}
-(void)draw{
    
    ALstItem *item = _layout.item;
    switch (item.listTemplate) {
        case ListTemplate_icon://文章带图标
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            [item.title drawInRect:_layout.titleRect withAttributes:_layout.titleAttributes];//标题
            [self setUpBrifContent];
            
            [self drawToolBar];
            [self setUpImgView];
        }
            break;
        case ListTemplate_no_icon://不带图标
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            [item.title drawInRect:_layout.titleRect withAttributes:_layout.titleAttributes];//标题
            [self setUpBrifContent];
            [self drawToolBar];
        }
            break;
        case ListTemplate_bigImg://文章带大图，可能带浮层，副标题，描述信息
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            [self setUpBrifContent];
            if (item.columnTitle && [item.columnTitle isEqualToString:@"萝卜管理员"]) {
                
            }else{
               [self drawToolBar];
            }
            
            [self setUpImgView];
            UILabel *label = [self getTitleLabelInImg];//标题
            label.text = item.title;
            label.frame = _layout.titleRect;
            if (label.tag == ArticleCellSubviewStyle_titleLabelInImgView*ArticleCellSubviewStyleScale) {
                [ToolBox renderGradientForView:label displayFrame:CGRectMake(0, 0, label.frame.size.width, label.frame.size.height) startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:[NSArray arrayWithObjects:RGBA(0, 0, 0, 0), RGBA(0, 0, 0, 0.8), nil] locations:nil];
                label.tag = ArticleCellSubviewStyle_titleLabelInImgView*ArticleCellSubviewStyleScale+1;
            }
        }
            break;
        case ListTemplate_tag_img://带标签大图
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            [self setUpImgView];
            
            //tag
            NSArray *tags = item.tags;
            NSArray *tagPoints = _layout.tagPoints;
            for (int i = 0; i<tags.count; i++) {
                CGPoint point = [self convertPoint:[tagPoints[i] CGPointValue] fromView:self.imgView];
                AITagsItem *tag = tags[i];
                ZPTag *zpTag = [ZPTag CreatTagWithOriginPoint:point];
                zpTag.tag = ArticleCellSubviewStyle_zpTag*ArticleCellSubviewStyleScale+i;
                zpTag.tagDirectionByInput = tag.direction;
                zpTag.title = tag.title;
                zpTag.delegate = self;
                [self addSubview:zpTag];
            }
            
            //products
            NSArray *products = item.products;
            NSArray *productLayouts = _layout.productRects;
            for (int i = 0; i<products.count; i++) {
                ACProductView *productView = [self getProductView];
                productView.tag = ArticleCellSubviewStyle_productView*ArticleCellSubviewStyleScale + i;
                productView.frame = [productLayouts[i] CGRectValue];
                productView.productsItem = products[i];
                
                UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProduct:)];
                [productView addGestureRecognizer:tapGR];
            }
            
            [self drawToolBar];
        }
            break;
        case ListTemplate_bannner://banner
        {
            CGRect frame = _layout.bannerRect;//CGRectMake(0, 0, SCREEN_WIDTH, _layout.height);
            NSMutableSet *autoRollViews = [ArticleCell shareAutoRollViews];
            ArticleAutoRollView *articleAutoRollView = nil;
            if (autoRollViews.count>0) {
                articleAutoRollView = [autoRollViews anyObject];
                articleAutoRollView.isBannerHaveInset = item.isBannerHaveInset;
                articleAutoRollView.delegate = self;
                [articleAutoRollView setCollectionViewFrame:frame];
                [articleAutoRollView setItems:item.banners];
                
                [autoRollViews removeObject:articleAutoRollView];
            }else{
                articleAutoRollView = [[ArticleAutoRollView alloc]initWithFrame:frame items:item.banners delegate:self isBannerHaveInset:item.isBannerHaveInset];
                articleAutoRollView.tag = ArticleCellSubviewStyle_autoRollView*ArticleCellSubviewStyleScale;
            }
        
            [self addSubview:articleAutoRollView];
            
        }
            break;
        case ListTemplate_video://视频
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            
            [self setUpBrifContent];
            [self setUpImgView];
            [self addAudioPlayImgView];
            [self drawToolBar];
        }
            break;
        case ListTemplate_album://图集
        case ListTemplate_UserAlbum:
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题

            UIScrollView *imgPicUrlsScrollView = [self getImgPicUrlsScrollView];
            NSArray *imgPicUrls = item.imgPicUrls;
            for (int i = 0; i<imgPicUrls.count; i++) {
                UIImageView *iv = [self getImgPic];
                iv.frame = [_layout.imgPicRects[i] CGRectValue];
                iv.tag = ArticleCellSubviewStyle_ImgPic*ImgPicUrlsScrollViewSubviewStyleScale+i;
                [imgPicUrlsScrollView addSubview:iv];
                [iv sd_setImageWithURL:[NSURL URLWithString:imgPicUrls[i]] placeholderImage:PLACEHOLDERIMAGE_SMALL];
                UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImgPicItem:)];
                [iv addGestureRecognizer:tapGR];
            }
        }
            break;
        case ListTemplate_UserArticle:
        {
            [item.columnTitle drawInRect:_layout.columnTitleRect withAttributes:_layout.columnTitleAttributes];//栏目标题
            [item.title drawInRect:_layout.titleRect withAttributes:_layout.titleAttributes];//标题
            [self setUpBrifContent];
            UIScrollView *imgPicUrlsScrollView = [self getImgPicUrlsScrollView];
            NSArray *imgPicUrls = item.imgPicUrls;
            for (int i = 0; i<imgPicUrls.count; i++) {
                UIImageView *iv = [self getImgPic];
                iv.frame = [_layout.imgPicRects[i] CGRectValue];
                iv.tag = ArticleCellSubviewStyle_ImgPic*ImgPicUrlsScrollViewSubviewStyleScale+i;
                [imgPicUrlsScrollView addSubview:iv];
                [iv sd_setImageWithURL:[NSURL URLWithString:imgPicUrls[i]] placeholderImage:PLACEHOLDERIMAGE_SMALL];
                UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImgPicItem:)];
                [iv addGestureRecognizer:tapGR];
            }
            [self drawToolBar];
        }
            break;
        case ListTemplate_headColumnTitle://头部标题
        {
            //单张图片
            self.imgView.hidden = NO;
            self.imgView.frame = _layout.imgRect;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.headColumnTitle.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
            [item.headColumnTitle.title drawInRect:_layout.titleRect withAttributes:_layout.titleAttributes];//标题
            //按钮
            NSArray *headColumnTitleTagas = item.headColumnTitle.tags;
            for (int i = 0; i<headColumnTitleTagas.count; i++) {
                UIButton *btn = [self getHeadColumnTitleTagBtn];
                btn.tag = ArticleCellSubviewStyle_headColumnTitleTagBtn*ArticleCellSubviewStyleScale+i;
                ACTagsItem *tagItem = headColumnTitleTagas[i];
                [btn setTitle:tagItem.title forState:UIControlStateNormal];
                btn.frame = [_layout.headColumnTitleTagRects[i] CGRectValue];
                [btn addTarget:self action:@selector(headColumnTitleTagBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
        case ListTemplate_albumEntrys://头部普通图集
        {

            UIScrollView *imgPicUrlsScrollView = [self getImgPicUrlsScrollView];
            NSArray *albumEntrys = item.albumEntrys;
            for (int i = 0; i<albumEntrys.count; i++) {
                UIImageView *iv = [self getImgPic];
                iv.tag = ArticleCellSubviewStyle_ImgPic*ImgPicUrlsScrollViewSubviewStyleScale+i;
                iv.frame =[_layout.imgPicRects[i] CGRectValue];
                [imgPicUrlsScrollView addSubview:iv];
                AHAlbumEntrysItem *albumEntryItem = albumEntrys[i];
                [iv sd_setImageWithURL:[NSURL URLWithString:albumEntryItem.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
                
                UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlbumEntrysItem:)];
                [iv addGestureRecognizer:tapGR];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 通用设置内容的方法

//显示简介
- (void)setUpBrifContent{
    
    if (_layout.brifContentAttributeStr) {
        //[item.brifContent drawInRect:_layout.brifContentRect withAttributes:_layout.brifContentAttributes];//简介
        self.brifContentLabel.hidden = NO;
        self.brifContentLabel.attributedText = _layout.brifContentAttributeStr;
        
    }
}

//设置单张图片
-(void)setUpImgView{
    ALstItem *item = _layout.item;
    //单张图片
    self.imgView.hidden = NO;
    self.imgView.frame = _layout.imgRect;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    //[self.imgView yy_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholder:[UIImage imageNamed:@"placeholder_50_50"]];
//    if (item.listTemplate == ListTemplate_video ||
//        item.listTemplate == ListTemplate_tag_img ||
//        item.listTemplate == ListTemplate_bigImg ||) {//ListTemplate_tag_img ListTemplate_bigImg
//        self.imgView.layer.masksToBounds = NO;
//    }else{
//        
//    }
    
}
//渲染底部的作者等信息
-(void)drawToolBar{
    ALstItem *item = _layout.item;
    //作者图标
    self.authorImageView.hidden = NO;
    self.authorImageView.frame = _layout.authorImgRect;
    [self.authorImageView sd_setImageWithURL:[NSURL URLWithString:item.authorImgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.authorImageView.layer.cornerRadius = CGRectGetWidth(self.authorImageView.frame)*0.5;
    self.authorImageView.layer.masksToBounds = YES;
    
    //作者名称
    [item.authorName drawInRect:_layout.authorNameRect withAttributes:_layout.authorNameAttributes];
    //显示已读的图标
    [[UIImage imageNamed:@"icon_news_look"] drawInRect:_layout.redNumIconRect];
    //显示已读的数量
    [[NSString stringWithFormat:@"%ld",item.readNum] drawInRect:_layout.readNumRect withAttributes:_layout.readNumAttributes];
    //显示喜欢的图标
    NSString *imageName = item.isLike?@"icon_news_like":@"icon_news_like_nor";
    [[UIImage imageNamed:imageName] drawInRect:_layout.likeNumIconRect];
    //显示喜欢的数量
    [[NSString stringWithFormat:@"%ld",item.likeNum] drawInRect:_layout.likeNumRect withAttributes:_layout.likeNumAttributes];
}

#pragma mark - shareviews
//头部标题上的按钮
-(UIButton *)getHeadColumnTitleTagBtn{
    NSMutableSet *headColumnTitleTagBtns = [ArticleCell shareHeadColumnTitleTagBtns];
    UIButton *btn = nil;
    if (headColumnTitleTagBtns.count>0) {//按钮数组里面的按钮够用，而且只要是在按钮数组里面的按钮，就一定在cell里面，且被隐藏起来了
        btn = [headColumnTitleTagBtns anyObject];
        [headColumnTitleTagBtns removeObject:btn];
    }else{//按钮数组里面的按钮不够用或者根本一个按钮都没有
        btn = [[UIButton alloc]init];
        UIColor *color = [_layout.headColumnTitleTagBtnAttributes objectForKey:NSForegroundColorAttributeName];
        UIFont *font = [_layout.headColumnTitleTagBtnAttributes objectForKey:NSFontAttributeName];
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn.titleLabel setFont:font];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        //[btn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    [self addSubview:btn];
    return btn;
}
//获取图集的滚动视图
-(UIScrollView *)getImgPicUrlsScrollView{
    NSMutableSet *imgPicUrlsScrollViews = [ArticleCell shareImgPicUrlsScrollViews];
    UIScrollView *imgPicUrlsScrollView = nil;
    if (imgPicUrlsScrollViews.count>0) {
        imgPicUrlsScrollView = [imgPicUrlsScrollViews anyObject];
        [imgPicUrlsScrollViews removeObject:imgPicUrlsScrollView];
    }else{
        imgPicUrlsScrollView = [[UIScrollView alloc]init];
        imgPicUrlsScrollView.tag = ArticleCellSubviewStyle_imgPicUrlsScrollView*ArticleCellSubviewStyleScale;
        imgPicUrlsScrollView.showsHorizontalScrollIndicator = NO;
    }
    imgPicUrlsScrollView.frame = _layout.imgPicUrlsScrollViewRect;
    imgPicUrlsScrollView.contentSize = _layout.imgPicUrlsScrollViewContentSize;
    [self addSubview:imgPicUrlsScrollView];
    return imgPicUrlsScrollView;
}
//滚动图集里面的图片
-(UIImageView *)getImgPic{
    NSMutableSet *imgPics = [ArticleCell shareImgPics];
    UIImageView *iv = nil;
    if (imgPics.count>0) {
        iv = [imgPics anyObject];
        [imgPics removeObject:iv];
    }else{
        iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        iv.userInteractionEnabled = YES;
        iv.layer.cornerRadius = 4;
        iv.layer.masksToBounds = YES;
    }
    return iv;
}
//ProductView
- (ACProductView *)getProductView{
    NSMutableSet *productViews = [ArticleCell shareProductViews];
    ACProductView *productView = nil;
    if (productViews.count>0) {
        productView = [productViews anyObject];
        [productViews removeObject:productView];
    }else{
        productView  = [[ACProductView alloc]init];
    }
    [self addSubview:productView];
    return productView;
}
//大图上的标题
-(UILabel *)getTitleLabelInImg{
    
    NSMutableSet *titleLabelInImgViews = [ArticleCell shareTitleLabelInImgViews];
    UILabel *label = nil;
    if (titleLabelInImgViews.count>0) {
        label = [titleLabelInImgViews anyObject];
        [titleLabelInImgViews removeObject:label];
    }else{
        label = [[UILabel alloc]init];
        //label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.tag = ArticleCellSubviewStyle_titleLabelInImgView*ArticleCellSubviewStyleScale;
        
    }
    
    [self addSubview:label];
    return label;
}
//播放的图标
-(UIImageView *)addAudioPlayImgView{
    NSMutableSet *audioPlayImgViews = [ArticleCell shareAudioPlayImgViews];
    UIImageView *imgView = nil;
    if (audioPlayImgViews.count>0) {
        imgView = [audioPlayImgViews anyObject];
        [audioPlayImgViews removeObject:imgView];
    }else{
        imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"article_video"]];
        imgView.bounds = CGRectMake(0, 0, 40, 40);
        imgView.tag = ArticleCellSubviewStyle_AudioPlayImgView * ArticleCellSubviewStyleScale;
    }
    imgView.center = _imgView.center;
    [self addSubview:imgView];
    return imgView;
}


#pragma mark - actions

/**
 *  头部标题按钮的点击事件
 *
 *  @param btn 被点击的按钮 根据按钮的tag值来从对应的数组里面取值
 */
-(void)headColumnTitleTagBtnAction:(UIButton *)btn{
    NSUInteger index = btn.tag%ArticleCellSubviewStyleScale;
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnHeadColumnTitleTagBtn:)]) {
        [self.delegate articleCell:self didClickOnHeadColumnTitleTagBtn:_layout.item.headColumnTitle.tags[index]];
    }
}

/**
 *  点击了Banner
 */
-(void)didSelectPageAtIndex:(NSUInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnBannerItem:)]) {
        [self.delegate articleCell:self didClickOnBannerItem:_layout.item.banners[index]];
    }
}

/**
 *  点击了product
 */
-(void)tapProduct:(UITapGestureRecognizer *)tapGR {
    NSUInteger index = tapGR.view.tag%ArticleCellSubviewStyleScale;
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnProductsItem:)]) {
        [self.delegate articleCell:self didClickOnProductsItem:_layout.item.products[index]];
    }
}

/**
 *  点击了头部带普通图集中的图片
 */
-(void)tapAlbumEntrysItem:(UITapGestureRecognizer *)tapGR {
    NSUInteger index = tapGR.view.tag%ImgPicUrlsScrollViewSubviewStyleScale;
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnAlbumEntrysItem:)]) {
        [self.delegate articleCell:self didClickOnAlbumEntrysItem:_layout.item.albumEntrys[index]];
    }
}
/**
 *  点击了图集中的图片
 */
-(void)tapImgPicItem:(UITapGestureRecognizer *)tapGR {
    NSUInteger index = tapGR.view.tag%ImgPicUrlsScrollViewSubviewStyleScale;
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnAlbum:index:)]) {
        [self.delegate articleCell:self didClickOnAlbum:_layout.item index:index];
    }
}

/**
 *  点击了zpTag
 */
- (void)didClickTag:(ZPTag *)tag{
    NSUInteger index = tag.tag%ArticleCellSubviewStyleScale;
    
    if ([self.delegate respondsToSelector:@selector(articleCell:didClickOnTagsItem:)]) {
        [self.delegate articleCell:self didClickOnTagsItem:_layout.item.tags[index]];
    }
}



@end
