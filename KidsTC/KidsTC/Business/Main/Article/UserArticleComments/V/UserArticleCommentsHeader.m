//
//  UserArticleCommentsHeader.m
//  KidsTC
//
//  Created by zhanping on 4/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "UserArticleCommentsHeader.h"
#define HeadImageViewSize 80
#define HeadImageBGViewSize 84

@implementation UserArticleCommentsHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor redColor];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userCommentBG"]];
        bgImageView.clipsToBounds = YES;
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        CGFloat headImageBGViewX = (SCREEN_WIDTH - HeadImageBGViewSize)*0.5;
        UIView *headImageBGView = [[UIView alloc]initWithFrame:CGRectMake(headImageBGViewX, 78, HeadImageBGViewSize, HeadImageBGViewSize)];
        [self addSubview:headImageBGView];
        headImageBGView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        headImageBGView.layer.cornerRadius = CGRectGetWidth(headImageBGView.frame)*0.5;
        headImageBGView.layer.masksToBounds = YES;
        
        CGFloat headImageViewX = (SCREEN_WIDTH - HeadImageViewSize)*0.5;
        UIImageView *headImagView = [[UIImageView alloc] initWithFrame:CGRectMake(headImageViewX, 80, HeadImageViewSize, HeadImageViewSize)];
        [self addSubview:headImagView];
        headImagView.layer.cornerRadius = CGRectGetWidth(headImagView.frame)*0.5;
        headImagView.layer.masksToBounds = YES;
        self.headImageView = headImagView;
        
        UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HeadImageViewSize+10, HeadImageViewSize+10)];
        BGView.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.7];
        BGView.layer.cornerRadius = CGRectGetWidth(BGView.frame)*0.5;
        BGView.layer.masksToBounds = YES;
        [self insertSubview:BGView atIndex:0];
        BGView.center = headImagView.center;
        
        UILabel *userInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+10, SCREEN_WIDTH, 40)];
        userInfoLabel.textColor = [UIColor whiteColor];
        userInfoLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:userInfoLabel];
        userInfoLabel.textAlignment = NSTextAlignmentCenter;
        self.userInfoLabel = userInfoLabel;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;
}

@end
