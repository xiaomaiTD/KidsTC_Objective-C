//
//  ProductDetailTwoColumnBottomBarCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnBottomBarCell.h"

@interface ProductDetailTwoColumnBottomBarCell ()
@property (weak, nonatomic) IBOutlet UIButton *moreConsultBtn;

@property (weak, nonatomic) IBOutlet UIView *openDetailView;
@property (weak, nonatomic) IBOutlet UIButton *openDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *openDetailL;
@property (nonatomic, assign) BOOL webViewHasOpen;

@end

@implementation ProductDetailTwoColumnBottomBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    self.showType = ProductDetailTwoColumnShowTypeDetail;
    
    self.moreConsultBtn.layer.borderWidth = LINE_H;
    self.moreConsultBtn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    [self.moreConsultBtn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.openDetailL.textColor = PRODUCT_DETAIL_BLUE;
}

- (void)setShowType:(ProductDetailTwoColumnShowType)showType {
    _showType = showType;
    switch (showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            if (_webViewHasOpen) {
                self.openDetailView.hidden = YES;
            }else{
                self.openDetailView.hidden = NO;
            }
            self.moreConsultBtn.hidden = YES;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            self.openDetailView.hidden = YES;
            self.moreConsultBtn.hidden = NO;
        }
            break;
    }
}

- (IBAction)moreConsult:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeMoreConsult value:nil];
    }
}

- (IBAction)openWebView:(UIButton *)sender {
    if (_webViewHasOpen) return;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeOpenWebView value:nil];
    }
    _webViewHasOpen = YES;
    self.openDetailView.hidden = YES;
}


@end
