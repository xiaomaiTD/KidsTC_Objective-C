//
//  ProductOrderTicketDetailDeliverCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailDeliverCell.h"
#import "NSString+Category.h"
#import "YYKit.h"
#import "Colours.h"

@interface ProductOrderTicketDetailDeliverCell ()
@property (weak, nonatomic) IBOutlet UILabel *placeL;
@property (weak, nonatomic) IBOutlet YYLabel *deliverL;
@property (weak, nonatomic) IBOutlet UIView *deliverBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deliverBGViewH;
@end

@implementation ProductOrderTicketDetailDeliverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    ProductOrderTicketDetailDeliver *deliver = self.data.deliver;
    if ([deliver.deliverStr isNotNull]) {
        self.deliverBGView.hidden = NO;
        [self settupDeliverInfo];
    }else{
        self.deliverBGView.hidden = YES;
        self.deliverBGViewH.constant = 0;
        self.deliverL.attributedText = nil;
        self.placeL.attributedText = nil;
    }
}

- (void)settupDeliverInfo {
    WeakSelf(self)
    NSMutableAttributedString *attDeliverInfo = [[NSMutableAttributedString alloc] initWithString:self.data.deliver.deliverStr];
    attDeliverInfo.color = [UIColor colorFromHexString:@"555555"];
    attDeliverInfo.font = [UIFont systemFontOfSize:12];
    attDeliverInfo.lineSpacing = 6;
    [self.data.deliver.items enumerateObjectsUsingBlock:^(ProductOrderTicketDetailDeliverItem *obj, NSUInteger idx, BOOL *stop) {
        StrongSelf(self)
        NSRange range = [self.data.deliver.deliverStr rangeOfString:obj.value];
        if ((obj.isCall&&[obj.value isNotNull])||obj.segueModel) {
            [attDeliverInfo setUnderlineStyle:NSUnderlineStyleSingle range:range];
        }
        UIColor *color = [UIColor colorFromHexString:obj.color];
        if (!color) color = COLOR_PINK;
        [attDeliverInfo setTextHighlightRange:range
                                        color:color
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        if (![self.delegate respondsToSelector:@selector(productOrderTicketDetailBaseCell:actionType:value:)]) return;
                                        if (obj.isCall) {
                                            if (![obj.value isNotNull]) return;
                                            [self.delegate productOrderTicketDetailBaseCell:self actionType:ProductOrderTicketDetailBaseCellActionTypeDeliberCall value:obj.value];
                                        }else{
                                            [self.delegate productOrderTicketDetailBaseCell:self actionType:ProductOrderTicketDetailBaseCellActionTypeSegue value:obj.segueModel];
                                        }
                                    }];
    }];
    self.deliverL.attributedText = attDeliverInfo;
    self.placeL.attributedText = attDeliverInfo;
    self.deliverBGViewH.constant = [attDeliverInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - (39+15), 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 30;
}

@end
