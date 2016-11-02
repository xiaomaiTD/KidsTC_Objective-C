//
//  HomeRefreshGuideView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshGuideView.h"

@interface HomeRefreshGuideView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTopConstrantTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation HomeRefreshGuideView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self layoutIfNeeded];
    [NotificationCenter addObserver:self selector:@selector(homeViewControllerDidScroll:) name:kHomeViewControllerDidScroll object:nil];
    [NotificationCenter addObserver:self selector:@selector(homeViewControllerDidEndDrag:) name:kHomeViewControllerDidEndDrag object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgTopConstrantTop.constant = self.top;
}

- (void)homeViewControllerDidScroll:(NSNotification *)obj {
    CGPoint offset = self.scrollView.contentOffset;
    if (obj.name == kHomeViewControllerDidScroll) {
        CGFloat y = [obj.object floatValue];
        if (y>0) y = 0;
        offset.y = y;
        self.scrollView.contentOffset = offset;
    }
}

- (void)homeViewControllerDidEndDrag:(NSNotification *)obj {
    CGRect frame = self.frame;
    frame.origin.y = SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if(self.resultBlock)self.resultBlock();
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kHomeViewControllerDidScroll object:nil];
    [NotificationCenter removeObserver:self name:kHomeViewControllerDidEndDrag object:nil];
}

@end
