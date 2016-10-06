//
//  HomeRecommendCell.m
//  KidsTC
//
//  Created by zhanping on 8/6/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "HomeRecommendCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "HomeModel.h"
#import "UILabel+Additions.h"
typedef enum : NSInteger {
    recNew=1, //1
    recHot,
    recSales,
    recDefault
} recType;

@interface HomeRecommendCell ()

@property (nonatomic, strong) UIImageView *iv_pic;
@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UILabel *lb_subTitle;
@property (nonatomic, strong) UILabel *lb_main;//为您推荐 主标题
@property (nonatomic, strong) UILabel *lb_price;//为您推荐 价格
@property (nonatomic, strong) UIImageView *iv_mark;//为您推荐 分类

@end

@implementation HomeRecommendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.contentView.backgroundColor = COLOR_BG_CEll;
    [self.contentView addSubview:self.iv_pic];
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.lb_subTitle];
    [self.contentView addSubview:self.lb_main];
    [self.contentView addSubview:self.lb_price];
    [self.contentView addSubview:self.iv_mark];
    self.contentView.clipsToBounds = YES;
    [self setConstraint];
}

-(void)setConstraint{
    
    [self.iv_mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(5);
        make.width.equalTo(@56);
        make.height.equalTo(@46);
    }];
    [self.iv_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.right.equalTo(self);
    }];
    [self.lb_main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iv_pic.mas_bottom).offset(12);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH*0.72));
    }];
    [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.lb_main);
        make.left.equalTo(self.lb_main.mas_right);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_main);
        make.top.equalTo(self.lb_main.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH*0.72));
    }];
    [self.lb_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.lb_title);
        make.left.equalTo(self.lb_title.mas_right);
    }];
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    HomeItemContentItem *contentItem = floorsItem.contents.firstObject;
    //处理内容
    [_iv_pic sd_setImageWithURL:[NSURL URLWithString:contentItem.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    
    //更新约束
    NSNumber *picH = [NSNumber numberWithFloat:floorsItem.ratio.floatValue * SCREEN_WIDTH];
    [self.iv_pic mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(picH);
    }];
    //更新内容
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    UIFont *font = [UIFont systemFontOfSize:17];
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName:font};
    NSMutableAttributedString *mutableTitleStr = [[NSMutableAttributedString alloc]initWithString:contentItem.title attributes:attributes];
    
    self.lb_main.attributedText = mutableTitleStr;
    self.lb_title.text = contentItem.subTitle;
    self.lb_price.text = [NSString stringWithFormat:@"￥%@",contentItem.price];
    recType type = (recType)contentItem.recType;
    self.iv_mark.hidden = type == recDefault;
    if (!self.iv_mark.hidden) {
        self.iv_mark.image = [UIImage imageNamed:[NSString stringWithFormat:@"rec0%zd", type]];
    }
    
    //进行中
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [[UIImage imageNamed:@"userCenter_browseHistory"] imageWithTintColor:[UIColor lightGrayColor]];
    attach.bounds = CGRectMake(0, -2, 14, 14);
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *soldStr = [[NSMutableAttributedString alloc] initWithString:@"进行中"];
    [soldStr insertAttributedString:imgStr atIndex:0];
    
    self.lb_subTitle.attributedText = soldStr;
    
    return [super setFloorsItem:floorItem1];
}

-(UIImageView *)iv_pic{
    if (!_iv_pic) {
        _iv_pic = [[UIImageView alloc] init];
        _iv_pic.clipsToBounds = YES;
        _iv_pic.contentMode = UIViewContentModeScaleAspectFill;
        [_iv_pic setUserInteractionEnabled:YES];
    }
    return _iv_pic;
}

-(UILabel *)lb_title{
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] initWithTitle:@"" FontSize:13 FontColor:[UIColor lightGrayColor]];
        _lb_title.numberOfLines = 2;
        //_lb_title.backgroundColor = [UIColor blueColor];
    }
    return _lb_title;
}
-(UILabel *)lb_subTitle{
    if (!_lb_subTitle) {
        _lb_subTitle = [[UILabel alloc] initWithTitle:@"" FontSize:13 FontColor:[UIColor lightGrayColor]];
        _lb_subTitle.textAlignment = NSTextAlignmentRight;
        _lb_subTitle.numberOfLines = 0;
        //  _lb_subTitle.backgroundColor = [UIColor redColor];
    }
    return _lb_subTitle;
}

-(UILabel *)lb_main{
    if (!_lb_main) {
        _lb_main = [[UILabel alloc] initWithTitle:@"" FontSize:17 FontColor:[UIColor darkGrayColor]];
        _lb_main.numberOfLines = 2;
        //_lb_main.backgroundColor = [UIColor redColor];
    }
    return _lb_main;
}

-(UILabel *)lb_price{
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] initWithTitle:@"" FontSize:17 FontColor:COLOR_PINK];
        _lb_price.textAlignment = NSTextAlignmentRight;
        //_lb_price.backgroundColor = [UIColor blueColor];
    }
    return _lb_price;
}
- (UIImageView *)iv_mark{
    if (!_iv_mark) {
        _iv_mark = [[UIImageView alloc] init];
        //_iv_mark.contentMode = UIViewContentModeScaleAspectFit;
        [_iv_mark sizeToFit];
    }
    return _iv_mark;
}

@end
