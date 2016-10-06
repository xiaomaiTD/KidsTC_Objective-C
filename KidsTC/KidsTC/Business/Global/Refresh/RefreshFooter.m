//
//  RefreshFooter.m
//  KidsTC
//
//  Created by 詹平 on 16/7/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "RefreshFooter.h"
#define GifViewSize 15

@interface RefreshFooter()
{
    __unsafe_unretained UIImageView *_gifView;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
/** 是否是单张图片 */
@property (nonatomic, assign) BOOL isSingleImage;
@end

@implementation RefreshFooter
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.bounds = CGRectMake(0, 0, GifViewSize, GifViewSize);
        gifView.contentMode = UIViewContentModeScaleAspectFit;
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

#pragma mark Single Image

- (void)startAnimation
{
    CAKeyframeAnimation *gifViewAnimation = [CAKeyframeAnimation animation];
    gifViewAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
                           nil];
    gifViewAnimation.cumulative = YES;
    gifViewAnimation.duration = 0.6;
    gifViewAnimation.repeatCount = INTMAX_MAX;
    gifViewAnimation.removedOnCompletion = YES;
    
    [self.gifView.layer addAnimation:gifViewAnimation forKey:@"transform"];
    
}


- (void)stopAnimaton{
    [self.gifView.layer removeAnimationForKey:@"transform"];
}

#pragma mark - 实现父类的方法

- (CGFloat)appearencePercentTriggerAutoRefresh
{
    return self.triggerAutomaticallyRefreshPercent;
}

- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = 20;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_up_acticity_0%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_up_acticity_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    if (idleImages.count>1 || refreshingImages.count>1) self.isSingleImage = NO;
    
    // 设置对应状态的文字
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载更多..." forState:MJRefreshStateRefreshing];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = NO;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
    
    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

//- (void)scrollViewPanStateDidChange:(NSDictionary *)change
//{
//    [super scrollViewPanStateDidChange:change];
//    
//    if (self.state != MJRefreshStateIdle) return;
//    
//    if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
//        if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  // 不够一个屏幕
//            if (_scrollView.mj_offsetY >= - _scrollView.mj_insetT) { // 向上拽
//                [self beginRefreshing];
//            }
//        } else { // 超出一个屏幕
//            if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
//                [self beginRefreshing];
//            }
//        }
//    }
//}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    [self.gifView stopAnimating];
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
    
    if (self.isRefreshing) return;
    
    if (self.isSingleImage) return;
    
    CAAnimation *animation = [self.gifView.layer animationForKey:@"transform"];
    if (pullingPercent>=1) {
        if (!animation) [self startAnimation];
    }else{
        if (animation) [self stopAnimaton];
        self.gifView.transform = CGAffineTransformMakeRotation(4*M_PI*pullingPercent);
    }
}

- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {
        self.state = MJRefreshStateIdle;
        
        self.scrollView.mj_insetB -= self.mj_h;
    } else if (lastHidden && !hidden) {
        self.scrollView.mj_insetB += self.mj_h;
        
        // 设置位置
        self.mj_y = _scrollView.mj_contentH;
    }
}


- (void)placeSubviews
{
    [super placeSubviews];
    
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX = self.mj_w * 0.5 * 0.6;
        //self.labelLeftInset +self.stateLabel.mj_textWith * 0.5 + self.gifView.mj_w*0.5;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    self.gifView.center = arrowCenter;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        self.gifView.hidden = NO;
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
        
        
    } else if (state == MJRefreshStateIdle) {
        self.gifView.hidden = NO;
    } else if (state == MJRefreshStateNoMoreData) {
        self.gifView.hidden = YES;
    }
}

@end
