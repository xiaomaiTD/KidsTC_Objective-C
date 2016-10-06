//
//  ServiceDetailConfigTableHeaderView.m
//  KidsTC
//
//  Created by zhanping on 6/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ServiceDetailConfigTableHeaderView.h"
#import "UIButton+Category.h"
#define ButtonConfigViewBtnMargin 12
#define ButtonConfigViewBtnHight 30
#define ButtonConfigViewBtnFont [UIFont systemFontOfSize:15]

@class ButtonConfigView;
@protocol ButtonConfigViewDelegate <NSObject>
- (void)buttonConfigView:(ButtonConfigView *)buttonConfigView didClickBtn:(UIButton *)btn;
@end

@interface ButtonConfigView : UIView
@property (nonatomic, strong) NSArray<ProductStandardsItem *> *product_standards;
@property (nonatomic, weak) id<ButtonConfigViewDelegate> delegate;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation ButtonConfigView
- (void)setProduct_standards:(NSArray<ProductStandardsItem *> *)product_standards currentIndex:(int)index setHightBlock:(void (^)(CGFloat hight))hightBlock{
    _product_standards = product_standards;
    CGFloat width = SCREEN_WIDTH - 12*2;
    __block UIButton *lastBtn = nil;
    [product_standards enumerateObjectsUsingBlock:^(ProductStandardsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [self btnWithTitle:obj.standardName tag:idx];
        CGFloat btnW = [obj.standardName sizeWithAttributes:@{NSFontAttributeName:ButtonConfigViewBtnFont}].width+16;
        CGFloat btnH = ButtonConfigViewBtnHight;
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        if (lastBtn) {
            btnX = CGRectGetMaxX(lastBtn.frame) + ButtonConfigViewBtnMargin;
            btnY = lastBtn.frame.origin.y;
        }
        
        if (btnW>width || btnX+btnW>width) {
            btnY = lastBtn.frame.origin.y+ButtonConfigViewBtnMargin+ButtonConfigViewBtnHight;
            btnX = 0;
        }
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self addSubview:btn];
        if (idx==index) [self action:btn];
        
        lastBtn = btn;
    }];
    
    hightBlock(CGRectGetMaxY(lastBtn.frame));
    
}

- (UIButton *)btnWithTitle:(NSString *)title tag:(NSUInteger)tag{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tag;
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    UIColor *color = COLOR_PINK;
    [btn setBackgroundColor:color forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor colorWithRed:0.961  green:0.961  blue:0.961 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.titleLabel.font = ButtonConfigViewBtnFont;
    CALayer *layer = btn.layer;
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    return btn;
}

- (void)action:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(buttonConfigView:didClickBtn:)]) {
        [self.delegate buttonConfigView:self didClickBtn:btn];
        
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn = btn;
        
    }
}

@end


@interface ServiceDetailConfigTableHeaderView ()<ButtonConfigViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet ButtonConfigView *btnConfigView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnConfigViewHightConstraint;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *selectMealLabel;
@property (nonatomic, strong) NSArray<ProductStandardsItem *> *product_standards;
@end


@implementation ServiceDetailConfigTableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIColor *gray = [UIColor colorWithRed:0.961  green:0.961  blue:0.961 alpha:1];
    
    [self.addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.addBtn setBackgroundColor:gray forState:UIControlStateNormal];
    
    [self.reduceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.reduceBtn setBackgroundColor:gray forState:UIControlStateNormal];
    
    self.numLabel.backgroundColor = gray;
    
    self.btnConfigView.delegate = self;
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
}

- (NSUInteger)buyNum{
    return self.numLabel.text.integerValue;
}

- (void)setData:(ServiceDetailConfigData *)data{
    _data = data;
    self.maxLimitLabel.text = [NSString stringWithFormat:@"每人限购%zd件",data.maxBuyNum];
    self.numLabel.text = @"0";
    [self btnAction:self.addBtn];
}
- (IBAction)btnAction:(UIButton *)sender {
    NSInteger num = self.numLabel.text.integerValue;
    if (sender == self.addBtn) {
        num++;
    }else if (sender == self.reduceBtn){
        num--;
    }
    if (num<=self.data.minBuyNum) {
        self.reduceBtn.enabled = NO;
        num = self.data.minBuyNum;
    }
    if (num>=self.data.maxBuyNum){
        self.addBtn.enabled = NO;
        num = self.data.maxBuyNum;
    }
    if (num<self.data.maxBuyNum &&
        num>self.data.minBuyNum){
        self.reduceBtn.enabled = YES;
        self.addBtn.enabled = YES;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%zd",num];
    if ([self.delegate respondsToSelector:@selector(serviceDetailConfigTableHeaderView:didSelectBuyNum:)]) {
        [self.delegate serviceDetailConfigTableHeaderView:self didSelectBuyNum:num];
    }
}


- (void)setProduct_standards:(NSArray<ProductStandardsItem *> *)product_standards currentIndex:(int)index{
    _product_standards = product_standards;
    if (product_standards.count>0) {
        [self.btnConfigView setProduct_standards:product_standards currentIndex:index setHightBlock:^(CGFloat hight) {
            self.btnConfigViewHightConstraint.constant = hight;
            CGRect frame = self.frame;
            frame.size.height = 165+hight;
            self.frame = frame;
        }];
        self.selectMealLabel.hidden = NO;
        self.btnConfigView.hidden = NO;
        self.lineView.hidden = NO;
    }else{
        self.selectMealLabel.hidden = YES;
        self.btnConfigView.hidden = YES;
        self.lineView.hidden = YES;
        CGRect frame = self.frame;
        frame.size.height = 97;
        self.frame = frame;
    }
    
}

#pragma ButtonConfigViewDelegate
- (void)buttonConfigView:(ButtonConfigView *)buttonConfigView didClickBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(serviceDetailConfigTableHeaderView:didClickBtnAtIndex:)]) {
        [self.delegate serviceDetailConfigTableHeaderView:self didClickBtnAtIndex:btn.tag];
    }
}

@end
