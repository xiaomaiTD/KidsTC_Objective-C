//
//  RefreshHeader.m
//  KidsTC
//
//  Created by 詹平 on 16/7/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshHeader()

/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
/** 刚endRefreshing，正在返回到普通的状态 */
@property (nonatomic, assign) BOOL returningBack;

@end

@implementation RefreshHeader

#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.contentMode = UIViewContentModeCenter;
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - override

- (void)prepare
{
    [super prepare];
    
    self.returningBack = NO;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__00%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:0.5 forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStateRefreshing];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //self.automaticallyChangeAlpha = YES;
    
    //隐藏箭头和菊花
//    [self.arrowView setHidden:YES];
//    UIView *loadingView = [self valueForKeyPath:@"_loadingView"];
//    if (loadingView) {
//        [loadingView setHidden:YES];
//    }
    
    // 隐藏状态
    [self.stateLabel setHidden:YES];
    
    // 隐藏时间
    [self.lastUpdatedTimeLabel setHidden:YES];
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifView.bounds = self.bounds;
}

- (void)beginRefreshing{
    [super beginRefreshing];
    [self.gifView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, self.mj_h*0.5)];
}

- (void)endRefreshing
{
    [super endRefreshing];
    self.returningBack = YES;
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    CGFloat center_y = self_h*0.5;
    [UIView animateWithDuration:0.4 animations:^{
        [self.gifView setCenter:CGPointMake(0, center_y)];
    } completion:^(BOOL finished) {
        self.returningBack = NO;
        [self.gifView setCenter:CGPointMake(self_w, center_y)];
    }];
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
    
    if (self.isRefreshing) return;
    if (self.returningBack) return;
    
    if (pullingPercent > 1) pullingPercent = 1;
    CGFloat center_y = self.mj_h*0.5;
    CGFloat center_x = self.mj_w - (pullingPercent * self.mj_w / 2);
    
    [self.gifView setCenter:CGPointMake(center_x, center_y)];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        [self.gifView stopAnimating];
    }
    
    [self hideArrowAndJuhua];
}

- (void)hideArrowAndJuhua{
    //隐藏箭头和菊花
//    [self.arrowView setHidden:YES];
//    UIView *loadingView = [self valueForKeyPath:@"_loadingView"];
//    if (loadingView) {
//        [loadingView setHidden:YES];
//    }
}


@end
