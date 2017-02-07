//
//  ProductDetailNaviView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductDetailNaviView.h"
#import "UIImage+Category.h"

CGFloat const kProductDetailNaviViewH = 64;

@interface ProductDetailNaviView ()
@property (weak, nonatomic) IBOutlet UIView *backBGView;
@property (weak, nonatomic) IBOutlet UIView *rightBGView;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;


@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIImageView *timeImg;
@property (weak, nonatomic) IBOutlet UIImageView *moreImg;

@property (nonatomic, assign) BOOL isClearNavi;

@end

@implementation ProductDetailNaviView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.lineH.constant = LINE_H;
    
    self.backBGView.layer.cornerRadius = CGRectGetHeight(self.backBGView.bounds) * 0.5;
    self.backBGView.layer.masksToBounds = YES;
    
    self.rightBGView.layer.cornerRadius = CGRectGetHeight(self.rightBGView.bounds) * 0.5;
    self.rightBGView.layer.masksToBounds = YES;
    
    self.backBtn.tag = ProductDetailNaviViewActionTypeBack;
    self.timeBtn.tag = ProductDetailNaviViewActionTypeTime;
    self.moreBtn.tag = ProductDetailNaviViewActionTypeMore;
    
}

- (void)didScroll:(CGFloat)offsety {
    CGFloat scale = offsety/200.0;
    
    if (scale<0) scale = 0;
    if (scale>1) scale = 1;
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:scale];
    UIColor *pinkColor = [[UIColor colorFromHexString:@"ff8888"] colorWithAlphaComponent:0.8*(1-scale)];
    self.backBGView.backgroundColor = pinkColor;
    self.rightBGView.backgroundColor = pinkColor;
    self.nameL.textColor = [[UIColor blackColor] colorWithAlphaComponent:scale];
    
    UIColor *imageColor = [UIColor colorWithWhite:(1-scale) alpha:1];
    self.backImg.image = [[UIImage imageNamed:@"navi_back_white"] imageWithTintColor:imageColor];
    self.timeImg.image = [[UIImage imageNamed:@"ProductDetail_ticket_time"] imageWithTintColor:imageColor];
    self.moreImg.image = [[UIImage imageNamed:@"ProductDetail_navi_more_white"] imageWithTintColor:imageColor];
    
    self.line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:scale];
}


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailNaviView:actionType:value:)]) {
        [self.delegate productDetailNaviView:self actionType:sender.tag value:nil];
    }
}

@end
