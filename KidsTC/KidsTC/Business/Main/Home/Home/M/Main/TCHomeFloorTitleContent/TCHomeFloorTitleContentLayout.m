//
//  TCHomeFloorTitleContentLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorTitleContentLayout.h"
#import "TCHomeFloorTitleContent.h"
#import "NSString+Category.h"

@interface TCHomeFloorTitleContentLayout ()
@property (nonatomic, weak) TCHomeFloorTitleContent *titleContent;
@end

@implementation TCHomeFloorTitleContentLayout
+ (instancetype)layout:(TCHomeFloorTitleContent *)titleContent {
    TCHomeFloorTitleContentLayout *layout = [TCHomeFloorTitleContentLayout new];
    layout.titleContent = titleContent;
    return layout;
}

- (void)setTitleContent:(TCHomeFloorTitleContent *)titleContent {
    _titleContent = titleContent;
    [self setupAttributes];
}

- (void)setupAttributes {
    
    CGFloat w = kTCHomeFloorTitleContentW;
    CGFloat h = kTCHomeFloorTitleContentH;
    
    switch (_titleContent.type) {
        case TCHomeFloorTitleContentTypeNormalTitle:
        case TCHomeFloorTitleContentTypeMoreTitle:
        {
            CGFloat margin = 8;
            
            if ([_titleContent.titleIconUrl isNotNull]) {
                if (_titleContent.titleIconRatio<=0) _titleContent.titleIconRatio = 1;
                CGFloat tipImageView_h = (h - 2 * margin) - 7;
                CGFloat tipImageView_x = margin;
                CGFloat tipImageView_y = (h - tipImageView_h) *0.5;
                CGFloat tipImageView_w = tipImageView_h/_titleContent.titleIconRatio;
                _tipImageViewFrame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_w, tipImageView_h);
            }else{
                CGFloat tipImageView_x = 0;
                CGFloat tipImageView_y = h * 0.25;
                CGFloat tipImageView_w = 2;
                CGFloat tipImageView_h = h * 0.5;
                _tipImageViewFrame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_w, tipImageView_h);
            }
            
            CGFloat titleLabel_x = CGRectGetMaxX(_tipImageViewFrame) + margin;
            CGFloat titleLabel_y = 0;
            CGFloat titleLabel_w = 140;
            CGFloat titleLabel_h = h;
            _titleLabelFrame = CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
            
            _remainLabelHidden = YES;
            _remainLabelFrame = CGRectZero;
            
            CGFloat arrowImageView_s = 13;
            CGFloat arrowImageView_x = w - arrowImageView_s - margin;
            CGFloat arrowImageView_y = (h - arrowImageView_s) * 0.5;
            _arrowImageViewFrame = CGRectMake(arrowImageView_x, arrowImageView_y, arrowImageView_s, arrowImageView_s);
            _arrowImageViewHidden = _titleContent.segueModel.destination == SegueDestinationNone;
            
            CGFloat subTitleLabel_x = CGRectGetMaxX(_titleLabelFrame) + margin;
            CGFloat subTitleLabel_y = 0;
            CGFloat subTitleLabel_w = w - subTitleLabel_x - arrowImageView_s - margin - 4;
            CGFloat subTitleLabel_h = h;
            _subTitleLabelFrame = CGRectMake(subTitleLabel_x, subTitleLabel_y, subTitleLabel_w, subTitleLabel_h);
        }
            break;
        case TCHomeFloorTitleContentTypeCountDownTitle:
        case TCHomeFloorTitleContentTypeCountDownMoreTitle:
        {
            CGFloat margin = 8;
            if (_titleContent.titleIconRatio<=0) _titleContent.titleIconRatio = 58/245.0;
            CGFloat tipImageView_h = 14;
            CGFloat tipImageView_x = margin;
            CGFloat tipImageView_y = (h - tipImageView_h) *0.5;
            CGFloat tipImageView_w = tipImageView_h/_titleContent.titleIconRatio;
            _tipImageViewFrame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_w, tipImageView_h);
            
            CGFloat titleLabel_x = CGRectGetMaxX(_tipImageViewFrame) + margin;
            CGFloat titleLabel_y = 0;
            CGFloat titleLabel_w = [_titleContent.showPiece.attName size].width;
            CGFloat titleLabel_h = h;
            _titleLabelFrame = CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
            
            _remainLabelHidden = NO;
            CGFloat remainLabel_x = CGRectGetMaxX(_titleLabelFrame) + margin;
            CGFloat remainLabel_w = 0;
            CGFloat remainLabel_h = 18;
            CGFloat remainLabel_y = (h - remainLabel_h) * 0.5;
            _remainLabelFrame = CGRectMake(remainLabel_x, remainLabel_y, remainLabel_w, remainLabel_h);
            
            CGFloat arrowImageView_s = 13;
            CGFloat arrowImageView_x = w - arrowImageView_s - margin;
            CGFloat arrowImageView_y = (h - arrowImageView_s) * 0.5;
            _arrowImageViewFrame = CGRectMake(arrowImageView_x, arrowImageView_y, arrowImageView_s, arrowImageView_s);
            _arrowImageViewHidden = _titleContent.segueModel.destination == SegueDestinationNone;
            
            CGFloat subTitleLabel_x = CGRectGetMaxX(_remainLabelFrame) + margin + 120;
            CGFloat subTitleLabel_y = 0;
            CGFloat subTitleLabel_w = arrowImageView_x - subTitleLabel_x - margin;
            CGFloat subTitleLabel_h = h;
            _subTitleLabelFrame = CGRectMake(subTitleLabel_x, subTitleLabel_y, subTitleLabel_w, subTitleLabel_h);
        }
            break;
        case TCHomeFloorTitleContentTypeRecommend:
        {
            CGFloat margin = 8;
            CGFloat tipImageView_s = (h - 2 * margin) - 7;
            CGFloat tipImageView_x = margin;
            CGFloat tipImageView_y = (h - tipImageView_s) *0.5;
            _tipImageViewFrame = CGRectMake(tipImageView_x, tipImageView_y, tipImageView_s, tipImageView_s);
            
            CGFloat titleLabel_x = CGRectGetMaxX(_tipImageViewFrame) + margin;
            CGFloat titleLabel_y = 0;
            CGFloat titleLabel_w = 140;
            CGFloat titleLabel_h = h;
            _titleLabelFrame = CGRectMake(titleLabel_x, titleLabel_y, titleLabel_w, titleLabel_h);
            
            _remainLabelHidden = YES;
            _remainLabelFrame = CGRectZero;
            
            _arrowImageViewHidden = YES;
            _arrowImageViewFrame = CGRectZero;
            
            CGFloat subTitleLabel_x = CGRectGetMaxX(_tipImageViewFrame) + margin;
            CGFloat subTitleLabel_y = 0;
            CGFloat subTitleLabel_w = w - subTitleLabel_x - margin;
            CGFloat subTitleLabel_h = h;
            _subTitleLabelFrame = CGRectMake(subTitleLabel_x, subTitleLabel_y, subTitleLabel_w, subTitleLabel_h);
        }
            break;
    }
    _lineFrame = CGRectMake(0, h - LINE_H, w, LINE_H);
}

@end
