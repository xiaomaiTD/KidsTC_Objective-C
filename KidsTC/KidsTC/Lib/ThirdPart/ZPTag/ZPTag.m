//
//  ZPTag.m
//  ImageLabel
//
//  Created by 詹平 on 16/4/2.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ZPTag.h"
#import <QuartzCore/QuartzCore.h>

/* ZPTagArc */
struct ZPTagArc {
    CGPoint center;
    CGFloat startAngle;
    CGFloat endAngle;
    int clockwise;
};
typedef struct ZPTagArc ZPTagArc;

CG_INLINE ZPTagArc
ZPTagArcMake(CGPoint center, CGFloat startAngle, CGFloat endAngle, int clockwise)
{
    ZPTagArc tagArc;
    tagArc.center = center, tagArc.startAngle = startAngle; tagArc.endAngle = endAngle; tagArc.clockwise = clockwise;
    return tagArc;
}
typedef NS_ENUM(NSInteger, ZPTagDirectionByPlace) {//标签箭头方向(用户没有手动设置的标签方向),根据标签在父视图中的位置来自动设置
    ZPTagDirectionByPlaceUnkonwn,                  //未知
    ZPTagDirectionByPlaceLeft,                     //向左
    ZPTagDirectionByPlaceRight                     //向右
};

static NSString *const animateCircleForeAnimationKey = @"animateCircleForeAnimationKey";
static NSString *const animateCircleBackAnimationKey = @"animateCircleBackAnimationKey";

NSString *const kZPTagViewWillAppearNotification    = @"viewWillAppearNotification";

/* 可手动配置的参数 */
//tag
int const tagHeight = 24;//标签的高度
float const tagCornerRadius = 3;//标签的圆角半径
//animateCircle
float const animateCircleOriginalSize = tagHeight/3.4>12? 12 : tagHeight/3.4;//两个动画圆 最初宽高尺寸
float const duration = 1.5;            //两个动画圆 动画循环一次的时长
float const repeatCount = CGFLOAT_MAX; //两个动画圆 动画循环的次数
float animateCircleForeScale = 1.4;    //前面动画圆 (默认白色)放大倍数
float animateCircleBackScale = 6;      //后面动画圆 (默认黑色)放大倍数
//title
float const animateCircleCenter_TagTip_Margin = 8;                      //动画圆中心距离文字背景的尖端的距离
int const titleFont = 13;                                               //标题的字体大小
#define TITLE_EDGE_INSET ((tagHeight - [self titleSize].height)/2.0)    //标题Title距离背景的内边距

@interface ZPTag()
@property (nonatomic, strong) CALayer *animateCircleBack;               //后面的动画圆(默认黑色)
@property (nonatomic, strong) CALayer *animateCircleFore;               //前面的动画圆(默认白色)
@property (nonatomic, assign) CGSize location_center_size;              //长按时，用户按住的点到tag中心点的Size
@property (nonatomic, assign) ZPTagDirectionByPlace tagDirectionByPlace;//标签箭头方向(用户没有手动设置的标签方向),根据标签在父视图中的位置来自动设置
@property (nonatomic, assign) BOOL isFirstTimeAppear;                   //是否是第一次出现
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@property (nonatomic, strong) UIPanGestureRecognizer *panGR;
@end

@implementation ZPTag

+(instancetype)CreatTagWithOriginPoint:(CGPoint)originPoint{
    ZPTag *tag = [[self alloc]initWithFrame:CGRectMake(originPoint.x-tagHeight/2, originPoint.y-tagHeight/2, tagHeight, tagHeight)];
    return tag;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirstTimeAppear = YES;
        self.backgroundColor = [UIColor clearColor];
        
        //添加animateClicle两个动画圆
        [self addAnimateCircleBack];
        [self addAnimateCircleFore];
        
        //添加点击和平移手势
        [self addGestureRecognizer:self.tapGR];
        [self addGestureRecognizer:self.panGR];
        
        //一定要放在创建self.panGR之后再设置这个默认值
        self.tagUserInteractionMode = ZPTagUserInteractionModeClick;
        
        //监听系统进入前台(为动画圆重新添加动画)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:kZPTagViewWillAppearNotification object:nil];
    }
    return self;
}

