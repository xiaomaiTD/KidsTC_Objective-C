//
//  FDCommentCell.m
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDCommentCell.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface FDImageContainer ()
@property (nonatomic, strong) NSArray<UIImageView *> *imageViews;
@property (nonatomic, strong) NSArray<NSArray *> *imageUrlStrings;
@end

@implementation FDImageContainer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = FDCommentCellMargin;
        NSMutableArray *imageViews = [NSMutableArray array];
        for (NSUInteger i = 0; i < FDCommentCellMaxCount; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
            [imageViews addObject:imageView];
            NSInteger lineCount = i/FDCommentCellLineMaxItemsCount;//行数，从第0行开始
            NSUInteger rowCout = i%FDCommentCellLineMaxItemsCount;//列数，从第0列开始
            [imageView makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(FDCommentCellImageViewSize, FDCommentCellImageViewSize));
                make.top.equalTo(lineCount*(FDCommentCellImageViewSize+margin));
                make.left.equalTo(margin + rowCout*(FDCommentCellImageViewSize+margin));
            }];
            imageView.layer.cornerRadius = 8;
            imageView.layer.masksToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            imageView.layer.borderWidth = LINE_H;
        }
        self.imageViews = imageViews;
    }
    return self;
}

- (void)setImageUrlStrings:(NSArray<NSArray *> *)imageUrlStrings{
    _imageUrlStrings = imageUrlStrings;
    
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = self.imageViews[idx];
        if (idx<imageUrlStrings.count) {
            NSString *imageUrlString =  imageUrlStrings[idx][0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:PLACEHOLDERIMAGE_SMALL];
            imageView.hidden = NO;
        }else{
            imageView.hidden = YES;
        }
    }];
}


@end

@interface FDCommentButton : UIButton

@end

@implementation FDCommentButton

@end


@interface FDCommentCell ()
@property (nonatomic, weak) UIImageView *userHeaderImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) FDCommentButton *likeBtn;
@property (nonatomic, weak) FDCommentButton *commentBtn;
@property (nonatomic, weak) FDImageContainer *imageContainer;

@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@end

@implementation FDCommentCell

-(void)awakeFromNib{
    [super awakeFromNib];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
    self.selectedBackgroundView = bgView;
    
    UIImageView *userHeaderImageView = [[UIImageView alloc]init];
    [self addSubview:userHeaderImageView];
    userHeaderImageView.layer.cornerRadius = UserHeaderImageViewSize*0.5;
    userHeaderImageView.layer.masksToBounds = YES;
    
    UILabel *userNameLabel = [[UILabel alloc]init];
    userNameLabel.font = [UIFont systemFontOfSize:15];
    userNameLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:userNameLabel];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [self addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor darkGrayColor];
    contentLabel.font = FDCommentCellContentFont;
    
    FDImageContainer *imageContainer = [[FDImageContainer alloc]init];
    [self addSubview:imageContainer];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    [self addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = [UIColor lightGrayColor];
    
    FDCommentButton *likeBtn = [self btnWithImageName:@"comment_like_n"];
    [self addSubview:likeBtn];
    
    FDCommentButton *commentBtn = [self btnWithImageName:@"comment_comment_n"];
    [self addSubview:commentBtn];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    
    
    self.userHeaderImageView = userHeaderImageView;
    self.userNameLabel = userNameLabel;
    self.contentLabel = contentLabel;
    self.timeLabel = timeLabel;
    self.likeBtn = likeBtn;
    self.commentBtn = commentBtn;
    self.imageContainer = imageContainer;
    
    CGFloat margin = FDCommentCellMargin;
    
    [userHeaderImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(margin);
        make.left.equalTo(margin);
        make.size.equalTo(CGSizeMake(UserHeaderImageViewSize, UserHeaderImageViewSize));
    }];
    
    [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userHeaderImageView.right).offset(margin);
        make.centerY.equalTo(userHeaderImageView);
    }];
    
    [contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userHeaderImageView.bottom).offset(margin);
        make.left.equalTo(margin);
        make.width.equalTo(SCREEN_WIDTH-2*margin);
    }];
    
    [commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-margin);
        make.top.equalTo(contentLabel.bottom).offset(margin);
        make.height.equalTo(FDCommentCellBtnHight);
    }];
    
    [likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(commentBtn.left);
        make.top.equalTo(commentBtn.top);
        make.height.equalTo(FDCommentCellBtnHight);
    }];
    
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commentBtn);
        make.left.equalTo(margin);
    }];
    
    CGFloat lineW = LINE_H;
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, lineW));
        make.left.equalTo(0);
        make.bottom.equalTo(-lineW);
    }];
    
}



- (FDCommentButton *)btnWithImageName:(NSString *)imageName{
    FDCommentButton *btn = [[FDCommentButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    return btn;
}

- (void)setLayout:(FDCommentLayout *)layout{
    _layout = layout;
    FDCommentListItem *commentListItem = layout.commentListItem;
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:commentListItem.userImgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.userNameLabel.text = commentListItem.userName;
    self.contentLabel.text = commentListItem.content;
    self.timeLabel.text = commentListItem.time;
    [self.starsView setStarNumber:commentListItem.score.OverallScore];
    
    NSString *imageName = @"comment_like_n";
    if (commentListItem.isPraise) {
        imageName = @"flashDetail_like";
    }
    [self.likeBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.likeBtn setTitle:[NSString stringWithFormat:@" (%zd) ",commentListItem.praiseCount] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@" (%zd) ",commentListItem.replyCount] forState:UIControlStateNormal];
    
    NSInteger count = commentListItem.imageUrl.count;
    if (count==0) {
        self.imageContainer.hidden = YES;
    }else{
        self.imageContainer.hidden = NO;
        self.imageContainer.imageUrlStrings = commentListItem.imageUrl;
        [self.imageContainer remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, _layout.imageContainerHight));
            make.top.equalTo(self.contentLabel.bottom).offset(FDCommentCellMargin);
            make.left.equalTo(0);
        }];
        [self.commentBtn updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.bottom).offset(FDCommentCellMargin*2 + _layout.imageContainerHight);
        }];
    }
}

@end
