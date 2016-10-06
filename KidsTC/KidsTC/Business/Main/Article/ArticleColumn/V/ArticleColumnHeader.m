//
//  ArticleColumnHeader.m
//  KidsTC
//
//  Created by 詹平 on 16/9/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleColumnHeader.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "UIButton+Category.h"

@interface ArticleColumnHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *statesBtn;
@end

@implementation ArticleColumnHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    CALayer *statesBtnLayer = self.statesBtn.layer;
    statesBtnLayer.cornerRadius = 15;
    statesBtnLayer.masksToBounds = YES;
    statesBtnLayer.borderColor = [UIColor whiteColor].CGColor;
    statesBtnLayer.borderWidth = 1;
    
    [self.statesBtn setTitle:@"加关注" forState:UIControlStateNormal];
    [self.statesBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.statesBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.statesBtn setBackgroundColor:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5] forState:UIControlStateSelected];
}

- (void)setInfo:(ArticleColumnInfo *)info {
    _info = info;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:info.bannerImg] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.countLabel.text = [NSString stringWithFormat:@"话题数:%zd",info.count];
    self.statesBtn.selected = info.isLiked;
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*info.bannerPicRatio);
}

- (IBAction)action:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(articleColumnHeaderAction:)]) {
        [self.delegate articleColumnHeaderAction:self];
    }
}


@end