#pragma mark - 为标签添加手势

- (void)tapGRAction:(UITapGestureRecognizer *)tapGR{
    if (self.tagUserInteractionMode == ZPTagUserInteractionModeEdit) {
        if (self.title.length>0) {
            if ([[UIMenuController sharedMenuController] isMenuVisible]) {
                [[UIMenuController sharedMenuController] setMenuVisible:NO animated: YES];
                return;
            }else{
                [self becomeFirstResponder];
                UIMenuItem *menuItemDelete = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                                        action:@selector(remove)];
                UIMenuItem *menuItemEdit = [[UIMenuItem alloc]initWithTitle:@"编辑" action:@selector(edit)];
                [[UIMenuController sharedMenuController] setMenuItems:@[menuItemDelete,menuItemEdit]];
                [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
                [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
            }
        }else{
            [self edit];
        }
    }else{//能来到这儿只能是：self.tagUserInteractionMode == ZPTagUserInteractionModeClick
        [self edit];
    }
    
}

- (void)panGRAction:(UIPanGestureRecognizer *)panGR{
    if ([[UIMenuController sharedMenuController] isMenuVisible]) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated: YES];
    }
    if (!self.superview) return;

    
    switch (panGR.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint location_self = [panGR locationInView:self];
            self.location_center_size = CGSizeMake(location_self.x-self.bounds.size.width/2.0, location_self.y-self.bounds.size.height/2.0);
        }
            break;
            case UIGestureRecognizerStateChanged:
        {
            CGPoint location_superview = [panGR locationInView:self.superview];
            CGPoint center = CGPointMake(location_superview.x-self.location_center_size.width, location_superview.y-self.location_center_size.height);
            
            CGPoint targetPointLocation_willBeInSupserview = CGPointZero;
            if (self.tagDirectionByInput == ZPTagDirectionByInputLeft || self.tagDirectionByPlace == ZPTagDirectionByPlaceLeft) {
                targetPointLocation_willBeInSupserview = CGPointMake(center.x-CGRectGetWidth(self.bounds)/2.0 + tagHeight/2.0, center.y);
            }else  if (self.tagDirectionByInput == ZPTagDirectionByInputRight || self.tagDirectionByPlace == ZPTagDirectionByPlaceRight){
                targetPointLocation_willBeInSupserview = CGPointMake(center.x+CGRectGetWidth(self.bounds)/2.0 - tagHeight/2.0, center.y);
            }
            if (targetPointLocation_willBeInSupserview.x<0) targetPointLocation_willBeInSupserview.x = 0;
            if (targetPointLocation_willBeInSupserview.x>CGRectGetWidth(self.superview.frame)) targetPointLocation_willBeInSupserview.x = CGRectGetWidth(self.superview.frame);
            if (targetPointLocation_willBeInSupserview.y<0) targetPointLocation_willBeInSupserview.y = 0;
            if (targetPointLocation_willBeInSupserview.y>CGRectGetHeight(self.superview.frame)) targetPointLocation_willBeInSupserview.y = CGRectGetHeight(self.superview.frame);
            
            self.center = CGPointMake(targetPointLocation_willBeInSupserview.x - (self.animateCircleFore.position.x-CGRectGetWidth(self.bounds)/2.0), targetPointLocation_willBeInSupserview.y);
            
            //用这种方式会造成遇到边界滑动停止的情况，看起来像是卡顿，用户体验效果差
            //if (CGRectContainsPoint(self.superview.bounds, targetPointLocation_willBeInSupserview)) {
                //self.center = center;
            //}
        }
            break;
        default:
        {
            if (self.tagDirectionByInput == ZPTagDirectionByInputUnkonwn) {
                if (self.targetPointLocationInSuperview.x<=self.superview.bounds.size.width/2.0) {
                    self.tagDirectionByPlace = ZPTagDirectionByPlaceLeft;
                }else{
                    self.tagDirectionByPlace = ZPTagDirectionByPlaceRight;
                }
            }
        }
            break;
    }
}

