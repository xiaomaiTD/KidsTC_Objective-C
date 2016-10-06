//
//  HomeNewsCell.m
//  appDelegate
//
//  Created by 潘灵 on 16/7/20.
//  Copyright © 2016年 潘灵. All rights reserved.
//

#import "HomeNewsCell.h"
#import "UILabel+Additions.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
@interface InfoView ()

@property (nonatomic, strong) UILabel *lb_tag;
@property (nonatomic, strong) UIImageView *iv_read;
@property (nonatomic, strong) UILabel *lb_read;
@property (nonatomic, strong) UIImageView *iv_comment;
@property (nonatomic, strong) UILabel *lb_comment;

@end

@implementation InfoView
-(instancetype)init{
    
    if (self = [super init]) {
        [self addSubview:self.lb_tag];
        [self addSubview:self.iv_read];
        [self addSubview:self.lb_read];
        [self addSubview:self.iv_comment];
        [self addSubview:self.lb_comment];
        
        [self setupConstrait];
        
        self.lb_tag.layer.cornerRadius = 3;
        self.lb_tag.layer.masksToBounds = YES;
        self.lb_tag.layer.borderWidth = LINE_H;
    }
    return self;
}

-(void)setupConstrait{
    
    [self.lb_tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(10);
    }];
    
    [self.iv_read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_tag.mas_trailing).offset(10);
        make.width.height.equalTo(@20);
    }];
    
    [self.lb_read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.iv_read.mas_trailing).offset(2);
    }];
    
    [self.iv_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_read.mas_trailing).offset(10);
        make.width.height.equalTo(@20);
    }];
    
    [self.lb_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.iv_comment.mas_trailing).offset(2);
    }];
}



-(UILabel *)lb_tag{
    if (!_lb_tag) {
        
        _lb_tag = [[UILabel alloc] initWithTitle:@"" FontSize:11 FontColor:[UIColor blackColor]];
    }
    return _lb_tag;
}

-(UILabel *)lb_read{
    if (!_lb_read) {
        
        _lb_read = [[UILabel alloc] initWithTitle:@"0" FontSize:13 FontColor:[UIColor lightGrayColor]];
    }
    return _lb_read;
}

-(UILabel *)lb_comment{
    if (!_lb_comment) {
        
        _lb_comment = [[UILabel alloc] initWithTitle:@"0" FontSize:13 FontColor:[UIColor lightGrayColor]];
    }
    return _lb_comment;
}

-(UIImageView *)iv_read{
    if (!_iv_read) {
        _iv_read = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_cell_view"]];
    }
    return _iv_read;
}

-(UIImageView *)iv_comment{
    if (!_iv_comment) {
        _iv_comment = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_cell_comment"]];
    }
    return _iv_comment;
}
@end


@interface TitleView ()

@property (nonatomic, strong) UILabel *lb_title;

@end

@implementation TitleView

-(instancetype)init{
    
    if (self = [super init]) {
        [self addSubview:self.lb_title];
        [self setupConstrait];
    }
    return self;
}

-(void)setupConstrait{
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
    }];
}

-(UILabel *)lb_title{
    if (!_lb_title) {
        
        _lb_title = [[UILabel alloc] initWithTitle:@"" FontSize:15 FontColor:[UIColor darkGrayColor]];
    }
    return _lb_title;
}

@end


@interface ImgView ()

@property (nonatomic, strong) UIImageView *iv_left;
@property (nonatomic, strong) UIImageView *iv_mid;
@property (nonatomic, strong) UIImageView *iv_right;

@end


@implementation ImgView

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self addSubview:self.iv_left];
        [self addSubview:self.iv_mid];
        [self addSubview:self.iv_right];
        
        [self setupConstrait];
        
        self.iv_left.layer.cornerRadius = 3;
        self.iv_left.layer.masksToBounds = YES;
        self.iv_mid.layer.cornerRadius = 3;
        self.iv_mid.layer.masksToBounds = YES;
        self.iv_right.layer.cornerRadius = 3;
        self.iv_right.layer.masksToBounds = YES;

    }
    return self;
}

-(void)setupConstrait{
    
    [self.iv_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self).offset(10);
        make.width.equalTo(self.iv_mid);
    }];
    
    [self.iv_mid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iv_left.mas_trailing).offset(5);
        make.top.bottom.equalTo(self);
        //make.width.equalTo(self.iv_left);
        make.width.equalTo(self.iv_right);
    }];
    
    [self.iv_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iv_mid.mas_trailing).offset(5);
        make.top.bottom.equalTo(self);
        make.trailing.equalTo(self).offset(-10);
    }];
}

-(UIImageView *)iv_left{
    
    if (!_iv_left) {
        _iv_left = [[UIImageView alloc] init];
        _iv_left.userInteractionEnabled = YES;
    }
    return _iv_left;
}
-(UIImageView *)iv_mid{
    
    if (!_iv_mid) {
        _iv_mid = [[UIImageView alloc] init];
        _iv_mid.userInteractionEnabled = YES;
    }
    return _iv_mid;
}
-(UIImageView *)iv_right{
    
    if (!_iv_right) {
        _iv_right = [[UIImageView alloc] init];
        _iv_right.userInteractionEnabled = YES;
    }
    return _iv_right;
}

