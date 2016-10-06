//
//  ArticleUserCenterTableHeaderView.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterTableHeaderView.h"
#import "User.h"
#import "UIImageView+WebCache.h"

CGFloat const kArticleUserCenterTableHeaderViewRatio = 0.686;

@interface ArticleUserCenterTableHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *headerBGView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ArticleUserCenterTableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _headerBGView.layer.cornerRadius = CGRectGetWidth(_headerBGView.bounds)*0.5;
    _headerBGView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = CGRectGetWidth(_imageView.bounds)*0.5;
    _imageView.layer.masksToBounds = YES;
    
    _imageView.image = self.imagelaceHolder;
}

- (void)setData:(ArticleHomeUserInfoData *)data {
    _data = data;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:data.headUrl] placeholderImage:self.imagelaceHolder];
    _nameLabel.text = data.userName;
}

- (UIImage *)imagelaceHolder {
    NSString *placeHolderName = ([User shareUser].role.sex==RoleSexFemale)?@"userCenter_header_boy":@"userCenter_header_girl";
    return [UIImage imageNamed:placeHolderName];
}

@end
