//
//  ArticleLayout.m
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//




#define ListTemplate_icon_textWidth (SCREEN_WIDTH * 0.7) //文章带图标 控制文本的宽度
#define authorImgRectSize 20//作者头像的尺寸
#define authorNameRectWidth 100//作者名称的宽度

#define redNumIconRectSize CGSizeMake(15, 13)//已读的小图标的尺寸
#define likeNumIconRectSize CGSizeMake(13, 13)//喜欢的小图标的尺寸

#define numIconRectSizeMargin 4//图标和文字之间的间距
#define numRectWith 20 //显示已读和喜欢的文字的宽度


#define ListTemplate_no_icon_textWidth (SCREEN_WIDTH - 2*marginInsets)//不带图标 控制文本的宽度

#define ListTemplate_bigImg_textAndImgWidth (SCREEN_WIDTH - 2*marginInsets) //文章带大图 控制文本和大图的宽度

#define ListTemplate_bigImg_titleRectHight 30 //文章带大图 控制titleLabel的高度

#define ListTemplate_bannner_width (SCREEN_WIDTH) //Banner的宽度

#define ListTemplate_video_textAndImgWidth (SCREEN_WIDTH - 2*marginInsets) //视频的文本和img的宽度

#define ListTemplate_headColumnTitle_IconSize 20 //头部标题小icon的大小

#define ListTemplate_headColumnTitle_titleWidth 100 //头部标题的宽度

#define ListTemplate_headColumnTitle_tagWidth 50 //头部标题的每个tag宽度

#define ListTemplate_album_textAndAlbumWidth (SCREEN_WIDTH - 2*marginInsets) //图集的文本和图集的宽度
#define ListTemplate_album_imgPicsMargin 8 //图集每张图片之间的间距

#define ListTemplate_columnEntrys_AlbumWidth (SCREEN_WIDTH - 2*marginInsets) //头部带蒙层的图集的宽度
#define ListTemplate_columnEntrys_imgMargin 8 //头部带蒙层的图集的每张图片之间的间距

#define ListTemplate_albumEntrys_AlbumWidth (SCREEN_WIDTH - 2*marginInsets) //头部普通图集的宽度
#define ListTemplate_albumEntrys_imgMargin 8 //头部普通图集的每张图片之间的间距


#define marginPic 8//图片之间的间距
#define marginB 8 //下边留白
#define authorH 40 //作者，查看数，点赞数 显示栏目

#import "ArticleLayout.h"
#import <CoreText/CoreText.h>

@implementation ArticleLayout