#pragma mark - 为标签添加动画Layer

- (void)addAnimateCircleBack{
    
    self.animateCircleBack = [CALayer layer];
    CGFloat animateCircleXY = (tagHeight-animateCircleOriginalSize)/2.0;
    self.animateCircleBack.frame = CGRectMake(animateCircleXY, animateCircleXY, animateCircleOriginalSize, animateCircleOriginalSize);
    self.animateCircleBack.cornerRadius = CGRectGetWidth(self.animateCircleBack.bounds)/2.0;
    self.animateCircleBack.masksToBounds = YES;
    self.animateCircleBack.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:self.animateCircleBack];
    
    [self addAnimationForAnimateCircleBack];
}

- (void)addAnimateCircleFore{
    
    self.animateCircleFore = [CALayer layer];
    CGFloat animateCircleXY = (tagHeight-animateCircleOriginalSize)/2.0;
    self.animateCircleFore.frame = CGRectMake(animateCircleXY, animateCircleXY, animateCircleOriginalSize, animateCircleOriginalSize);
    self.animateCircleFore.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    //为Layer添加圆角
    //self.animateCircleFore.masksToBounds = YES;//为Layer添加圆角这句代码可以不用写，想要为Layer添加阴影这句代码一定不能写
    self.animateCircleFore.cornerRadius = CGRectGetWidth(self.animateCircleFore.bounds)/2.0;
    
    //为Layer添加阴影
    self.animateCircleFore.shadowOffset = CGSizeMake(0.5, 0.5);
    self.animateCircleFore.shadowOpacity = 1;
    
    //为Layer添加边框
    self.animateCircleFore.borderWidth = 0.2;
    self.animateCircleFore.borderColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
    
    
    [self.layer addSublayer:self.animateCircleFore];
    
    [self addAnimationForAnimateCircleFore];
}

#pragma mark 为动画Layer添加动画

- (void)addAnimationForAnimateCircleBack{
    
    CABasicAnimation *basicAnimation_transform = [CABasicAnimation animation];
    basicAnimation_transform.keyPath = @"transform";
    basicAnimation_transform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(animateCircleBackScale, animateCircleBackScale, 1)];
    
    CABasicAnimation *basicAnimation_opacity = [CABasicAnimation animation];
    basicAnimation_opacity.keyPath = @"opacity";//透明度
    basicAnimation_opacity.toValue = @(0);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.animations = @[basicAnimation_transform,basicAnimation_opacity];
    animationGroup.repeatCount = repeatCount;
    
    [self.animateCircleBack addAnimation:animationGroup forKey:animateCircleBackAnimationKey];
}

- (void)addAnimationForAnimateCircleFore{
    
    CAKeyframeAnimation *keyframeAnimation_transform = [CAKeyframeAnimation animation];
    keyframeAnimation_transform.keyPath = @"transform";
    CGFloat zoomFactor = (animateCircleForeScale - 1)/3.0;//按照三等分生成缩放因子
    NSValue *value_transform1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(animateCircleForeScale, animateCircleForeScale, 1)];
    NSValue *value_transform2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(animateCircleForeScale - zoomFactor*2, animateCircleForeScale - zoomFactor*2, 1)];
    NSValue *value_transform3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(animateCircleForeScale - zoomFactor, animateCircleForeScale - zoomFactor, 1)];
    NSValue *value_transform4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    keyframeAnimation_transform.values = @[value_transform1,value_transform2,value_transform3,value_transform4];
    keyframeAnimation_transform.duration = duration;
    keyframeAnimation_transform.repeatCount = repeatCount;
    keyframeAnimation_transform.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.animateCircleFore addAnimation:keyframeAnimation_transform forKey:animateCircleForeAnimationKey];
}

