//
//  ArticleCommentCell.m
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCommentCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

#define imageViewTag 100
@implementation ArticleCommentCell

static NSMutableSet *_imageViews;
+(NSMutableSet *)shareImageViews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageViews = [NSMutableSet new];
    });
    return _imageViews;
}

-(UIButton *)styleBtn{
    if (!_styleBtn) {
        UIColor *color = COLOR_PINK;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ContentLabelX, 0 + ArticleCommentCellMarginInsets, StyleBtnWidth, StyleBtnHight)];
        btn.layer.cornerRadius = CGRectGetHeight(btn.frame)*0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = LINE_H;
        btn.layer.borderColor =  color.CGColor;
        [btn addTarget:self action:@selector(changeStyleAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _styleBtn = btn;
    }
    return _styleBtn;
}

-(UIScrollView *)sv{
    if (!_sv) {
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(ContentLabelX, 0, ContentLabelWidht, SVHight)];
        sv.showsHorizontalScrollIndicator = NO;
        //sv.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSVAction)];
        [sv addGestureRecognizer:tapGR];
        [self.contentView addSubview:sv];
        _sv = sv;
    }
    return _sv;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ArticleCommentCellMarginInsets, ArticleCommentCellMarginInsets, HeadImageViewSize, HeadImageViewSize)];
        headImageView.clipsToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        headImageView.layer.cornerRadius = HeadImageViewSize*0.5;
        headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:headImageView];
        self.headImgaView = headImageView;
        UITapGestureRecognizer *tapHeadImageViewGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadAction:)];
        [self.headImgaView addGestureRecognizer:tapHeadImageViewGR];
        
        CGFloat namesLabelWidht = ContentLabelWidht-PraiseCountLabelWidht - PraiseCountLabelMargin*2-NamesLabelHight;
        UILabel *namesLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContentLabelX, ArticleCommentCellMarginInsets, namesLabelWidht, NamesLabelHight)];
        namesLabel.userInteractionEnabled = YES;
        
        
        namesLabel.textColor = COLOR_BLUE;
        namesLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:namesLabel];
        self.namesLabel = namesLabel;
        UITapGestureRecognizer *tapNamesLabelGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadAction:)];
        [self.namesLabel addGestureRecognizer:tapNamesLabelGR];
        
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.namesLabel.frame)+PraiseCountLabelMargin, ArticleCommentCellMarginInsets, PraiseCountLabelWidht, NamesLabelHight)];
        countLabel.textColor = [UIColor colorWithRed:0.784  green:0.788  blue:0.792 alpha:1];
        countLabel.textAlignment = NSTextAlignmentRight;
        countLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:countLabel];
        self.priseCountLabel = countLabel;
        
        UIButton *priseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priseCountLabel.frame)+PraiseCountLabelMargin, ArticleCommentCellMarginInsets, 18, 18)];
        [priseBtn addTarget:self action:@selector(priseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:priseBtn];
        self.priseBtn = priseBtn;
        
        TTTAttributedLabel *contentLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(ContentLabelX, NamesLabelHight+ArticleCommentCellMarginInsets*1.5, ContentLabelWidht, 1)];
        contentLabel.numberOfLines = 0;
        //contentLabel.backgroundColor = [UIColor redColor];
        contentLabel.delegate = self;
        [self.contentLabel setLinkAttributes:nil];
        contentLabel.font = ContentLabelFont;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:0.898  green:0.898  blue:0.898 alpha:1];
        line.frame = CGRectMake(ArticleCommentCellMarginInsets, 0, SCREEN_WIDTH-2*ArticleCommentCellMarginInsets, LINE_H);
        [self.contentView addSubview:line];
        self.line = line;
    }
    return self;
}

