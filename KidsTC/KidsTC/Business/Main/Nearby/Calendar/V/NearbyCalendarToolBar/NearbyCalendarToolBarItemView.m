//
//  NearbyCalendarToolBarItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBarItemView.h"

@interface NearbyCalendarToolBarItemView ()
@property (nonatomic,weak) IBOutlet UIImageView *icon;
@property (nonatomic,weak) IBOutlet UILabel *titleL;
@property (nonatomic,weak) IBOutlet UIImageView *arrowImg;
@property (nonatomic,weak) IBOutlet UIButton *btn;

@property (nonatomic, strong) NSMutableDictionary *titleColorDic;
@property (nonatomic, strong) NSMutableDictionary *iconImageDic;
@property (nonatomic, strong) NSMutableDictionary *arrowImageDic;
@end

@implementation NearbyCalendarToolBarItemView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTitle:(NSString *)title {
    self.titleL.text = title;
}

- (void)setState:(UIControlState)state {
    _state = state;
    self.titleL.textColor = [_titleColorDic objectForKey:@(_state)];
    self.icon.image = [_iconImageDic objectForKey:@(_state)];
    self.arrowImg.image = [_arrowImageDic objectForKey:@(_state)];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    if (!color) return;
    if (!_titleColorDic) _titleColorDic = [NSMutableDictionary dictionary];
    [_titleColorDic setObject:color forKey:@(state)];
}
- (void)setIconImage:(UIImage *)image forState:(UIControlState)state {
    if (!image) return;
    if (!_iconImageDic) _iconImageDic = [NSMutableDictionary dictionary];
    [_iconImageDic setObject:image forKey:@(state)];
}
- (void)setArrowImage:(UIImage *)image forState:(UIControlState)state {
    if (!image) return;
    if (!_arrowImageDic) _arrowImageDic = [NSMutableDictionary dictionary];
    [_arrowImageDic setObject:image forKey:@(state)];
}

- (IBAction)action:(id)sender {
    if (self.actionBlock) self.actionBlock(self);
}

@end
