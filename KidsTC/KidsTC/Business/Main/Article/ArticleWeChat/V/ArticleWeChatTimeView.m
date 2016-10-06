//
//  ArticleWeChatTimeView.m
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleWeChatTimeView.h"

@implementation ArticleWeChatTimeView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.timeLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.timeLabel.layer.cornerRadius = 2;
    self.timeLabel.layer.masksToBounds = YES;
}

@end
