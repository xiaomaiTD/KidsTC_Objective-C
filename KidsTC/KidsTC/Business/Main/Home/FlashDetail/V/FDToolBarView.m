//
//  FDToolBarView.m
//  KidsTC
//
//  Created by zhanping on 5/18/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDToolBarView.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define FDItemButtonTopInset 8
#define FDItemButtonTitleHight 26
#import "UIButton+Category.h"



@implementation FDItemButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = 0;
    CGFloat y = contentRect.size.height - FDItemButtonTitleHight;
    CGFloat h = FDItemButtonTitleHight;
    CGFloat w = contentRect.size.width;
    return CGRectMake(x, y, w, h);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat y = FDItemButtonTopInset;
    CGFloat w = contentRect.size.height - FDItemButtonTitleHight - FDItemButtonTopInset;
    CGFloat x = (CGRectGetWidth(contentRect) - w) * 0.5;
    CGFloat h = w;
    return CGRectMake(x, y, w, h);
}

@end


@interface FDToolBarView ()
@property (nonatomic, weak) UIButton *flashBuyBtn;
@property (nonatomic, weak) UILabel *timerCountLabel;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation FDToolBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:visualEffect];
        [self addSubview:visualEffectView];
        
        UILabel *timerCountLabel = [[UILabel alloc]init];
        timerCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timerCountLabel];
        
        UIVisualEffect *visualEffect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *visualEffectView1 = [[UIVisualEffectView alloc]initWithEffect:visualEffect1];
        [timerCountLabel addSubview:visualEffectView1];
        
        FDItemButton *inviteBtn = [self btnWithTitle:@"邀人来闪" imageName:@"icon_flash_invite"];
        inviteBtn.tag = FDToolBarViewBtnType_Invite;
        [self addSubview:inviteBtn];
        FDItemButton *buyNowBtn = [self btnWithTitle:@"立即购买" imageName:@"icon_flash_buy_now"];
        buyNowBtn.tag = FDToolBarViewBtnType_BuyNow;
        [self addSubview:buyNowBtn];
        
        UIButton *flashBuyBtn = [[UIButton alloc]init];
        flashBuyBtn.tag = FDToolBarViewBtnType_FlashBuy;
        flashBuyBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [flashBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [flashBuyBtn setTitle:@"我要闪购" forState:UIControlStateNormal];
        [flashBuyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
        //[flashBuyBtn setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
        [self addSubview:flashBuyBtn];
        
        self.timerCountLabel = timerCountLabel;
        self.flashBuyBtn = flashBuyBtn;
        
        [inviteBtn addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
        [buyNowBtn addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
        [flashBuyBtn addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIColor *lineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        
        UIView *line_h1 = [[UIView alloc]init];
        line_h1.backgroundColor = lineColor;
        [timerCountLabel addSubview:line_h1];
        
        UIView *line_h2 = [[UIView alloc]init];
        line_h2.backgroundColor = lineColor;
        [timerCountLabel addSubview:line_h2];
        
        UIView *line_v2 = [[UIView alloc]init];
        line_v2.backgroundColor = lineColor;
        [self addSubview:line_v2];
        
        UIView *line_v3 = [[UIView alloc]init];
        line_v3.backgroundColor = lineColor;
        [self addSubview:line_v3];
        
        CGFloat lineW = LINE_H;//线条的宽度
        
        [visualEffectView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
        }];
        
        
        [visualEffectView1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
        }];
        [line_h1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(lineW);
        }];
        [line_h2 makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(lineW);
        }];
        
        [timerCountLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(-30);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(30);
        }];
        
        CGFloat itemBtnW = (SCREEN_WIDTH - 2*lineW)/4.0;
        [inviteBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.width.equalTo(itemBtnW);
        }];
        
        [line_v2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(inviteBtn.right);
            make.width.equalTo(lineW);
        }];
        
        [buyNowBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(line_v2.right);
            make.width.equalTo(itemBtnW);
        }];
        
        [line_v3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(buyNowBtn.right);
            make.width.equalTo(lineW);
        }];
        
        [flashBuyBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(line_v3.right);
            make.width.equalTo(itemBtnW*2);
        }];

    }
    return self;
}

- (FDItemButton *)btnWithTitle:(NSString *)title imageName:(NSString *)imageName{
    FDItemButton *btn = [[FDItemButton alloc]init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

- (void)setData:(FDData *)data{
    _data = data;
    
    
    BOOL isCanBuy = data.isLink;
    FDDataStatus status = data.status;
    NSString *statusDesc = data.statusDesc;
    
    UIButton *flashBuyBtn = self.flashBuyBtn;
    if (!isCanBuy) {//是否可以点击
        switch (status) {
            case FDDataStatus_NotStart://= 1,//闪购尚未开始，未到预约时间
            {
                [flashBuyBtn setBackgroundColor:[UIColor colorWithRed:0.200  green:0.766  blue:0.494 alpha:1] forState:UIControlStateNormal];
                flashBuyBtn.enabled = !data.isOpenRemind;
                statusDesc = data.isOpenRemind?@"已提醒":@"开闪提醒";
            }
                break;
            default:
            {
                [flashBuyBtn setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
                flashBuyBtn.enabled = NO;
            }
                break;
        }
    }else{//按钮可以点击
        flashBuyBtn.enabled = YES;
        switch (status) {
            case FDDataStatus_WaitBuy://= 4,//等待开团，等待开团（已预付）:
            case FDDataStatus_HadPaid://= 12,//闪购成功，已购买:
            case FDDataStatus_Evaluted://= 16,//已评价，已评价 -在订单中:
            {
                [flashBuyBtn setBackgroundColor:[COLOR_PINK colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
            }
                break;
                
            default:
            {
                [flashBuyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
            }
                break;
        }
    }
    
    [self.flashBuyBtn setTitle:statusDesc forState:UIControlStateNormal];
    
    
    if (data.isShowCountDown) {
        self.timerCountLabel.attributedText = self.data.countDownValueString;
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDownTime:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
        self.timerCountLabel.hidden = NO;
    }else{
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timerCountLabel.hidden = YES;
    }
}

- (void)countDownTime:(NSTimer *)timer
{
    self.timerCountLabel.attributedText = self.data.countDownValueString;
    if (self.data.countDownValue<=0) {
        if ([self.delegate respondsToSelector:@selector(toolBarViewdidEndTimeCountdown:)]) {
            [self.delegate toolBarViewdidEndTimeCountdown:self];
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

- (void)toolbarAction:(UIButton *)btn{
    FDToolBarViewBtnType type = (FDToolBarViewBtnType)btn.tag;
    if ([self.delegate respondsToSelector:@selector(toolBarView:didClickOnType:)]) {
        [self.delegate toolBarView:self didClickOnType:type];
    }
}


@end
