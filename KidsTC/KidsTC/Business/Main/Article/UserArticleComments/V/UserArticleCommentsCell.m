//
//  UserArticleCommentsCell.m
//  KidsTC
//
//  Created by zhanping on 4/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "UserArticleCommentsCell.h"
#import "UserArticleCommentsLayout.h"
#import "UIImageView+WebCache.h"
#define LineHight (1/[[UIScreen mainScreen] scale])
#define accessImageViewSize 13
#define imageViewTag 100
@implementation ContentView

-(UIScrollView *)sv{
    if (!_sv) {
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(UserArticleCommentsCellMargin, 0, SVWidth, SVHight)];
        sv.showsHorizontalScrollIndicator = NO;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSVAction)];
        [sv addGestureRecognizer:tapGR];
        [self addSubview:sv];
        _sv = sv;
    }
    return _sv;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.layer.cornerRadius = 8;
        //self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        self.userInteractionEnabled = YES;
        
        UIImageView *BGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- 2*UserArticleCommentsCellMargin, 1)];
        BGImageView.image = [UIImage imageNamed:@"bg_eva_content"];
        BGImageView.userInteractionEnabled = YES;
        [self addSubview:BGImageView];
        self.BGImageView = BGImageView;
        
        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(UserArticleCommentsCellMargin, UserArticleCommentsCellMargin, ContentLabelMaxWith, 20)];
        [self addSubview:contentL];
        contentL.numberOfLines = 0;
        contentL.font = ContentLabelTextFont;
        contentL.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        
        self.contentL = contentL;
        
        UIButton *priseBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-3*UserArticleCommentsCellMargin-PriseBtnSize, UserArticleCommentsCellMargin*0.5+2, PriseBtnSize, PriseBtnSize)];
        //[priseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 20)];
        [self addSubview:priseBtn];
        [priseBtn.titleLabel setTextColor:[UIColor darkGrayColor]];
        [priseBtn addTarget:self action:@selector(priseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.priseBtn = priseBtn;
        
        UILabel *priseCountL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-3*UserArticleCommentsCellMargin-PriseBtnSize, UserArticleCommentsCellMargin, PriseBtnSize, PriseBtnSize)];
        priseCountL.font = [UIFont systemFontOfSize:15];
        [priseCountL setTextColor:[UIColor lightGrayColor]];
        [self addSubview:priseCountL];
        self.priseCountL = priseCountL;
        
        
    }
    return self;
}

- (void)priseBtnAction{
    if (self.priseBtnActionBlock) {
        self.priseBtnActionBlock(self.item.commentSysNo);
    }
}

-(void)tapSVAction{
    if (self.SVTapActionBlock) {
        self.SVTapActionBlock();
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
@end


@implementation UserArticleCommentsCell
static NSMutableSet *_imageViews;
+(NSMutableSet *)shareImageViews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageViews = [NSMutableSet new];
    });
    return _imageViews;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = self.backgroundColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1];
        
        ContentView *contentLabelView = [[ContentView alloc]initWithFrame:CGRectMake(UserArticleCommentsCellMargin, UserArticleCommentsCellMargin, SCREEN_WIDTH - 2*UserArticleCommentsCellMargin, 1)];
        [self.contentView addSubview:contentLabelView];
        self.contentLabelView = contentLabelView;
        
        UILabel *articleLabel = [[UILabel alloc]initWithFrame:CGRectMake(UserArticleCommentsCellMargin, 0, SCREEN_WIDTH-2*UserArticleCommentsCellMargin-accessImageViewSize, ArticleLabelHight)];
        [self.contentView addSubview:articleLabel];
        articleLabel.font = ContentLabelTextFont;
        articleLabel.textColor = [UIColor colorWithRed:0.502  green:0.502  blue:0.502 alpha:1];
        self.articleLabel = articleLabel;
        
        
        UIImageView *accessImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-UserArticleCommentsCellMargin-accessImageViewSize, 0, accessImageViewSize, accessImageViewSize)];
        accessImageView.image = [UIImage imageNamed:@"arrow_r"];
        [self.contentView addSubview:accessImageView];
        self.accessImageView = accessImageView;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:0.898  green:0.898  blue:0.898 alpha:1];
        line.frame = CGRectMake(UserArticleCommentsCellMargin, 0, SCREEN_WIDTH-2*UserArticleCommentsCellMargin, LineHight);
        [self.contentView addSubview:line];
        self.line = line;
    }
    return self;
}



