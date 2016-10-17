//
//  TCHomeTitleContainer.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeTitleContainer.h"

@interface TCHomeTitleContainer ()
@property (nonatomic, strong) UIImageView *tipImageView;
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
        
        UIImageView *tipImageView = [UIImageView new];
        [self addSubview:tipImageView];
        self.tipImageView = tipImageView;
        
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
    switch (_titleContent.type) {
        case TCHomeFloorTitleContentTypeRecommend:
        {
            CGFloat margin = 8;
            CGFloat tipImageView_s = (h - 2 * margin);
            CGFloat tipImageView_x = margin;
            CGFloat tipImageView_y = margin;
            self.tipImageView.frame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_s, tipImageView_s);
            self.tipImageView.image = [UIImage imageNamed:@"homeRecommendTip"];
            self.tipImageView.backgroundColor = [UIColor clearColor];
            self.tipImageView.layer.cornerRadius = tipImageView_s * 0.5;
            self.tipImageView.layer.masksToBounds = YES;
            
            
            CGFloat titleLabel_x = CGRectGetMaxX(self.tipImageView.frame) + margin;
            CGFloat titleLabel_y = 0;
            CGFloat titleLabel_w = 140;
            CGFloat titleLabel_h = h;
            self.titleLabel.frame = CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
            
            self.arrowImageView.hidden = YES;
            
            CGFloat subTitleLabel_x = CGRectGetMaxX(self.titleLabel.frame) + margin;
            CGFloat subTitleLabel_y = 0;
            CGFloat subTitleLabel_w = w - subTitleLabel_x - margin;
            CGFloat subTitleLabel_h = h;
            self.subTitleLabel.frame = CGRectMake(subTitleLabel_x, subTitleLabel_y, subTitleLabel_w, subTitleLabel_h);
        }
            break;
            
        default:
        {
            CGFloat margin = 8;
            
            CGFloat tipImageView_x = 0;
            CGFloat tipImageView_y = h * 0.25;
            CGFloat tipImageView_w = 2;
            CGFloat tipImageView_h = h * 0.5;
            self.tipImageView.frame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_w, tipImageView_h);
            self.tipImageView.image = nil;
            self.tipImageView.backgroundColor = COLOR_PINK;
            self.tipImageView.layer.cornerRadius = 0;
            self.tipImageView.layer.masksToBounds = YES;
            
            
            CGFloat titleLabel_x = CGRectGetMaxX(self.tipImageView.frame) + margin;
            CGFloat titleLabel_y = 0;
            CGFloat titleLabel_w = 140;
            CGFloat titleLabel_h = h;
            self.titleLabel.frame = CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
            
            
            CGFloat arrowImageView_s = 13;
            CGFloat arrowImageView_x = w - arrowImageView_s - margin;
            CGFloat arrowImageView_y = (h - arrowImageView_s) * 0.5;
            self.arrowImageView.frame = CGRectMake(arrowImageView_x, arrowImageView_y, arrowImageView_s, arrowImageView_s);
            self.arrowImageView.hidden = NO;
            
            
            CGFloat subTitleLabel_x = CGRectGetMaxX(self.titleLabel.frame) + margin;
            CGFloat subTitleLabel_y = 0;
            CGFloat subTitleLabel_w = w - subTitleLabel_x - arrowImageView_s - margin;
            CGFloat subTitleLabel_h = h;
            self.subTitleLabel.frame = CGRectMake(subTitleLabel_x, subTitleLabel_y, subTitleLabel_w, subTitleLabel_h);
        }
            break;
    }
    self.line.frame = CGRectMake(0, h - LINE_H, w, LINE_H);
    
}

- (void)setTitleContent:(TCHomeFloorTitleContent *)titleContent {
    _titleContent = titleContent;
    self.titleLabel.attributedText = titleContent.attName;
    self.subTitleLabel.attributedText = titleContent.attSubName;
    self.arrowImageView.hidden = titleContent.segueModel.destination == SegueDestinationNone;
    [self setupSubViews];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(tcHomeTitleContainer:actionType:value:)]) {
        [self.delegate tcHomeTitleContainer:self actionType:TCHomeTitleContainerActionTypeSegue value:self.titleContent.segueModel];
    }
}

@end
