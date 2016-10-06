//
//  AppVersionViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AppVersionViewController.h"

static int const kContentViewLRMargin = 12;
static int const kBtnHeight = 40;
static int const kBtnLRMargin = 0;
@interface AppVersionViewController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIDynamicAnimator *dynamicBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@end

@implementation AppVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupSubViews];
    _dynamicBehavior = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    CGPoint point = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
    [self snap:point];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)snap:(CGPoint)point{
    [self.dynamicBehavior removeBehavior:self.snapBehavior];
    self.snapBehavior = [[UISnapBehavior alloc]initWithItem:_contentView snapToPoint:point];
    self.snapBehavior.damping = 0.8;
    [self.dynamicBehavior addBehavior:self.snapBehavior];
}

- (void)setupSubViews {
    
    [self.view addSubview:_contentView = [UIView new]];
    
    [_contentView addSubview:_bgImageView = [UIImageView new]];
    _bgImageView.image = _data.bgImg;
    
    [_contentView addSubview:_btn = [UIButton new]];
    [_btn addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setImage:_data.btnImg forState:UIControlStateNormal];
    
    CGSize bgSize = _data.bgImg.size;
    CGFloat bgRatio = bgSize.height/bgSize.width;
    
    CGFloat contentView_w = SCREEN_WIDTH - 2 * kContentViewLRMargin;
    CGFloat contentView_h = contentView_w * bgRatio + kBtnHeight*0.5;
    CGFloat contentView_x = kContentViewLRMargin;
    CGFloat contentView_y = -contentView_h;
    self.contentView.frame = CGRectMake(contentView_x, contentView_y, contentView_w, contentView_h);
    
    CGFloat bgImageView_x = 0;
    CGFloat bgImageView_y = 0;
    CGFloat bgImageView_w = contentView_w;
    CGFloat bgImageView_h = bgImageView_w * bgRatio;
    self.bgImageView.frame = CGRectMake(bgImageView_x, bgImageView_y, bgImageView_w, bgImageView_h);
    
    CGSize btnSize = _data.btnImg.size;
    CGFloat btnRatio = btnSize.height/btnSize.width;
    CGFloat btn_h = kBtnHeight;
    CGFloat btn_w = btn_h/btnRatio;
    CGFloat maxBtn_w = contentView_w - 2 * kBtnLRMargin;
    if (btn_w>maxBtn_w) {
        btn_w = maxBtn_w;
    }
    CGFloat btn_x = (contentView_w - btn_w) * 0.5;
    CGFloat btn_y = contentView_h - btn_h;
    self.btn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    
    [self setupCancleBtn];
}

- (void)setupCancleBtn{
    
    CGFloat btn_w = 60, btn_h = 30, btn_y = 30, btn_right_margin = 20;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-btn_right_margin-btn_w, btn_y, btn_w, btn_h)];
    [btn setTitle:_data.isForceUpdate?@"退出":@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = CGRectGetHeight(btn.frame)*0.5;
    btn.layer.borderColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5].CGColor;
    btn.layer.borderWidth = LINE_H;
    [btn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    CALayer *layer = [CALayer layer];
    layer.frame = btn.frame;
    layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    layer.cornerRadius = CGRectGetHeight(layer.frame)*0.5;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 2;
    [self.view.layer insertSublayer:layer below:btn.layer];
}

- (void)cancleAction:(UIButton *)sender {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self back];
}
- (void)updateAction:(UIButton *)sender {
    if (self.updateBlock) {
        self.updateBlock();
    }
    [self back];
}




@end
