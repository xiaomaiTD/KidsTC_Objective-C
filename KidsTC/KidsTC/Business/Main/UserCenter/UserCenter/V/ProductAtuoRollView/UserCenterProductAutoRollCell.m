//
//  AutoRollCell.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "UserCenterProductAutoRollCell.h"
#import "ToolBox.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@implementation UserCenterProductAutoRollCell

-(void)awakeFromNib{
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.layer.cornerRadius = 4;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        view.layer.borderWidth = LINE_H;
        view.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction:)];
        [view addGestureRecognizer:tapGR];
    }];
    
    UIColor *color = COLOR_PINK;
    self.priceLabelOne.textColor = color;
    self.priceLabelTwo.textColor = color;
    self.priceLabelThree.textColor = color;
    
    UIColor *numLabelTextColor = COLOR_BLUE;
    self.saleNumLabelOne.textColor = numLabelTextColor;
    self.saleNumLabelTwo.textColor = numLabelTextColor;
    self.saleNumLabelThree.textColor = numLabelTextColor;
    
    self.productNameLabelOne.backgroundColor = [UIColor clearColor];
    self.productNameLabelTwo.backgroundColor = [UIColor clearColor];
    self.productNameLabelThree.backgroundColor = [UIColor clearColor];
    
    [ToolBox renderGradientForView:self.productNameLabelOne displayFrame:CGRectMake(0, 0, self.productNameLabelOne.frame.size.width, self.productNameLabelOne.frame.size.height) startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:[NSArray arrayWithObjects:RGBA(0, 0, 0, 0), RGBA(0, 0, 0, 0.8), nil] locations:nil];
    
    [ToolBox renderGradientForView:self.productNameLabelTwo displayFrame:CGRectMake(0, 0, self.productNameLabelTwo.frame.size.width, self.productNameLabelTwo.frame.size.height) startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:[NSArray arrayWithObjects:RGBA(0, 0, 0, 0), RGBA(0, 0, 0, 0.8), nil] locations:nil];
    
    [ToolBox renderGradientForView:self.productNameLabelThree displayFrame:CGRectMake(0, 0, self.productNameLabelThree.frame.size.width, self.productNameLabelThree.frame.size.height) startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:[NSArray arrayWithObjects:RGBA(0, 0, 0, 0), RGBA(0, 0, 0, 0.8), nil] locations:nil];
}

- (void)setProductType:(UserCenterHotProductType)productType{
    _productType = productType;
    switch (productType) {
        case UserCenterHotProductTypeCarrot:
        {
            self.iconImageViewWidthOne.constant = 20;
            self.iconImageViewWidthTwo.constant = 20;
            self.iconImageViewWidthThree.constant = 20;
        }
            break;
            
        default:
        {
            self.iconImageViewWidthOne.constant = 0;
            self.iconImageViewWidthTwo.constant = 0;
            self.iconImageViewWidthThree.constant = 0;
        }
            break;
    }
}

- (void)setItems:(NSArray<UserCenterProductLsItem *> *)items{
    _items = items;
    NSUInteger count = items.count;
    [self.itemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger viewIdx, BOOL * viewStop) {
        if (viewIdx<count) {
            UserCenterProductLsItem *item = items[viewIdx];
            view.hidden = NO;
            if (viewIdx == 0) {
                [self.productImageViewOne  sd_setImageWithURL:[NSURL URLWithString:item.productImg] placeholderImage:[UIImage imageNamed:@"nocomment"]];
                self.productNameLabelOne.text = item.productName;
                self.priceLabelOne.text = [NSString stringWithFormat:@" ¥%0.0f",item.price];
                self.saleNumLabelOne.text = [NSString stringWithFormat:@"%ld",item.saleNum];
            }else if (viewIdx == 1){
                [self.productImageViewTwo  sd_setImageWithURL:[NSURL URLWithString:item.productImg] placeholderImage:[UIImage imageNamed:@"nocomment"]];
                self.productNameLabelTwo.text = item.productName;
                self.priceLabelTwo.text = [NSString stringWithFormat:@" ¥%0.0f",item.price];
                self.saleNumLabelTwo.text = [NSString stringWithFormat:@"%ld",item.saleNum];
            }else if (viewIdx == 2){
                [self.productImageViewThree  sd_setImageWithURL:[NSURL URLWithString:item.productImg] placeholderImage:[UIImage imageNamed:@"nocomment"]];
                self.productNameLabelThree.text = item.productName;
                self.priceLabelThree.text = [NSString stringWithFormat:@" ¥%0.0f",item.price];
                self.saleNumLabelThree.text = [NSString stringWithFormat:@"%ld",item.saleNum];
            }
        }else{
            view.hidden = YES;
        }
    }];
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterProductAutoRollCell:actionIndex:)]) {
        [self.delegate userCenterProductAutoRollCell:self actionIndex:sender.view.tag];
    }
}



@end
