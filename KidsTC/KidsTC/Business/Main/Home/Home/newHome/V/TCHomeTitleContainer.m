//
//  TCHomeTitleContainer.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeTitleContainer.h"

@interface TCHomeTitleContainer ()
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *line;
@end

@implementation TCHomeTitleContainer

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *tipView = [UIView new];
        tipView.backgroundColor = COLOR_PINK;
        [self addSubview:tipView];
        self.tipView = tipView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = COLOR_PINK;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *subTitleLabel = [UILabel new];
        subTitleLabel.textColor = [UIColor lightGrayColor];
        subTitleLabel.font = [UIFont systemFontOfSize:16];
        subTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UIImageView *arrowImageView = [UIImageView new];
        arrowImageView.image = [UIImage imageNamed:@"arrow_r"];
        [self addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
        
        [self setupSubViews];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setupSubViews {
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    self.tipView.frame = CGRectMake(0, h * 0.25, 2, h * 0.5);
    CGFloat arrow_size = 13;
    self.arrowImageView.frame = CGRectMake(w - arrow_size - 8, (h - arrow_size) * 0.5, arrow_size, arrow_size);
    self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(self.arrowImageView.frame)-100-2, 0, 100, h);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.tipView.frame) + 6, 0, 100, h);
    self.line.frame = CGRectMake(0, h - LINE_H, w, LINE_H);
}

- (void)setTitleContent:(TCHomeFloorTitleContent *)titleContent {
    _titleContent = titleContent;
    self.titleLabel.text = titleContent.name;
    self.subTitleLabel.text = titleContent.subName;
    self.arrowImageView.hidden = titleContent.segueModel.destination == SegueDestinationNone;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(tcHomeTitleContainer:actionType:value:)]) {
        [self.delegate tcHomeTitleContainer:self actionType:TCHomeTitleContainerActionTypeSegue value:self.titleContent.segueModel];
    }
}

@end
