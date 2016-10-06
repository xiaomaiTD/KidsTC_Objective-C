//
//  StoreDetialMapPoiAnnotationView.m
//  KidsTC
//
//  Created by zhanping on 8/3/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetialMapPoiAnnotationView.h"

@interface StoreDetialMapPoiAnnotationView ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation StoreDetialMapPoiAnnotationView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.gotoBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setItem:(KTCLocation *)item{
    _item = item;
    self.contentLabel.text = item.locationDescription;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(storeDetialMapPoiAnnotationViewDidClickGotoBtn:)]) {
        [self.delegate storeDetialMapPoiAnnotationViewDidClickGotoBtn:self];
    }
}


@end