#pragma mark - 每次从后台进入前台都为动画Layer添加动画

- (void)enterForegroundNotification{
    
    if ([self.animateCircleBack animationForKey:animateCircleBackAnimationKey]) {
        [self.animateCircleBack removeAnimationForKey:animateCircleBackAnimationKey];
    }
    [self addAnimationForAnimateCircleBack];
    
    if ([self.animateCircleFore animationForKey:animateCircleForeAnimationKey]) {
        [self.animateCircleFore removeAnimationForKey:animateCircleForeAnimationKey];
    }
    [self addAnimationForAnimateCircleFore];
}

#pragma mark - 为标签绘制标签背景和title文字

- (void)drawRect:(CGRect)rect {
    
    if (self.title.length>0) {
        
        
        CGFloat titleRect_x = 0;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGPoint point_Start_End , point1 , point2 , point3 , point4 , point5 , point6;
        ZPTagArc tagArc1 , tagArc2;
        if (self.tagDirectionByInput == ZPTagDirectionByInputLeft || self.tagDirectionByPlace == ZPTagDirectionByPlaceLeft) {//点在左边区域 箭头向左
            point_Start_End = CGPointMake(tagHeight/2.0+animateCircleCenter_TagTip_Margin, tagHeight/2.0);
            
            point1 = CGPointMake(point_Start_End.x+tagHeight/2.0, 0);
            point2 = CGPointMake(CGRectGetWidth(self.bounds)-tagCornerRadius, 0);
            point3 = CGPointMake(CGRectGetWidth(self.bounds), tagCornerRadius);
            tagArc1 = ZPTagArcMake(CGPointMake(point2.x, point3.y), M_PI_2*3, M_PI*2, 0);//在point2和point3之间 插入圆弧
            //===========================对称=================================//
            point4 = CGPointMake(point3.x, tagHeight-point3.y);
            point5 = CGPointMake(point2.x, tagHeight);
            tagArc2 = ZPTagArcMake(CGPointMake(point5.x, point4.y), 0, M_PI_2, 0);//在point4和point5之间 插入圆弧
            point6 = CGPointMake(point1.x, tagHeight);
            
            
            titleRect_x = point1.x + TITLE_EDGE_INSET/2.0;
            
        }else if (self.tagDirectionByInput == ZPTagDirectionByInputRight|| self.tagDirectionByPlace == ZPTagDirectionByPlaceRight){//点在右边区域，箭头向右
            
            point_Start_End = CGPointMake(CGRectGetWidth(self.bounds)-(tagHeight/2.0+animateCircleCenter_TagTip_Margin), tagHeight/2.0);
            
            point1 = CGPointMake(point_Start_End.x-tagHeight/2.0, 0);
            point2 = CGPointMake(tagCornerRadius, 0);
            point3 = CGPointMake(0, tagCornerRadius);
            tagArc1 = ZPTagArcMake(CGPointMake(point2.x, point3.y), M_PI_2*3, M_PI, 1);//在point2和point3之间 插入圆弧
            //===========================对称=================================//
            point4 = CGPointMake(point3.x, tagHeight-point3.y);
            point5 = CGPointMake(point2.x, tagHeight);
            tagArc2 = ZPTagArcMake(CGPointMake(point5.x, point4.y), M_PI, M_PI_2, 1);//在point4和point5之间 插入圆弧
            point6  = CGPointMake(point1.x, tagHeight);
            
            titleRect_x = TITLE_EDGE_INSET*2;
            
        }
        
        //在绘制之前保留一份最纯洁的ctx
        CGContextSaveGState(ctx);
        
        CGContextMoveToPoint(ctx, point_Start_End.x, point_Start_End.y);//1
        CGContextAddLineToPoint(ctx, point1.x, point1.y);//2
        CGContextAddLineToPoint(ctx, point2.x, point2.y);//3
        CGContextAddArc(ctx, tagArc1.center.x, tagArc1.center.y, tagCornerRadius, tagArc1.startAngle, tagArc1.endAngle, tagArc1.clockwise);//在point3和point4之间 插入圆弧
        CGContextAddLineToPoint(ctx, point3.x, point3.y);//4
        //===========================对称=================================//
        CGContextAddLineToPoint(ctx, point4.x, point4.y);//5
        CGContextAddArc(ctx, tagArc2.center.x, tagArc2.center.y, tagCornerRadius, tagArc2.startAngle, tagArc2.endAngle, tagArc2.clockwise);//在point5和point6之间 插入圆弧
        CGContextAddLineToPoint(ctx, point5.x, point5.y);//6
        CGContextAddLineToPoint(ctx, point6.x, point6.y);//6
        CGContextAddLineToPoint(ctx, point_Start_End.x, point_Start_End.y);//6
        [[[UIColor blackColor]colorWithAlphaComponent:0.6] setFill];
        
        CGContextFillPath(ctx);
        //CGContextStrokePath(ctx);
        //CGContextDrawPath(ctx, kCGPathFillStroke);
        
        //绘制完以后清除掉修改过的ctx，还原最原始最纯洁的ctx
        CGContextRestoreGState(ctx);
        
        CGRect titleRect = CGRectMake(titleRect_x, TITLE_EDGE_INSET, [self titleSize].width, [self titleSize].height);
        [self.title drawInRect:titleRect withAttributes:[self attributes]];
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.tagDirectionByInput == ZPTagDirectionByInputUnkonwn) {
        if (self.targetPointLocationInSuperview.x<=self.superview.bounds.size.width/2.0) {
            self.tagDirectionByPlace = ZPTagDirectionByPlaceLeft;
        }else{
            self.tagDirectionByPlace = ZPTagDirectionByPlaceRight;
        }
    }else{
        [self setNeedsDisplay];
        [self resetDirectionAndFrame];
    }
    
    //第一次出现的时候让其成为编辑状态
    if (self.tagUserInteractionMode == ZPTagUserInteractionModeEdit && self.isFirstTimeAppear && self.title.length==0) {
        [self edit];
        self.isFirstTimeAppear = false;
    }
}

