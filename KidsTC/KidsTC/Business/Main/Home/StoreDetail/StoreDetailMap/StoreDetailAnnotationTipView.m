//
//  StoreDetailAnnotationTipView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "StoreDetailAnnotationTipView.h"
#import "UIImageView+WebCache.h"

@interface StoreDetailAnnotationTipView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;

@end
@implementation StoreDetailAnnotationTipView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.gotoBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [self.showBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    self.HLineConstranitHeight.constant = LINE_H;
    self.gotoBtn.tag = StoreDetailAnnotationTipViewActionTypeGoto;
    self.showBtn.tag = StoreDetailAnnotationTipViewActionTypeShow;
    
    self.iconImageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
}

- (void)setModel:(StoreListItemModel *)model{
    _model = model;
    self.titleLabel.text = model.storeName;
    self.contentLabel.text = model.location.moreDescription;
    [self.iconImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(storeDetailAnnotationTipView:actionType:)]) {
        [self.delegate storeDetailAnnotationTipView:self actionType:(StoreDetailAnnotationTipViewActionType)sender.tag];
    }
    
}

@end
