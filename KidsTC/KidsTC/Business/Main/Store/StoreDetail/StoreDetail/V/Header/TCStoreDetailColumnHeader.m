//
//  TCStoreDetailColumnHeader.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailColumnHeader.h"

CGFloat const kTCStoreDetailColumnHeaderH = 46;

@interface TCStoreDetailColumnHeader ()
@property (weak, nonatomic) IBOutlet UIView *bgContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

@property (nonatomic, weak) TCStoreDetailColumn *selectColumn;

@end

@implementation TCStoreDetailColumnHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViews];
}

- (void)setupSubViews {
    __block UIButton *lastBtn = nil;
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = self.margin+CGRectGetMaxX(lastBtn.frame);
        CGFloat y = 0;
        CGFloat w = CGRectGetWidth(obj.bounds);
        CGFloat h = CGRectGetHeight(obj.bounds);
        obj.frame = CGRectMake(x, y, w, h);
        lastBtn = obj;
    }];
}

- (void)setData:(TCStoreDetailData *)data {
    _data = data;
    
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btns = [NSMutableArray array];
    
    NSUInteger count = self.data.columns.count;
    if (count<1) return;
    __block CGFloat btn_w_total = 0;
    [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [UIButton new];
        btn.tag = idx;
        [btn setTitle:obj.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.selected = obj.select;
        [btn setTitleColor:[UIColor colorFromHexString:@"222222"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorFromHexString:@"ff8888"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btn_w = [obj.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        btn_w_total += btn_w;
        btn.bounds = CGRectMake(0, 0, btn_w, kTCStoreDetailColumnHeaderH);
        [self.bgContentView insertSubview:btn atIndex:0];
        if(btn) [self.btns addObject:btn];
        obj.targetBtn = btn;
    }];
    self.margin = (SCREEN_WIDTH-btn_w_total)/(count+1);
    [self layoutIfNeeded];
    [self setupSubViews];
    
    __block TCStoreDetailColumn *selectedColumn = nil;
    [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.select) selectedColumn = obj;
    }];
    if (!selectedColumn) selectedColumn = self.data.columns.firstObject;
    [self selectColumn:selectedColumn];
}

- (void)action:(UIButton *)btn {
    NSUInteger index = btn.tag;
    if (index>=self.data.columns.count) return;
    TCStoreDetailColumn *column = self.data.columns[index];
    NSString *title = column.title;
    NSLog(@"%@",title);
    [self selectColumn:column];
    
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailColumnHeader:didSelectColumn:)]) {
        [self.delegate tcStoreDetailColumnHeader:self didSelectColumn:column];
    }
}

- (void)selectColumn:(TCStoreDetailColumn *)column {
    if (!column || ![column isKindOfClass:[TCStoreDetailColumn class]]) return;
    if (column==self.selectColumn) return;
    column.select = YES;
    self.selectColumn.select = NO;
    self.selectColumn = column;
    
    self.lineLeading.constant = CGRectGetMinX(column.targetBtn.frame);
    self.lineWidth.constant = CGRectGetWidth(column.targetBtn.frame);
    [self layoutIfNeeded];
}



@end