#pragma mark - set/get方法

#pragma mark set tagUserInteractionMode
-(void)setTagUserInteractionMode:(ZPTagUserInteractionMode)tagUserInteractionMode{
    _tagUserInteractionMode = tagUserInteractionMode;
    
    switch (_tagUserInteractionMode) {
        case ZPTagUserInteractionModeClick:
        {
            [self addGestureRecognizer:self.tapGR];
            [self removeGestureRecognizer:self.panGR];
            self.userInteractionEnabled = YES;
        }
            break;
        case ZPTagUserInteractionModeEdit:
        {
            [self addGestureRecognizer:self.tapGR];
            [self addGestureRecognizer:self.panGR];
            self.userInteractionEnabled = YES;
        }
            break;
        case ZPTagUserInteractionModeClose:
        {
            [self removeGestureRecognizer:self.tapGR];
            [self removeGestureRecognizer:self.panGR];
            self.userInteractionEnabled = NO;
        }
            break;
    }
}

#pragma mark set tagDirectionByInput
//只有用户主动设置此值，才会调用这个方法，主动设置此值不可能为Unkonwn
- (void)setTagDirectionByInput:(ZPTagDirectionByInput)tagDirectionByInput{
    if (tagDirectionByInput == ZPTagDirectionByInputUnkonwn) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"标签方向设置有问题!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [self removeFromSuperview];
    }else{
        _tagDirectionByInput = tagDirectionByInput;//如果用户有主动设置位置，则把self.tagDirectionByPlace = ZPTagDirectionByPlaceUnkonwn;
        self.tagDirectionByPlace = ZPTagDirectionByPlaceUnkonwn;
        [self resetDirectionAndFrame];
        [self setNeedsDisplay];
    }
}