@end
@interface HomeNewsCell ()

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) InfoView *infoView;
@property (nonatomic, strong) ImgView *imgView;
@property (nonatomic, strong) UIImageView *iv_news;

@end

@implementation HomeNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupConstraints];
    }
    return self;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.infoView];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.iv_news];

}

-(void)setupConstraints{
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self);
        //
        make.trailing.equalTo(self.iv_news.mas_leading).offset(-5);
        make.bottom.equalTo(self.imgView.mas_top);
        make.height.equalTo(@30);
        //make.bottom.equalTo(self.iv_news.mas_top);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.titleView.mas_bottom);
       // make.bottom.equalTo(self.infoView.mas_top);
        //make.height.equalTo(self.imgView.mas_width);
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(self);
        make.height.equalTo(@30);
        make.trailing.equalTo(self.iv_news.mas_leading);
        make.top.equalTo(self.imgView.mas_bottom);
    }];
    
    [self.iv_news mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.bottom.trailing.equalTo(self).offset(-5);
        make.leading.equalTo(self.titleView.mas_trailing).offset(5);
    }];
    
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorItem{
    
    
    HomeFloorsItem *floorItem1 = floorItem;
    NSArray <HomeItemContentItem *> *contents = floorItem.contents;
    HomeContentCellType type = floorItem.contentType;
    
    if (!contents.count) {return;} //防止为空
    
    //通用赋值
    HomeItemContentItem *content = contents[self.index];
    HomeItemArticleParamItem *article = content.articleParam;
    
    self.titleView.lb_title.text = content.title;
    self.infoView.lb_read.text = [NSString stringWithFormat:@"%ld",article.viewTimes];
    self.infoView.lb_comment.text = [NSString stringWithFormat:@"%ld",article.commentCount];
    
    if (article.isHot) {
        [self.infoView.lb_tag setHidden:NO];
        [self.infoView.iv_read mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoView.lb_tag.mas_trailing).offset(10);
        }];
        self.infoView.lb_tag.layer.borderColor = COLOR_PINK.CGColor;
        [self.infoView.lb_tag setTextColor:COLOR_PINK];
        [self.infoView.lb_tag setText:@" 热 "];
    } else if (article.isRecommend) {
        [self.infoView.lb_tag setHidden:NO];
        [self.infoView.iv_read mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoView.lb_tag.mas_trailing).offset(10);
        }];
        self.infoView.lb_tag.layer.borderColor = COLOR_BLUE.CGColor;
        [self.infoView.lb_tag setTextColor:COLOR_BLUE];
        [self.infoView.lb_tag setText:@" 推荐 "];
    } else {
        [self.infoView.lb_tag setHidden:YES];
        [self.infoView.iv_read mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoView.lb_tag.mas_trailing);
        }];
    }

    switch (type) {//按类型赋值
        case HomeContentCellTypeNews:{//无图 多组 字号17
            self.iv_news.hidden = YES;
            self.imgView.hidden = YES;
            self.titleView.lb_title.font = [UIFont systemFontOfSize:17];

            [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.leading.equalTo(self);
                
                make.trailing.equalTo(self).offset(-10);
                make.bottom.equalTo(self.infoView.mas_top);
               
            }];
        }
            break;
        case HomeContentCellTypeImageNews:{//右图 多组 字号17
            self.iv_news.hidden = NO;
            self.imgView.hidden = YES;
            self.titleView.lb_title.font = [UIFont systemFontOfSize:17];
            
            [self.iv_news sd_setImageWithURL:[NSURL URLWithString:content.imageUrl]];
            [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.leading.equalTo(self);
                make.trailing.equalTo(self.iv_news.mas_leading).offset(-5);
                make.bottom.equalTo(self.infoView.mas_top);
            }];
        }
            break;
            
        case HomeContentCellTypeThreeImageNews:{//三图 仅一组 字号15
            self.iv_news.hidden = YES;
            self.imgView.hidden = NO;
            
            self.titleView.lb_title.font = [UIFont systemFontOfSize:15];
            [self.imgView.iv_left sd_setImageWithURL:[NSURL URLWithString:contents[0].imageUrl]];
            [self.imgView.iv_mid sd_setImageWithURL:[NSURL URLWithString:contents[1].imageUrl]];
            [self.imgView.iv_right sd_setImageWithURL:[NSURL URLWithString:contents[2].imageUrl]];
        }
            break;
        default:
            break;
    }
    [super setFloorsItem:floorItem1];
}

#pragma mark-
#pragma mark lzy
-(TitleView *)titleView{
    
    if (!_titleView) {
        _titleView = [[TitleView alloc] init];
    }
    return _titleView;
}
-(InfoView *)infoView{
    
    if (!_infoView) {
        _infoView = [[InfoView alloc] init];
    }
    return _infoView;
}
-(ImgView *)imgView{
    
    if (!_imgView) {
        _imgView = [[ImgView alloc] init];
    }
    return _imgView;
}
-(UIImageView *)iv_news{
    
    if (!_iv_news) {
        _iv_news = [[UIImageView alloc] init];
        //_iv_news.userInteractionEnabled = YES;
    }
    return _iv_news;
}
@end
