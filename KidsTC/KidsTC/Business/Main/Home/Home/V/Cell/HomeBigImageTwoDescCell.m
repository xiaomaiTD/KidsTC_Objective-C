//
//  HomeBigImageTwoDescCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeBigImageTwoDescCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "UILabel+Additions.h"
#import "Macro.h"
#import "HomeModel.h"

@interface HomeBigImageTwoDescCell ()

@property (nonatomic, strong) UIImageView *iv_pic;
@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UILabel *lb_subTitle;
@property (nonatomic, strong) TextSegueModel *textSegue;

@end
@implementation HomeBigImageTwoDescCell

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
   
    [self setConstraint];
}

-(void)setConstraint{
    
    [self.iv_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(5, 0, 0, 0));
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 10, 0));
        make.top.equalTo(self.iv_pic.mas_bottom).offset(10).priorityLow();
        make.width.equalTo(self).multipliedBy(.7);
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
    [_iv_pic sd_setImageWithURL:[NSURL URLWithString:contentItem.imageUrl] ];
    //为首页cell
    
        NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                  contentItem.color, @"color",
                                  contentItem.linkKey, @"linkKey",
                                  [NSNumber numberWithInteger:contentItem.linkType], @"linkType", contentItem.params, @"params",  nil];
        _textSegue = [[TextSegueModel alloc] initWithLinkParam:paramDic promotionWords:contentItem.title];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:contentItem.title];
        NSDictionary *fontAttribute = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:13], NSFontAttributeName,
                                       [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
        [labelString setAttributes:fontAttribute range:NSMakeRange(0, [labelString length])];
        
        if (_textSegue) {
            NSDictionary *linkAttribute = [NSDictionary dictionaryWithObjectsAndKeys:
                                           _textSegue.linkColor, NSForegroundColorAttributeName, nil];
            for (NSString *rangeString in _textSegue.linkRangeStrings) {
                NSRange range = NSRangeFromString(rangeString);
                [labelString addAttributes:linkAttribute range:range];
            }
        }
        [_lb_title setAttributedText:labelString];
        _lb_subTitle.attributedText = nil;
        [_lb_subTitle setText:contentItem.subTitle];
        CGFloat pic = floorsItem.rowHeight - 20 - [_lb_title sizeToFitWithMaximumNumberOfLines:1];
        NSNumber *picH = [NSNumber numberWithFloat:pic];
        //处理约束
        [self.iv_pic mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(picH);
        }];
    
    return [super setFloorsItem:floorItem1];
}

#pragma mark-
#pragma mark lzy
-(UIImageView *)iv_pic{
    if (!_iv_pic) {
        _iv_pic = [[UIImageView alloc] init];
        [_iv_pic setUserInteractionEnabled:YES];
    }
    return _iv_pic;
}

-(UILabel *)lb_title{
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] initWithTitle:@"" FontSize:13 FontColor:[UIColor lightGrayColor]];
        _lb_title.numberOfLines = 1;
        //_lb_title.backgroundColor = [UIColor blueColor];
    }
    return _lb_title;
}
-(UILabel *)lb_subTitle{
    if (!_lb_subTitle) {
        _lb_subTitle = [[UILabel alloc] initWithTitle:@"" FontSize:13 FontColor:[UIColor lightGrayColor]];
        _lb_subTitle.textAlignment = NSTextAlignmentRight;
      //  _lb_subTitle.backgroundColor = [UIColor redColor];
    }
    return _lb_subTitle;
}
@end