-(void)setLayout:(ArticleCommentLayout *)layout{
    _layout = layout;
    EvaListItem *item = _layout.item;
    
    if (_layout.isAboutMe) {
        self.namesLabel.hidden = YES;
        self.priseCountLabel.hidden = YES;
        self.priseBtn.hidden = YES;
    }else{
        self.namesLabel.hidden = NO;
        self.priseCountLabel.hidden = NO;
        self.priseBtn.hidden = NO;
    }
    
    self.styleBtn.hidden = !_layout.isCanShowStyleBtn;
    CGRect contentLabelFrame = self.contentLabel.frame;
    CGRect styleBtnFrame = self.styleBtn.frame;
    CGRect SVFrame = self.sv.frame;
    NSString *btnTitle = @"全文";
    if (_layout.isStyleOpen) {//打开的
        contentLabelFrame.size.height = _layout.contentLabelOpenHight;
        styleBtnFrame.origin.y = _layout.styleBtnOpenY;
        SVFrame.origin.y = _layout.SVOpenY;
        btnTitle = @"收起";
    }else{//正常的
        contentLabelFrame.size.height = _layout.contentLabelNormalHight;
        styleBtnFrame.origin.y = _layout.styleBtnNormalY;
        SVFrame.origin.y = _layout.SVNormalY;
        
    }
    contentLabelFrame.origin.y = _layout.contentLabelY;
    self.contentLabel.frame = contentLabelFrame;
    self.styleBtn.frame = styleBtnFrame;
    self.sv.frame = SVFrame;
    [self.styleBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    CGRect lineFrame = _line.frame;
    if (_layout.isStyleOpen) {
        lineFrame.origin.y = _layout.openHight-LINE_H;
    }else{
        lineFrame.origin.y = _layout.normalHight-LINE_H;
    }
    self.line.frame = lineFrame;
    
    [self.headImgaView sd_setImageWithURL:[NSURL URLWithString:item.userHeadImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    
    NSMutableAttributedString *userNameAttributeStr = [[NSMutableAttributedString alloc]init];
    NSDictionary *userNameAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                         NSForegroundColorAttributeName:[UIColor colorWithRed:0.403 green:0.846 blue:0.956 alpha:1]};
    NSAttributedString *userNameStr = [[NSAttributedString alloc]initWithString:item.userName attributes:userNameAttributes];
    [userNameAttributeStr appendAttributedString:userNameStr];
    if (item.isReplyed) {
        NSDictionary *replyedAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                             NSForegroundColorAttributeName:[UIColor colorWithRed:0.992  green:0.616  blue:0.620 alpha:1]};
        NSAttributedString *replyedStr = [[NSAttributedString alloc]initWithString:@" 已回复" attributes:replyedAttributes];
        [userNameAttributeStr appendAttributedString:replyedStr];
    }
    self.namesLabel.attributedText = userNameAttributeStr;
    [self.namesLabel sizeToFit];
    self.priseCountLabel.text = [NSString stringWithFormat:@"%zd",item.praiseCount];
    
    self.contentLabel.attributedText = _layout.content;
    
    [self.contentLabel setLinkAttributes:nil];
    if (item.reply) {
        [self.contentLabel addLinkToAddress:@{@"":@""} withRange:_layout.actionRange];
    }
    
    NSString *imageName = item.isPraised?@"zan_ed":@"zan";
    [self.priseBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSMutableSet *imageViews = [ArticleCommentCell shareImageViews];
    for (UIView *view in self.sv.subviews) {
        if ([view isMemberOfClass:[UIImageView class]] && view.tag == imageViewTag) {
            [imageViews addObject:view];
            [view removeFromSuperview];
        }
    }
    if (_layout.isHaveImageView) {
        [self.sv setHidden:NO];
    
        NSInteger count = item.imgUrls.count;
        for (int i = 0; i<count; i++) {
            UIImageView *imageView = [self getImageView];
            NSString *imageUrlStr = [item.imgUrls[i] lastObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:PLACEHOLDERIMAGE_SMALL];
            imageView.frame = CGRectMake((SVHight+ArticleCommentCellMarginInsets)*i, 0, SVHight, SVHight);
            [self.sv addSubview:imageView];
        }
        [self.sv setContentSize:CGSizeMake((SVHight+ArticleCommentCellMarginInsets)*count-ArticleCommentCellMarginInsets, SVHight)];
    }else{
        [self.sv setHidden:YES];
    }
}

-(UIImageView *)getImageView {
    NSMutableSet *imageViews = [ArticleCommentCell shareImageViews];
    UIImageView *imageView = nil;
    if (imageViews.count>0) {
        imageView  = [imageViews anyObject];
        [imageViews removeObject:imageView];
    }else{
        imageView = [[UIImageView alloc]init];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 8;
        imageView.layer.masksToBounds = YES;
        imageView.tag = imageViewTag;
    }
    return imageView;
}

//点击评论用户头像或名称
- (void)tapHeadAction:(UITapGestureRecognizer *)tapGR {

    if (self.headActionBlock) {
        self.headActionBlock(_layout.item.userId);
    }
}

//点赞
- (void)priseAction:(UIButton *)btn {
    if (self.priseActionBlock) self.priseActionBlock(_layout.item.commentSysNo);
}

//展开或收起
- (void)changeStyleAction:(UIButton *)btn {
    if (self.changeStyleActionBlock) self.changeStyleActionBlock();
}

-(void)tapSVAction{
    if (self.SVTapActionBlock) {
        self.SVTapActionBlock();
    }
}

#pragma mark TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {

    if (self.nameActionBlock) {
        self.nameActionBlock(_layout.item.reply.userId);
    }
    
}

@end
