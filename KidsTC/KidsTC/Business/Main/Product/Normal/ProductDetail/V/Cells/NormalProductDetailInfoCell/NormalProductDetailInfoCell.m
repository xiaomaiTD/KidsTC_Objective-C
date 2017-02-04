//
//  NormalProductDetailInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailInfoCell.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"
#import "UIColor+Category.h"
#import "YYKit.h"

@interface NormalProductDetailInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderL;
@property (weak, nonatomic) IBOutlet YYLabel *contentL;

@end

@implementation NormalProductDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentL.numberOfLines = 0;
}

- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    self.nameL.attributedText = data.attServeName;
    WeakSelf(self)
    NSMutableAttributedString *attPromote = [[NSMutableAttributedString alloc] initWithAttributedString:data.attPromote];
    [data.promotionLink enumerateObjectsUsingBlock:^(NormalProductDetailPromotionLink *obj, NSUInteger idx, BOOL *stop) {
        StrongSelf(self)
        NSRange range = [data.promote rangeOfString:obj.linkKey];
        [attPromote setUnderlineStyle:NSUnderlineStyleSingle range:range];
        UIColor *color = [UIColor colorWithRGBString:obj.color];
        if (!color) color = COLOR_PINK;
        [attPromote setTextHighlightRange:range
                                    color:color
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
                                        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeSegue value:obj.segueModel];
                                    }
                                }];
    }];
    self.contentL.attributedText = attPromote;
    self.placeHolderL.attributedText = attPromote;
}


@end
