//
//  ArticleCommentHeader.m
//  KidsTC
//
//  Created by zhanping on 4/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCommentHeader.h"

@interface ArticleCommentHeader ()
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *dataL;
@end

@implementation ArticleCommentHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
        titleL.numberOfLines = 2;
        titleL.font = [UIFont boldSystemFontOfSize:25];
        titleL.textColor = [UIColor darkTextColor];
        [self addSubview:titleL];
        self.titleL = titleL;
        
        UILabel *dataL = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-10, 20)];
        dataL.textColor = [UIColor lightGrayColor];
        dataL.font = [UIFont systemFontOfSize:13];
        [self addSubview:dataL];
        self.dataL = dataL;
        
    }
    return self;
}

-(void)setModel:(ArticleCommentResponseModel *)model{
    _model = model;
    self.titleL.text = _model.data.articleInfo.title;
    self.dataL.text = [NSString stringWithFormat:@"%@ %@ 评论数:%zd",_model.data.articleInfo.authorName,_model.data.articleInfo.time,_model.count];
}




@end
