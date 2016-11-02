//
//  ProductDetailInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailInfoCell.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "UIColor+Category.h"
#import "YYKit.h"

@interface ProductDetailInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderL;
@property (weak, nonatomic) IBOutlet YYLabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;
@property (weak, nonatomic) IBOutlet UILabel *saleNumL;
@property (weak, nonatomic) IBOutlet UILabel *priceNameL;
@end

@implementation ProductDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    self.commentNumL.textColor = PRODUCT_DETAIL_BLUE;
    self.saleNumL.textColor = PRODUCT_DETAIL_BLUE;
    self.contentL.numberOfLines = 0;
    self.priceNameL.textColor = COLOR_PINK;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.nameL.attributedText = data.attServeName;
    self.priceL.text = data.priceStr;
    self.priceNameL.text = data.priceSortName;
    self.commentNumL.text = [NSString stringWithFormat:@"%zd",data.evaluate];
    self.saleNumL.text = [NSString stringWithFormat:@"%zd",data.saleCount];
    WeakSelf(self)
    NSMutableAttributedString *attPromote = [[NSMutableAttributedString alloc] initWithAttributedString:data.attPromote];
    [data.promotionLink enumerateObjectsUsingBlock:^(ProductDetailPromotionLink *obj, NSUInteger idx, BOOL *stop) {
        StrongSelf(self)
        NSRange range = [data.promote rangeOfString:obj.linkKey];
        [attPromote setUnderlineStyle:NSUnderlineStyleSingle range:range];
        UIColor *color = [UIColor colorWithRGBString:obj.color];
        if (!color) color = COLOR_PINK;
        [attPromote setTextHighlightRange:range
                                    color:color
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
                                        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeSegue value:obj.segueModel];
                                    }
                                }];
    }];
    self.contentL.attributedText = attPromote;
    self.placeHolderL.attributedText = attPromote;
}


@end