-(void)setItem:(ALstItem *)item{
    _item = item;
    
    UIColor *color = COLOR_PINK;
    //栏目标题的字体属性
    _columnTitleAttributes = @{NSForegroundColorAttributeName:color,
                               NSFontAttributeName:[UIFont systemFontOfSize:15]};
    //标题的字体属性
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing = 6;
    _titleAttributes = @{NSForegroundColorAttributeName:[UIColor darkTextColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:17],
                             NSParagraphStyleAttributeName:para};
    //简介的字体属性
    _brifContentAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:15]};
    //作者名称字体属性
    _authorNameAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:13]};
    //显示已读的数量的字体属性
    _readNumAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:13]};
    //显示喜欢的数量的字体属性
    _likeNumAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    switch (_item.listTemplate) {
        case ListTemplate_icon://文章带图标
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_icon_textWidth, columnTitleRectHight);
            
            //标题
            CGFloat titleRectHight = [self hightWithStr:_item.title attributes:_titleAttributes width:ListTemplate_icon_textWidth];
            if (titleRectHight>50) titleRectHight = 50;
            _titleRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_icon_textWidth, titleRectHight);
            
            //简介
            _brifContentAttributeStr = [[NSMutableAttributedString alloc]initWithString:_item.brifContent];
            
            [_brifContentAttributeStr addAttributes:_brifContentAttributes range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            //段落样式
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
            //对齐方式
            paragraph.alignment = NSTextAlignmentLeft;
            //添加段落设置
            [_brifContentAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ListTemplate_icon_textWidth, 0)];
            tempLabel.numberOfLines = 4;
            tempLabel.attributedText = _brifContentAttributeStr;
            [tempLabel sizeToFit];
            
            CGFloat brifContentRectHight = tempLabel.frame.size.height; //[_brifContentAttributeStr boundingHeightForWidth:ListTemplate_icon_textWidth];
            _brifContentRect = CGRectMake(marginInsets, CGRectGetMaxY(_titleRect)+marginInsets, ListTemplate_icon_textWidth, brifContentRectHight);
            
            //作者头像
            _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(_brifContentRect)+marginInsets, authorImgRectSize, authorImgRectSize);
            
            //作者名称
            CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
            CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
            _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
            
            //显示喜欢的数量
            CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
            CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
            CGFloat likeNumRectX = ListTemplate_icon_textWidth + marginInsets - likeNumRectSize.width;
            _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
            
            //显示喜欢的小图标
            CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
            CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
            _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
            
            //显示已读的数量
            CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
            CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
            CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
            _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
            
            //显示已读的小图标
            
            CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
            CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
            _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
            
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            
            
            //单张图片的位置
            CGFloat imgRectX = marginInsets + ListTemplate_icon_textWidth + marginInsets/2.0;
            CGFloat imgSize_X  = SCREEN_WIDTH - imgRectX - marginInsets;//从X方向来判断imgSize的值
            //CGFloat imgSize_Y = _height - marginInsets*2;//从Y方向来判断imgSize的值
            //CGFloat imgSize = imgSize_X>=imgSize_Y?imgSize_Y:imgSize_X;//取最小的imgSize
            CGFloat imgSize = imgSize_X;
            CGFloat imgRextY = (_height - imgSize)/2.0;
            _imgRect = CGRectMake(imgRectX, imgRextY, imgSize, imgSize);
        }
            break;
        case ListTemplate_no_icon://不带图标
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_no_icon_textWidth, columnTitleRectHight);
            
            //标题
            CGFloat titleRectHight = [self hightWithStr:_item.title attributes:_titleAttributes width:ListTemplate_no_icon_textWidth];
            if (titleRectHight>50) titleRectHight = 50;
            _titleRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_no_icon_textWidth, titleRectHight);
            
            
            //简介
            _brifContentAttributeStr = [[NSMutableAttributedString alloc]initWithString:_item.brifContent];
            
            [_brifContentAttributeStr addAttributes:_brifContentAttributes range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            //段落样式
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
            //对齐方式
            paragraph.alignment = NSTextAlignmentLeft;
            //添加段落设置
            [_brifContentAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ListTemplate_no_icon_textWidth, 0)];
            tempLabel.numberOfLines = 4;
            tempLabel.attributedText = _brifContentAttributeStr;
            [tempLabel sizeToFit];
            
            CGFloat brifContentRectHight = tempLabel.frame.size.height;
            _brifContentRect = CGRectMake(marginInsets, CGRectGetMaxY(_titleRect)+marginInsets, ListTemplate_no_icon_textWidth, brifContentRectHight);
            
            //作者头像
            _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(_brifContentRect)+marginInsets, authorImgRectSize, authorImgRectSize);
            //作者名称
            CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
            CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
            _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
            
            //显示喜欢的数量
            CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
            CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
            CGFloat likeNumRectX = ListTemplate_no_icon_textWidth + marginInsets - likeNumRectSize.width;
            _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
            
            //显示喜欢的小图标
            CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
            CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
            _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
            
            //显示已读的数量
            CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
            CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
            CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
            _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
            
            //显示已读的小图标
            
            CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
            CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
            _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
            
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            
        }
            break;
        case ListTemplate_bigImg://文章带大图，可能带浮层，副标题，描述信息
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_bigImg_textAndImgWidth, columnTitleRectHight);
            
            CGFloat imgRectY = 0;
            if (_item.brifContent && ![_item.brifContent isEqualToString:@""]) {
                //简介
                _brifContentAttributeStr = [[NSMutableAttributedString alloc]initWithString:_item.brifContent];
                
                [_brifContentAttributeStr addAttributes:_brifContentAttributes range:NSMakeRange(0, _brifContentAttributeStr.length)];
                
                //段落样式
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
                paragraph.lineSpacing = 8;
                paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
                //对齐方式
                paragraph.alignment = NSTextAlignmentLeft;
                //添加段落设置
                [_brifContentAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _brifContentAttributeStr.length)];
                
                UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ListTemplate_bigImg_textAndImgWidth, 0)];
                tempLabel.numberOfLines = 4;
                tempLabel.attributedText = _brifContentAttributeStr;
                [tempLabel sizeToFit];
                
                CGFloat brifContentRectHight = tempLabel.frame.size.height;
                _brifContentRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_bigImg_textAndImgWidth, brifContentRectHight);
                
                imgRectY = CGRectGetMaxY(_brifContentRect)+marginInsets;
            }else{
                imgRectY = CGRectGetMaxY(_columnTitleRect)+marginInsets;
            }
            
            
            //大图
            CGFloat ratio = _item.ratio==0?0.4:_item.ratio;
            CGFloat imgRectHight = ListTemplate_bigImg_textAndImgWidth * ratio;
            _imgRect = CGRectMake(marginInsets, imgRectY, ListTemplate_bigImg_textAndImgWidth, imgRectHight);
            
            //标题
            _titleAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:15]};
            //标题
            _titleRect = CGRectMake(_imgRect.origin.x, CGRectGetMaxY(_imgRect) - ListTemplate_bigImg_titleRectHight, ListTemplate_bigImg_textAndImgWidth, ListTemplate_bigImg_titleRectHight);
            
            if (!_item.authorImgUrl || [_item.authorImgUrl isEqualToString:@""]) {
                _height = CGRectGetMaxY(_imgRect)+marginInsets;
                
            }else{
                //作者头像
                _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(_imgRect)+marginInsets, authorImgRectSize, authorImgRectSize);
                
                //作者名称
                CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
                CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
                _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
                
                //显示喜欢的数量
                CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
                CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
                CGFloat likeNumRectX = ListTemplate_bigImg_textAndImgWidth + marginInsets - likeNumRectSize.width;
                _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
                
                //显示喜欢的小图标
                CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
                CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
                _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
                
                //显示已读的数量
                CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
                CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
                CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
                _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
                
                //显示已读的小图标
                
                CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
                CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
                _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
                
                _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            }
            
        }
            break;
        case ListTemplate_tag_img://带标签大图
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_icon_textWidth, columnTitleRectHight);
            
            //大图
            CGFloat ratio = _item.ratio==0?0.4:_item.ratio;
            CGFloat imgRectHight = ListTemplate_tag_img_imgWidth * ratio;
            _imgRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_tag_img_imgWidth, imgRectHight);
            
            //所有的标签
            NSArray *tags = item.tags;
            NSMutableArray *tagPoints = [NSMutableArray new];
            for (AITagsItem *tagsItem in tags) {
                CGFloat x = _imgRect.size.width * tagsItem.left/100.0;
                CGFloat y = _imgRect.size.height * tagsItem.top/100.0;
                CGPoint point = CGPointMake(x, y);
                [tagPoints addObject:[NSValue valueWithCGPoint:point]];
            }
            _tagPoints = tagPoints;
            
            //所有的product
            NSArray *products = item.products;
            NSMutableArray *productRects = [NSMutableArray new];
            CGFloat productHight = ListTemplate_tag_img_productImgSize + 2*marginInsets;
            for (int i = 0; i<products.count; i++) {
                
                CGFloat lineHight = LINE_H;
                CGFloat y = CGRectGetMaxY(_imgRect) +lineHight + (productHight + lineHight)*i;
                CGRect rect = CGRectMake(marginInsets, y, ListTemplate_tag_img_imgWidth, productHight);
                [productRects addObject:[NSValue valueWithCGRect:rect]];
            }
            _productRects = productRects;
            
            CGRect lastProductRect = [_productRects[products.count-1] CGRectValue];
            
            //作者头像
            _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(lastProductRect)+marginInsets, authorImgRectSize, authorImgRectSize);
            
            //作者名称
            CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
            CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
            _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
            
            //显示喜欢的数量
            CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
            CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
            CGFloat likeNumRectX = ListTemplate_tag_img_imgWidth + marginInsets - likeNumRectSize.width;
            _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
            
            //显示喜欢的小图标
            CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
            CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
            _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
            
            //显示已读的数量
            CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
            CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
            CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
            _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
            
            //显示已读的小图标
            CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
            CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
            _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            
        }
            break;
        case ListTemplate_bannner://banner
        {
            if (_item.banners.count>0) {
                AHBannersItem *bannerItem = _item.banners[0];
                CGFloat ratio = bannerItem.ratio==0?0.4:bannerItem.ratio;
                CGFloat bannerHight = ListTemplate_bannner_width*ratio;
                _bannerRect = CGRectMake(0, 0, ListTemplate_bannner_width, bannerHight);
                
                _height = CGRectGetMaxY(_bannerRect);
            }
        }
            break;
        case ListTemplate_video://视频
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_video_textAndImgWidth, columnTitleRectHight);
            
            
            //简介
            _brifContentAttributeStr = [[NSMutableAttributedString alloc]initWithString:_item.brifContent];
            
            [_brifContentAttributeStr addAttributes:_brifContentAttributes range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            //段落样式
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
            //对齐方式
            paragraph.alignment = NSTextAlignmentLeft;
            //添加段落设置
            [_brifContentAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ListTemplate_video_textAndImgWidth, 0)];
            tempLabel.numberOfLines = 4;
            tempLabel.attributedText = _brifContentAttributeStr;
            [tempLabel sizeToFit];
            
            CGFloat brifContentRectHight = tempLabel.frame.size.height;
            _brifContentRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_video_textAndImgWidth, brifContentRectHight);
            
            //大图
            CGFloat ratio = _item.ratio==0?0.4:_item.ratio;
            CGFloat imgRectHight = ListTemplate_bigImg_textAndImgWidth * ratio;
            _imgRect = CGRectMake(marginInsets, CGRectGetMaxY(_brifContentRect)+marginInsets, ListTemplate_video_textAndImgWidth, imgRectHight);
            
            //作者头像
            _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(_imgRect)+marginInsets, authorImgRectSize, authorImgRectSize);
            
            //作者名称
            CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
            CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
            _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
            
            //显示喜欢的数量
            CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
            CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
            CGFloat likeNumRectX = ListTemplate_video_textAndImgWidth + marginInsets - likeNumRectSize.width;
            _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
            
            //显示喜欢的小图标
            CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
            CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
            _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
            
            //显示已读的数量
            CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
            CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
            CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
            _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
            
            //显示已读的小图标
            
            CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
            CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
            _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
            
        }
            break;
        case ListTemplate_album://图集
        case ListTemplate_UserAlbum:
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_album_textAndAlbumWidth, columnTitleRectHight);
            
            NSArray *imgPicUrls = _item.imgPicUrls;
            if (imgPicUrls.count>0) {
                
                //图集里面的每个图片的大小
                CGFloat imgPicSize = 0;
//                if (imgPicUrls.count <= 4) {//小于或者等于4个的时候，按照4个来处理
//                    CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 3*ListTemplate_album_imgPicsMargin;
//                    imgPicSize = leftWidth / 4.0;
//                }else{//大于4个的时候 按照4.2个图片来处理
//                    CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 4*ListTemplate_album_imgPicsMargin;
//                    imgPicSize = leftWidth / 4.2;
//                }
                CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 3*ListTemplate_album_imgPicsMargin;
                imgPicSize = leftWidth / 3.5;
                //图集里面的每个图片的frame的数组
                NSMutableArray *imgPicRects = [NSMutableArray new];
                for (int i = 0; i<imgPicUrls.count; i++) {
                    CGFloat imgPicX = (imgPicSize + ListTemplate_album_imgPicsMargin)*i;
                    CGRect imgPicRect = CGRectMake(imgPicX, 0, imgPicSize, imgPicSize);
                    [imgPicRects addObject:[NSValue valueWithCGRect:imgPicRect]];
                }
                _imgPicRects = imgPicRects;
                
                //图集滚动视图的大小
                _imgPicUrlsScrollViewRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_album_textAndAlbumWidth, imgPicSize);
                _imgPicUrlsScrollViewContentSize = CGSizeMake(imgPicUrls.count * (imgPicSize + ListTemplate_album_imgPicsMargin) - ListTemplate_album_imgPicsMargin, imgPicSize);
                _height = CGRectGetMaxY(_imgPicUrlsScrollViewRect)+marginInsets;
            }else{
                _height = CGRectGetMaxY(_columnTitleRect)+marginInsets;
            }
            
            
        }
            break;
        case ListTemplate_UserArticle:
        {
            //栏目标题
            CGFloat columnTitleRectY = _item.isHaveTopMargin?marginInsets:0;
            CGFloat columnTitleRectHight = [self oneRowHightWithStr:_item.columnTitle  attributes:_columnTitleAttributes];
            _columnTitleRect = CGRectMake(marginInsets, columnTitleRectY, ListTemplate_no_icon_textWidth, columnTitleRectHight);
            
            //标题
            CGFloat titleRectHight = [self hightWithStr:_item.title attributes:_titleAttributes width:ListTemplate_no_icon_textWidth];
            if (titleRectHight>50) titleRectHight = 50;
            _titleRect = CGRectMake(marginInsets, CGRectGetMaxY(_columnTitleRect)+marginInsets, ListTemplate_no_icon_textWidth, titleRectHight);
            
            
            //简介
            _brifContentAttributeStr = [[NSMutableAttributedString alloc]initWithString:_item.brifContent];
            
            [_brifContentAttributeStr addAttributes:_brifContentAttributes range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            //段落样式
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
            //对齐方式
            paragraph.alignment = NSTextAlignmentLeft;
            //添加段落设置
            [_brifContentAttributeStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, _brifContentAttributeStr.length)];
            
            UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ListTemplate_no_icon_textWidth, 0)];
            tempLabel.numberOfLines = 4;
            tempLabel.attributedText = _brifContentAttributeStr;
            [tempLabel sizeToFit];
            
            CGFloat brifContentRectHight = tempLabel.frame.size.height;
            _brifContentRect = CGRectMake(marginInsets, CGRectGetMaxY(_titleRect)+marginInsets, ListTemplate_no_icon_textWidth, brifContentRectHight);
            
            
            NSArray *imgPicUrls = _item.imgPicUrls;
            if (imgPicUrls.count>0) {
                
                //图集里面的每个图片的大小
                CGFloat imgPicSize = 0;
                //                if (imgPicUrls.count <= 4) {//小于或者等于4个的时候，按照4个来处理
                //                    CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 3*ListTemplate_album_imgPicsMargin;
                //                    imgPicSize = leftWidth / 4.0;
                //                }else{//大于4个的时候 按照4.2个图片来处理
                //                    CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 4*ListTemplate_album_imgPicsMargin;
                //                    imgPicSize = leftWidth / 4.2;
                //                }
                CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 3*ListTemplate_album_imgPicsMargin;
                imgPicSize = leftWidth / 3.5;
                //图集里面的每个图片的frame的数组
                NSMutableArray *imgPicRects = [NSMutableArray new];
                for (int i = 0; i<imgPicUrls.count; i++) {
                    CGFloat imgPicX = (imgPicSize + ListTemplate_album_imgPicsMargin)*i;
                    CGRect imgPicRect = CGRectMake(imgPicX, 0, imgPicSize, imgPicSize);
                    [imgPicRects addObject:[NSValue valueWithCGRect:imgPicRect]];
                }
                _imgPicRects = imgPicRects;
                
                //图集滚动视图的大小
                _imgPicUrlsScrollViewRect = CGRectMake(marginInsets, CGRectGetMaxY(_brifContentRect)+marginInsets, ListTemplate_album_textAndAlbumWidth, imgPicSize);
                _imgPicUrlsScrollViewContentSize = CGSizeMake(imgPicUrls.count * (imgPicSize + ListTemplate_album_imgPicsMargin) - ListTemplate_album_imgPicsMargin, imgPicSize);
                _height = CGRectGetMaxY(_imgPicUrlsScrollViewRect)+marginInsets;
            }else{
                _height = CGRectGetMaxY(_brifContentRect)+marginInsets;
            }
            
            //作者头像
            _authorImgRect = CGRectMake(marginInsets, CGRectGetMaxY(_imgPicUrlsScrollViewRect)+marginInsets, authorImgRectSize, authorImgRectSize);
            
            //作者名称
            CGFloat authorNameRectHight = [self oneRowHightWithStr:_item.authorName attributes:_authorNameAttributes];
            CGFloat authorNameRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - authorNameRectHight)/2.0;
            _authorNameRect = CGRectMake(CGRectGetMaxX(_authorImgRect)+marginInsets, authorNameRectY, authorNameRectWidth, authorNameRectHight);
            
            //显示喜欢的数量
            CGSize likeNumRectSize = [[NSString stringWithFormat:@"%zd",_item.likeNum] sizeWithAttributes:_likeNumAttributes];
            CGFloat likeNumRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumRectSize.height)/2.0;
            CGFloat likeNumRectX = ListTemplate_no_icon_textWidth + marginInsets - likeNumRectSize.width;
            _likeNumRect = CGRectMake(likeNumRectX, likeNumRectY, likeNumRectSize.width, likeNumRectSize.height);
            
            //显示喜欢的小图标
            CGFloat likeNumIconRectX = _likeNumRect.origin.x-numIconRectSizeMargin-likeNumIconRectSize.width;
            CGFloat likeNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - likeNumIconRectSize.height)/2.0;
            _likeNumIconRect = CGRectMake(likeNumIconRectX, likeNumIconRectY, likeNumIconRectSize.width, likeNumIconRectSize.height);
            
            //显示已读的数量
            CGSize readNumRectSize = [[NSString stringWithFormat:@"%zd",_item.readNum] sizeWithAttributes:_readNumAttributes];
            CGFloat readNumRectY  = _authorImgRect.origin.y + (_authorImgRect.size.height - readNumRectSize.height)/2.0;
            CGFloat readNumRectX = _likeNumIconRect.origin.x - numIconRectSizeMargin - readNumRectSize.width;
            _readNumRect = CGRectMake(readNumRectX, readNumRectY, readNumRectSize.width, readNumRectSize.height);
            
            //显示已读的小图标
            
            CGFloat redNumIconRectX = _readNumRect.origin.x - numIconRectSizeMargin- redNumIconRectSize.width;
            CGFloat redNumIconRectY = _authorImgRect.origin.y + (_authorImgRect.size.height - redNumIconRectSize.height)/2.0;
            _redNumIconRect = CGRectMake(redNumIconRectX, redNumIconRectY, redNumIconRectSize.width, redNumIconRectSize.height);
            
            
            _height = CGRectGetMaxY(_authorImgRect)+marginInsets;
        }
            break;
        case ListTemplate_headColumnTitle://头部标题
        {
            //头部小icon的frame
            CGFloat imgRectY = _item.isHaveTopMargin?marginInsets*1.2:0;
            _imgRect = CGRectMake(marginInsets, imgRectY, ListTemplate_headColumnTitle_IconSize, ListTemplate_headColumnTitle_IconSize);
            
            //头部的title的frame
            CGFloat titleRectHight = [self oneRowHightWithStr:_item.headColumnTitle.title attributes:_titleAttributes];
            CGFloat titleRectY = _imgRect.origin.y + (_imgRect.size.height - titleRectHight)/2.0;
            _titleRect = CGRectMake(CGRectGetMaxX(_imgRect)+marginInsets/2.0, titleRectY, ListTemplate_headColumnTitle_titleWidth, titleRectHight);
            
            //头部所有的tag的frame
            NSArray *tags = _item.headColumnTitle.tags;
            if (tags.count>0) {
                CGFloat tagY = imgRectY;
                CGFloat tagWidth = ListTemplate_headColumnTitle_tagWidth;
                CGFloat tagHight = _imgRect.size.height;
                NSMutableArray *tagRects = [NSMutableArray new];
                for (int i = 0; i<tags.count; i++) {
                    CGFloat tagX = SCREEN_WIDTH - marginInsets - (tags.count - i)*tagWidth;
                    CGRect tagRect = CGRectMake(tagX, tagY, tagWidth, tagHight);
                    [tagRects addObject:[NSValue valueWithCGRect:tagRect]];
                }
                
                _headColumnTitleTagBtnAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                     NSFontAttributeName:[UIFont systemFontOfSize:15]};
                _headColumnTitleTagRects = tagRects;
            }
            _height = CGRectGetMaxY(_imgRect)+marginInsets*1.2;
            
            
        }
            break;
        case ListTemplate_albumEntrys://头部普通图集
        {
            NSArray *albumEntrysItems = _item.albumEntrys;//头部普通图集;
            if (albumEntrysItems.count>0) {
                
                //图集里面的每个图片的大小
                CGFloat imgSize = 0;
//                if (albumEntrysItems.count <= 4) {//小于或者等于4个的时候，按照4个来处理
//                    
//                }else{//大于4个的时候 按照4.2个图片来处理
//                    CGFloat leftWidth = ListTemplate_album_textAndAlbumWidth - 4*ListTemplate_albumEntrys_imgMargin;
//                    imgSize = leftWidth / 4.2;
//                }
                CGFloat leftWidth = ListTemplate_albumEntrys_AlbumWidth - 3*ListTemplate_albumEntrys_imgMargin;
                imgSize = leftWidth / 3.5;
                //图集里面的每个图片的frame的数组
                NSMutableArray *imgRects = [NSMutableArray new];
                for (int i = 0; i<albumEntrysItems.count; i++) {
                    CGFloat imgX = (imgSize + ListTemplate_albumEntrys_imgMargin)*i;
                    CGRect imgRect = CGRectMake(imgX, 0, imgSize, imgSize);
                    [imgRects addObject:[NSValue valueWithCGRect:imgRect]];
                }
                _imgPicRects = imgRects;
                
                //图集滚动视图的大小
                CGFloat imgPicUrlsScrollViewRectY = _item.isHaveTopMargin?marginInsets:0;
                _imgPicUrlsScrollViewRect = CGRectMake(marginInsets, imgPicUrlsScrollViewRectY, ListTemplate_albumEntrys_AlbumWidth, imgSize);
                _imgPicUrlsScrollViewContentSize = CGSizeMake(albumEntrysItems.count * (imgSize + ListTemplate_albumEntrys_imgMargin) - ListTemplate_albumEntrys_imgMargin, imgSize);
                
                _height = CGRectGetMaxY(_imgPicUrlsScrollViewRect)+marginInsets;
                
            }else{
                _height = 0;
            }
        }
            break;
            
        default:
            break;
    }
    
    if (item.isHaveBottomMargin) {
        _height = _height+ArticleCellLingHeight;
    }
}

#pragma mark - 字符串高度的计算



-(CGFloat)oneRowHightWithStr:(NSString *)str attributes:(NSDictionary *)attributes{
    
    CGSize size = [str sizeWithAttributes:attributes];
    return size.height;
}

-(CGFloat)hightWithStr:(NSString *)str attributes:(NSDictionary *)attributes width:(CGFloat)width{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}


- (BOOL)isNotEmpty:(NSString *)str{
    if (str && ![str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


- (int)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}


@end
