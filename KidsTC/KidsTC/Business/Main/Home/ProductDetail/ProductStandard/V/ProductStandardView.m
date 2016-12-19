//
//  ProductStandardView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductStandardView.h"
#import "ProductStandardHeaderView.h"
#import "ProductStandardCell.h"
#import "UIButton+Category.h"

static NSString *const CellID = @"ProductStandardCell";

static CGFloat const kProductStandardViewDuration = 0.3;

@interface ProductStandardView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet ProductStandardHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomMargin;
@property (nonatomic, weak) ProductDetailStandard *selectedStandard;
@end

@implementation ProductStandardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentViewBottomMargin.constant = - (SCREEN_HEIGHT * 0.5 + 129 + 16);
    [self layoutIfNeeded];
    self.headerView.closeBlock = ^(){
        if ([self.delegate respondsToSelector:@selector(productStandardView:actionType:value:)]) {
            [self.delegate productStandardView:self actionType:ProductStandardViewActionTypeClose value:nil];
        }
    };
    [self.buyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductStandardCell" bundle:nil] forCellReuseIdentifier:CellID];
}

- (void)setProduct_standards:(NSArray<ProductDetailStandard *> *)product_standards {
    _product_standards = product_standards;
    
    [product_standards enumerateObjectsUsingBlock:^(ProductDetailStandard *obj, NSUInteger idx, BOOL *stop) {
        if (obj.selected == YES) {
            self.selectedStandard = obj;
            *stop = YES;
        }
    }];
    
    if (!self.selectedStandard && product_standards.count>0) {
        self.selectedStandard = self.product_standards.firstObject;
    }
}

- (void)setStandardDetailData:(ProductStandardDetailData *)standardDetailData {
    _standardDetailData = standardDetailData;
    self.buyBtn.enabled = _standardDetailData.isCanBuy;
    [self.buyBtn setTitle:_standardDetailData.statusDesc forState:UIControlStateNormal];
    self.headerView.standardDetailData = _standardDetailData;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(productStandardView:actionType:value:)]) {
        [self.delegate productStandardView:self actionType:ProductStandardViewActionTypeClose value:nil];
    }
}

- (IBAction)buyAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(productStandardView:actionType:value:)]) {
        [self.delegate productStandardView:self actionType:ProductStandardViewActionTypeBuy value:_selectedStandard];
    }
}

- (void)show {
    [UIView animateWithDuration:kProductStandardViewDuration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.contentViewBottomMargin.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hide:(void(^)())completionBlock {
    [UIView animateWithDuration:kProductStandardViewDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.contentViewBottomMargin.constant = - (SCREEN_HEIGHT * 0.5 + 129 + 16);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completionBlock)completionBlock();
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.product_standards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductStandardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger row = indexPath.row;
    if (row<self.product_standards.count) {
        ProductDetailStandard *standard = self.product_standards[row];
        cell.standard = standard;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.product_standards.count) {
        ProductDetailStandard *standard = self.product_standards[row];
        if (standard == self.selectedStandard) return;
        self.selectedStandard.selected = NO;
        self.selectedStandard = standard;
    }
}

#pragma mark - selectedStandard

- (void)setSelectedStandard:(ProductDetailStandard *)selectedStandard {
    _selectedStandard = selectedStandard;
    _selectedStandard.selected = YES;
    [self.tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(productStandardView:actionType:value:)]) {
        [self.delegate productStandardView:self actionType:ProductStandardViewActionTypeDidSelectStandard value:_selectedStandard.productId];
    }
}

@end
