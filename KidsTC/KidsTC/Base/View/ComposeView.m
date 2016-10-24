//
//  ComposeView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeView.h"
#import "ComposeButton.h"

static CGFloat const kAnimationDuration = 0.3;
static CGFloat const kSleepDuration = 0.1;

@interface ComposeView ()
@property (nonatomic, strong) NSArray<ComposeButton *> *btns;

@property (nonatomic, strong) UIDynamicAnimator *dynamicBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@end

@implementation ComposeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtns];
        _dynamicBehavior = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (void)setupBtns {
    
    NSMutableArray<ComposeButton *> *btns = [NSMutableArray array];
    
    ComposeButton *composeBtn = [ComposeButton btn:ComposeButtonTypeCompose];
    composeBtn.backgroundColor = [UIColor redColor];
    composeBtn.tag = ComposeButtonTypeCompose;
    [composeBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:composeBtn];
    [btns addObject:composeBtn];
    
    ComposeButton *signBtn = [ComposeButton btn:ComposeButtonTypeSign];
    signBtn.backgroundColor = [UIColor greenColor];
    signBtn.tag = ComposeButtonTypeSign;
    [signBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signBtn];
    [btns addObject:signBtn];
    
    self.btns = [NSArray arrayWithArray:btns];
}

- (void)action:(UIButton *)btn {
    [self hide];
    if ([self.delegate respondsToSelector:@selector(composeView:actionType:value:)]) {
        [self.delegate composeView:self actionType:btn.tag value:nil];
    }
}

- (void)show {
    
    self.hidden = NO;
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    CGFloat margin_b = 150;
    CGFloat btn_w = 50;
    CGFloat btn_h = 50;
    CGFloat btn_y = self_h - btn_h - margin_b;
    
    NSUInteger count = self.btns.count;
    [self.btns enumerateObjectsUsingBlock:^(ComposeButton *obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat margin_h = (self_w - btn_w * count) / (count + 1);
        CGFloat btn_x = margin_h + (margin_h + btn_w) * idx;
        
        obj.frame = CGRectMake(self_w * 0.5, self_h, 0, 0);
        obj.alpha = 0.0;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            obj.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
            obj.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
        
        [NSThread sleepForTimeInterval:kSleepDuration];
        
        //        [self.dynamicBehavior removeBehavior:self.snapBehavior];
        //        self.snapBehavior = [[UISnapBehavior alloc]initWithItem:obj snapToPoint:point];
        //        self.snapBehavior.damping = 0.8;
        //        [self.dynamicBehavior addBehavior:self.snapBehavior];
        
    }];
    
}

- (void)hide {
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    CGFloat margin_b = 150;
    CGFloat btn_w = 50;
    CGFloat btn_h = 50;
    CGFloat btn_y = self_h - btn_h - margin_b;
    
    NSUInteger count = self.btns.count;
    [self.btns enumerateObjectsUsingBlock:^(ComposeButton *obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat margin_h = (self_w - btn_w * count) / (count + 1);
        CGFloat btn_x = margin_h + (margin_h + btn_w) * idx;
        
        obj.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
        obj.alpha = 1.0;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            obj.frame = CGRectMake(self_w * 0.5, self_h, 0, 0);
            obj.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        
        [NSThread sleepForTimeInterval:kSleepDuration];
        
        //        [self.dynamicBehavior removeBehavior:self.snapBehavior];
        //        self.snapBehavior = [[UISnapBehavior alloc]initWithItem:obj snapToPoint:point];
        //        self.snapBehavior.damping = 0.8;
        //        [self.dynamicBehavior addBehavior:self.snapBehavior];
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kAnimationDuration + kSleepDuration * count) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

@end
