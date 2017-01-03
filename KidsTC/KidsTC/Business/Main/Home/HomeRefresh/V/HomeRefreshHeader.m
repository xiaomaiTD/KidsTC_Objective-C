//
//  HomeRefreshHeader.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshHeader.h"
#import "HomeRefreshManager.h"
#import "NSString+Category.h"
#import "UIImageView+WebCache.h"

@interface HomeRefreshHeader ()
{
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,assign) BOOL hasSuprise;
@end

@implementation HomeRefreshHeader

#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_mj_refresh"]];
        arrowView.bounds = CGRectMake(0, 0, 11, 14.5);
        arrowView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor redColor];
        [self insertSubview:_bgImageView atIndex:0];
    }
    return _bgImageView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    // 设置对应状态的文字
    [self setTitle:@"下拉有惊喜" forState:MJRefreshStateIdle];
    [self setTitle:@"松开得惊喜" forState:MJRefreshStatePulling];
    [self setTitle:@"正在拉惊喜..." forState:MJRefreshStateRefreshing];
    
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    
    [self setupSubViews];
    
    [NotificationCenter addObserver:self selector:@selector(setupSubViews) name:kHomeRefreshNewDataNoti object:nil];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset - 10;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5 + 8;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.bounds.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    //[super setState:state];
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = !_hasSuprise;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = !_hasSuprise;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = !_hasSuprise;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        if (_hasSuprise) [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

- (void)setupSubViews {
    
    HomeRefreshManager *manager = [HomeRefreshManager shareHomeRefreshManager];
    
    _hasSuprise = manager.hasSuprise;
    
    //小兔子
    self.gifView.hidden = _hasSuprise;
    //状态文字
    self.stateLabel.hidden = !_hasSuprise;
    //箭头菊花
    self.arrowView.hidden = !_hasSuprise || self.isRefreshing;
    self.loadingView.hidden = !_hasSuprise;
    
    if (_hasSuprise) {
        NSString *imgUrl = manager.model.data.imgUrl;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image && !error) {
                CGSize size = image.size;
                CGFloat ratio = 1;
                if (size.width>0 && size.height>0) {
                    ratio = size.height/size.width;
                }
                CGFloat imageView_h = SCREEN_WIDTH * ratio;
                self.bgImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-imageView_h, SCREEN_WIDTH, imageView_h);
            }else{
                [self.bgImageView removeFromSuperview];
                self.bgImageView = nil;
            }
        }];
    }else{
        [self.bgImageView removeFromSuperview];
        self.bgImageView = nil;
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kHomeRefreshNewDataNoti object:nil];
}


@end
