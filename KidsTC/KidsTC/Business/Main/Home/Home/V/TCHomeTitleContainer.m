//
//  TCHomeTitleContainer.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeTitleContainer.h"
#import "YYKit.h"

@interface TCHomeTitleContainer ()
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation TCHomeTitleContainer

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *tipImageView = [UIImageView new];
        [self addSubview:tipImageView];
        //tipImageView.backgroundColor = [UIColor redColor];
        self.tipImageView = tipImageView;
        
        UILabel *titleLabel = [UILabel new];
        //titleLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *remainLabel = [UILabel new];
        remainLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
        remainLabel.layer.borderWidth = LINE_H;
        //remainLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:remainLabel];
        self.remainLabel = remainLabel;
        
        UILabel *subTitleLabel = [UILabel new];
        subTitleLabel.font = [UIFont systemFontOfSize:16];
        subTitleLabel.textAlignment = NSTextAlignmentRight;
        //subTitleLabel.backgroundColor = [UIColor purpleColor];
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UIImageView *arrowImageView = [UIImageView new];
        arrowImageView.image = [UIImage imageNamed:@"arrow_r"];
        //arrowImageView.backgroundColor = [UIColor redColor];
        [self addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)setTitleContent:(TCHomeFloorTitleContent *)titleContent {
    _titleContent = titleContent;
    [self setupShowpiece];
    [self setupLayout];
}

- (void)setupShowpiece {
    TCHomeFloorTitleContentShowpiece *showpiece = _titleContent.showPiece;
    self.tipImageView.backgroundColor = showpiece.tipImageViewBGColor;
    self.tipImageView.image = showpiece.tipImageViewImg;
    self.titleLabel.attributedText = showpiece.attName;
    self.subTitleLabel.attributedText = showpiece.attSubName;
}

- (void)setupLayout {
    
    TCHomeFloorTitleContentLayout *layout = _titleContent.layout;
    
    _tipImageView.frame = layout.tipImageViewFrame;
    
    _titleLabel.frame = layout.titleLabelFrame;
    
    _remainLabel.hidden = layout.remainLabelHidden;
    if (!_remainLabel.hidden) {
        if (CGRectEqualToRect(_remainLabel.frame, CGRectZero)) {
            _remainLabel.frame = layout.remainLabelFrame;
        }
        [self addTimer];
    }else{
        if (self.timer)[self removeTimer];
    }
    
    _subTitleLabel.frame = layout.subTitleLabelFrame;
    
    _arrowImageView.hidden = layout.arrowImageViewHidden;
    if (!_arrowImageView.hidden) {
        _arrowImageView.frame = layout.arrowImageViewFrame;
    }
    
    _line.frame = layout.lineFrame;
}

- (void)addTimer {
    if (self.timer) return;
    self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
}

- (void)countDown {
    self.remainLabel.attributedText = [self checkValite]?_titleContent.showPiece.countDownValueString:nil;
    CGFloat w = [self.remainLabel.attributedText size].width;
    CGRect frame = self.remainLabel.frame;
    frame.size.width = w;
    self.remainLabel.frame = frame;
}

- (BOOL)checkValite{
    if (_titleContent.remainTime<0) {
        if (self.timer)[self removeTimer];
        return NO;
    }
    return YES;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(tcHomeTitleContainer:actionType:value:)]) {
        [self.delegate tcHomeTitleContainer:self actionType:TCHomeTitleContainerActionTypeSegue value:self.titleContent.segueModel];
    }
}

@end
