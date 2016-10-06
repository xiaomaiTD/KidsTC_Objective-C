//
//  MessageCenterCell.m
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MessageCenterCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@implementation MCArticelView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1];
        
        CGFloat labelWidth = SCREEN_WIDTH-5*MCCellMarginInsets - MCCImageViewSize;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MCCellMarginInsets, MCCellMarginInsets, labelWidth, MCCImageViewSize)];
        [self addSubview:label];
        label.textColor = [UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1];
        label.numberOfLines = 0;
        self.articleLabel = label;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+MCCellMarginInsets, MCCellMarginInsets, MCCImageViewSize, MCCImageViewSize)];
        [self addSubview:imageView];
        //imageView.backgroundColor = [UIColor redColor];
        imageView.clipsToBounds = YES;
        self.articleImageView = imageView;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction)];
        [self addGestureRecognizer:tapGR];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)tapGRAction{
    if (self.articleTapAction) {
        self.articleTapAction();
    }
}

@end



@implementation MessageCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MCCellMarginInsets, MCCellMarginInsets*2, MCCHeadImageViewSize, MCCHeadImageViewSize)];
        [self.contentView addSubview:headImageView];
        headImageView.userInteractionEnabled = YES;
        headImageView.layer.cornerRadius = MCCHeadImageViewSize*0.5;
        headImageView.layer.masksToBounds = YES;
        self.headImageView = headImageView;
        UITapGestureRecognizer *headImageViewTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageViewTapGRAction)];
        [self.headImageView addGestureRecognizer:headImageViewTapGR];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+MCCellMarginInsets, MCCellMarginInsets*2 + (MCCHeadImageViewSize-MCCNameLabelHight)*0.5, 1, MCCNameLabelHight)];
        nameLabel.userInteractionEnabled = YES;
        nameLabel.textColor = [UIColor colorWithRed:0.403 green:0.846 blue:0.956 alpha:1];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        UITapGestureRecognizer *nameLabelTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nameLabelTapGRAction)];
        [self.nameLabel addGestureRecognizer:nameLabelTapGR];
        
        TTTAttributedLabel *contentLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(MCCellMarginInsets, CGRectGetMaxY(headImageView.frame)+MCCellMarginInsets, SCREEN_WIDTH - 2*MCCellMarginInsets, 1)];
        contentLabel.userInteractionEnabled = YES;
        //contentLabel.backgroundColor = [UIColor lightTextColor];
        contentLabel.numberOfLines = 0;
        contentLabel.delegate = self;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        MCArticelView *articleView = [[MCArticelView alloc]initWithFrame:CGRectMake(MCCellMarginInsets, 0, SCREEN_WIDTH-2*MCCellMarginInsets, MCCellMarginInsets*2+MCCImageViewSize)];
        [self.contentView addSubview:articleView];
        self.articleView = articleView;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MCCLineHight)];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1];
        self.line = line;
    }
    return self;
}
- (void)headImageViewTapGRAction{
    if (self.meTapAction) {
        self.meTapAction();
    }
}

- (void)nameLabelTapGRAction{
    if (self.meTapAction) {
        self.meTapAction();
    }
}

-(void)setLayout:(MessageCenterLayout *)layout{
    _layout = layout;
    EvaListItem *item = _layout.item;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:item.userHeadImg] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
    self.nameLabel.text = item.userName;
    
    self.contentLabel.attributedText = _layout.contentTotalAttributeStr;
    
    self.articleView.articleLabel.text = item.articleTitle;
    
    [self.articleView.articleImageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
    [self.nameLabel sizeToFit];
    
    CGRect contentLabelFrame = self.contentLabel.frame;
    contentLabelFrame.size.height = _layout.contentTotalAttributeStrHight;
    self.contentLabel.frame = contentLabelFrame;
    
    CGRect articleViewFrame = self.articleView.frame;
    articleViewFrame.origin.y = CGRectGetMaxY(self.contentLabel.frame) + MCCellMarginInsets;
    self.articleView.frame = articleViewFrame;
    
    CGRect lineFrame = self.line.frame;
    lineFrame.origin.y = _layout.hight - MCCLineHight;
    self.line.frame = lineFrame;
    
    
    [self.contentLabel setLinkAttributes:nil];
    if (item.reply) {
        [self.contentLabel addLinkToAddress:@{@"":@""} withRange:_layout.actionRange];
    }
    
}

#pragma mark TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    
    if (self.otherUserTapAction) {
        self.otherUserTapAction();
    }
    
}
@end