#pragma mark set tagDirectionByPlace
//当用户没有主动设置箭头方向的时候，会自动在layoutSubviews方法中设置此值，此时自动生成的值也不可能为Unknown
- (void)setTagDirectionByPlace:(ZPTagDirectionByPlace)tagDirectionByPlace{
    _tagDirectionByPlace = tagDirectionByPlace;
    if (_tagDirectionByPlace != ZPTagDirectionByPlaceUnkonwn) {
        [self resetDirectionAndFrame];
        [self setNeedsDisplay];
    }
    
}

#pragma mark set title
-(void)setTitle:(NSString *)title{
    _title = title;
    if (_title.length>0) {
        if (self.isFirstTimeAppear) {
            [self resetDirectionAndFrame];
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, (tagHeight/2.0+animateCircleCenter_TagTip_Margin)+tagHeight/2.0+[self titleSize].width+TITLE_EDGE_INSET*2.5, tagHeight);
    }else{
        [self removeFromSuperview];
    }
}

- (void)resetDirectionAndFrame{
    CGRect frame = self.frame;
    CGPoint position = CGPointZero;
    if (self.tagDirectionByInput == ZPTagDirectionByInputLeft || self.tagDirectionByPlace == ZPTagDirectionByPlaceLeft) {//点在左边区域 箭头向左
        frame.origin.x = self.targetPointLocationInSuperview.x-tagHeight/2.0;
        position = CGPointMake(tagHeight/2.0, tagHeight/2.0);
    }else if (self.tagDirectionByInput == ZPTagDirectionByInputRight|| self.tagDirectionByPlace == ZPTagDirectionByPlaceRight){//点在右边区域，箭头向右
        frame.origin.x = self.targetPointLocationInSuperview.x-(frame.size.width-tagHeight/2.0);
        position = CGPointMake(frame.size.width - tagHeight/2.0, tagHeight/2.0);
    }
    self.frame = frame;
    
    // 关闭隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.animateCircleBack.position = position;
    self.animateCircleFore.position = position;
    [CATransaction commit];
}

- (CGSize)titleSize{
    
    //sizeWithAttributes 方法是计算的一行平铺后的宽度
    return [self.title sizeWithAttributes:[self attributes]];
    
    //boundingRectWithSize 方法一般是计算的是多行的宽高
    //CGRect rect = [self.title boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:[self attributes] context:nil];
    //return rect.size.width;
}
- (NSDictionary *)attributes{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:titleFont];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
    return attributes;
}

#pragma mark get targetPointLocationInSuperview
-(CGPoint)targetPointLocationInSuperview{
    if (self.superview) {
        return [self convertPoint:self.animateCircleFore.position toView:self.superview];
    }else{
        return CGPointMake(self.frame.origin.x+tagHeight/2.0, self.frame.origin.y+tagHeight/2.0);
    }
}

#pragma mark get tapGR

-(UITapGestureRecognizer *)tapGR{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction:)];
    }
    return _tapGR;
}

#pragma mark get panGR

-(UIPanGestureRecognizer *)panGR{
    if (!_panGR) {
        _panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGRAction:)];
    }
    return _panGR;
}

#pragma mark - UIMenuItemActions
- (void)remove{
    [self removeFromSuperview];
}
- (void)edit{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickTag:)]) {
        [self.delegate didClickTag:self];
    }
}
#pragma mark UIMenuItemActions 需要实现的额外方法
-(BOOL)canBecomeFirstResponder {
    return YES;
}
// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(remove) || action == @selector(edit)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - dealloc

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kZPTagViewWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

@end
