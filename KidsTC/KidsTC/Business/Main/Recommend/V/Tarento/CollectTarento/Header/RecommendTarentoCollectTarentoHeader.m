//
//  RecommendTarentoCollectTarentoHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendTarentoCollectTarentoHeader.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"
#import "User.h"

@interface RecommendTarentoCollectTarentoHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *signL;
@property (weak, nonatomic) IBOutlet UILabel *articleNumL;
@property (weak, nonatomic) IBOutlet UILabel *seeNumL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIView *toCollectBgView;
@end

@implementation RecommendTarentoCollectTarentoHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.signL.textColor = [UIColor colorFromHexString:@"888888"];
    self.articleNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.seeNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    
    self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    self.collectBtn.layer.borderWidth = 1;
    self.collectBtn.layer.cornerRadius = 2;
    self.collectBtn.layer.masksToBounds = YES;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoHeader:actionType:value:)]) {
        [self.delegate recommendTarentoCollectTarentoHeader:self actionType:RecommendTarentoCollectTarentoHeaderActionTypeUserArticleCenter value:_tarento];
    }
}

- (IBAction)collect:(UIButton *)sender {
    [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoHeader:actionType:value:)]) {
            [self.delegate recommendTarentoCollectTarentoHeader:self actionType:RecommendTarentoCollectTarentoHeaderActionTypeCollect value:_tarento];
        }
        _tarento.isCollected = !_tarento.isCollected;
        [self setupInterestStatus];
    }];
}

- (void)setTarento:(RecommendTarento *)tarento {
    _tarento = tarento;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_tarento.headSculpture] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = _tarento.authorName;
    self.signL.text = _tarento.authorSign;
    self.articleNumL.text = _tarento.publishArticleNum;
    self.seeNumL.text = _tarento.viewSumNum;
    [self setupInterestStatus];
}

- (void)setupInterestStatus {
    if (_tarento.isCollected) {
        self.toCollectBgView.hidden = YES;
        self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"BBBBBB"].CGColor;
    }else{
        self.toCollectBgView.hidden = NO;
        self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    }
}

@end