- (void)setLayout:(UserArticleCommentsLayout *)layout{
    _layout = layout;
    
    
    
    CGRect contentLabelViewFrame = self.contentLabelView.frame;
    contentLabelViewFrame.size.height = _layout.contentLabelViewHight;
    self.contentLabelView.frame = contentLabelViewFrame;
    self.contentLabelView.BGImageView.frame = self.contentLabelView.bounds;
    
    CGRect contentLabelFrame = self.contentLabelView.contentL.frame;
    contentLabelFrame.size.height = layout.contentLabelHight;
    self.contentLabelView.contentL.frame = contentLabelFrame;
    
    CGRect SVFrame = self.contentLabelView.sv.frame;
    SVFrame.origin.y = CGRectGetMaxY(self.contentLabelView.contentL.frame) + UserArticleCommentsCellMargin;
    self.contentLabelView.sv.frame = SVFrame;
    
    CGRect articleLabelFrame = self.articleLabel.frame;
    articleLabelFrame.origin.y = CGRectGetMaxY(self.contentLabelView.frame) + UserArticleCommentsCellMargin;
    self.articleLabel.frame = articleLabelFrame;
    
    CGRect accessImageViewFrame = self.accessImageView.frame;
    accessImageViewFrame.origin.y = articleLabelFrame.origin.y + (CGRectGetHeight(self.articleLabel.frame)-accessImageViewSize)*0.5;
    self.accessImageView.frame = accessImageViewFrame;
    
    //    [CATransaction begin];
    //    [CATransaction setDisableActions:YES];
    CGRect lineFrame = _line.frame;
    lineFrame.origin.y = _layout.hight-LineHight;
    self.line.frame = lineFrame;
    //    [CATransaction commit];
    
    
    
    EvaListItem *item = _layout.item;
    self.contentLabelView.item = item;
    
    self.contentLabelView.contentL.attributedText = _layout.attributedContentString;
    
    self.contentLabelView.priseCountL.text = [NSString stringWithFormat:@"%ld",item.praiseCount];
    [self.contentLabelView.priseCountL sizeToFit];
    CGRect priseCountLFrame = self.contentLabelView.priseCountL.frame;
    priseCountLFrame.origin.x = CGRectGetWidth(self.contentLabelView.frame) - PriseBtnSize-UserArticleCommentsCellMargin -2 -priseCountLFrame.size.width;
    self.contentLabelView.priseCountL.frame = priseCountLFrame;
    
    NSString *imageName = item.isPraised?@"zan_ed":@"zan";
    [self.contentLabelView.priseBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSMutableSet *imageViews = [UserArticleCommentsCell shareImageViews];
    for (UIView *view in self.contentLabelView.sv.subviews) {
        if ([view isMemberOfClass:[UIImageView class]] && view.tag == imageViewTag) {
            [imageViews addObject:view];
            [view removeFromSuperview];
        }
    }
    if (item.imgUrls.count>0) {
        self.contentLabelView.sv.hidden = NO;
        NSInteger count = item.imgUrls.count;
        for (int i = 0; i<count; i++) {
            UIImageView *imageView = [self getImageView];
            NSString *imageUrlStr = [item.imgUrls[i] lastObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
            imageView.frame = CGRectMake((SVHight+UserArticleCommentsCellMargin)*i, 0, SVHight, SVHight);
            [self.contentLabelView.sv addSubview:imageView];
        }
        [self.contentLabelView.sv setContentSize:CGSizeMake((SVHight+UserArticleCommentsCellMargin)*count-UserArticleCommentsCellMargin, SVHight)];
    }else{
        self.contentLabelView.sv.hidden = YES;
    }
    
    self.articleLabel.text = [NSString stringWithFormat:@"[原文]%@",item.articleTitle];
    
}


-(UIImageView *)getImageView {
    NSMutableSet *imageViews = [UserArticleCommentsCell shareImageViews];
    UIImageView *imageView = nil;
    if (imageViews.count>0) {
        imageView  = [imageViews anyObject];
        [imageViews removeObject:imageView];
    }else{
        imageView = [[UIImageView alloc]init];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = YES;
        imageView.tag = imageViewTag;
        NSLog(@"UIImageView alloc----");
    }
    return imageView;
}
@end

