//
//  FailureViewLoadData.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/4.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FailureViewLoadData.h"

@interface FailureViewLoadData ()
@property (weak, nonatomic) IBOutlet UIImageView *networkLogo;
@property (weak, nonatomic) IBOutlet UIImageView *refreshLogo;
@property (weak, nonatomic) IBOutlet UIView *networkBtn;
@property (weak, nonatomic) IBOutlet UIView *refreshBtn;

@end

@implementation FailureViewLoadData

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    [self addBorder:self.networkLogo.layer];
    [self addBorder:self.refreshLogo.layer];
    
    self.networkLogo.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.refreshLogo.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addTarget:self.networkBtn type:FailureViewLoadDataActionTypeCheckNetWork];
    [self addTarget:self.refreshBtn type:FailureViewLoadDataActionTypeRefresh];
    
}

- (void)addBorder:(CALayer *)layer {
    layer.cornerRadius = CGRectGetWidth(layer.bounds) * 0.5;
    //layer.masksToBounds = YES;
    layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    layer.borderWidth = LINE_H;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowRadius = 2;
    layer.shadowOpacity = 0.5;
}

- (void)addTarget:(UIView *)view type:(FailureViewLoadDataActionType)type{
    view.tag = type;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [view addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    UIView *view = tapGR.view;
    if (self.actionBlock) {
        self.actionBlock(self,view.tag);
    }
}

@end
