//
//  MapLocateAnnotationTipView.m
//  KidsTC
//
//  Created by 詹平 on 16/7/24.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "MapLocateAnnotationTipView.h"

@interface MapLocateAnnotationTipView ()
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation MapLocateAnnotationTipView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.cancleBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    
    self.cancleBtn.tag = MapLocateAnnotationTipViewActionTypeCancle;
    self.sureBtn.tag = MapLocateAnnotationTipViewActionTypeSure;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.deletate respondsToSelector:@selector(MapLocateAnnotationTipView:actionType:)]) {
        [self.deletate MapLocateAnnotationTipView:self actionType:(MapLocateAnnotationTipViewActionType)sender.tag];
    }
}

@end
