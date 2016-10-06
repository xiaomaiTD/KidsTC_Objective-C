//
//  StrategyTableViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
@interface StrategyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

@property (weak, nonatomic) IBOutlet UIView *likeBtnBGClipView;
@property (weak, nonatomic) IBOutlet UIView *likeBtnBGShadowView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipConstraintLeading;
@end

@implementation StrategyTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bgView.layer.borderWidth = LINE_H;
    
    CALayer *likeBtnBGClipViewLayer = self.likeBtnBGClipView.layer;
    likeBtnBGClipViewLayer.cornerRadius = CGRectGetHeight(self.likeBtnBGClipView.frame)*0.5;
    likeBtnBGClipViewLayer.masksToBounds = YES;
    
    CALayer *likeBtnBGShadowViewLayer = self.likeBtnBGShadowView.layer;
    likeBtnBGShadowViewLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    likeBtnBGShadowViewLayer.cornerRadius = CGRectGetHeight(self.likeBtnBGShadowView.frame)*0.5;
    likeBtnBGShadowViewLayer.shadowColor = [UIColor whiteColor].CGColor;
    likeBtnBGShadowViewLayer.shadowOffset=CGSizeMake(2, 2);
    likeBtnBGShadowViewLayer.shadowOpacity=0.5;
    likeBtnBGShadowViewLayer.shadowRadius=5;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.6].CGColor,(id)[UIColor clearColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = self.titleLabel.layer.frame;
    self.gradientLayer = gradientLayer;
    [self.bgView.layer insertSublayer:gradientLayer below:self.titleLabel.layer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView layoutIfNeeded];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.gradientLayer.frame = self.titleLabel.frame;
    [CATransaction commit];
}

- (void)setItem:(StrategyListItem *)item{
    _item = item;
    if (item.image) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:PLACEHOLDERIMAGE_BIG];
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"   %@",item.title];
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",item.interestCount] forState:UIControlStateNormal];
    
    NSString *likeBtnImageName = item.isInterest?@"strategory_love_true":@"strategory_love_false";
    
    [self.likeBtn setImage:[UIImage imageNamed:likeBtnImageName] forState:UIControlStateNormal];

    if (item.isNew || item.isHot) {
        self.tipImageView.hidden = NO;
        if (item.isNew) {
            self.tipImageView.image = [UIImage imageNamed:@"strategory_new"];
            self.tipConstraintLeading.constant = 1.5;
        }else if (item.isHot){
            self.tipImageView.image = [UIImage imageNamed:@"strategory_hot"];
            self.tipConstraintLeading.constant = -8;
        }
        
    }else{
        self.tipImageView.hidden = YES;
    }
}

- (IBAction)likeBtnAction:(StrategyLikeButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(strategyTableViewCell:didClickOnStrategyLikeButton:)]) {
        [self.delegate strategyTableViewCell:self didClickOnStrategyLikeButton:sender];
    }
    
    
}

@end
