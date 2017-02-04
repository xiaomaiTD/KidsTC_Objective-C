//
//  FlashBuyProductDetailSelectStoreView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailSelectStoreView.h"
#import "FlashBuyProductDetailSelectStoreCell.h"

static NSString *const SelectStoreCellID = @"FlashBuyProductDetailSelectStoreCell";
static CGFloat const animationDuration = 0.2;

@interface FlashBuyProductDetailSelectStoreView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *touchBeginBtn;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *selectStoreView;
@property (weak, nonatomic) IBOutlet UILabel *selectStoreNameL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectStoreLineH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomMargin;

@property (nonatomic, weak) FlashBuyProductDetailStore *selectStore;
@end

@implementation FlashBuyProductDetailSelectStoreView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectStoreLineH.constant = LINE_H;
    self.toolBarLineH.constant = LINE_H;
    self.backgroundColor = [UIColor clearColor];
    self.contentViewBottomMargin.constant = - CGRectGetHeight(self.contentView.bounds);
    
    self.touchBeginBtn.tag = FlashBuyProductDetailSelectStoreViewActionTypeTouchBegin;
    self.commitBtn.tag = FlashBuyProductDetailSelectStoreViewActionTypeCommit;
    
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailSelectStoreCell" bundle:nil] forCellReuseIdentifier:SelectStoreCellID];
    
    [self layoutIfNeeded];
}

- (void)setStores:(NSArray<FlashBuyProductDetailStore *> *)stores {
    _stores = stores;
    
    __block FlashBuyProductDetailStore *selectStore = nil;
    [stores enumerateObjectsUsingBlock:^(FlashBuyProductDetailStore * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.select) {
            selectStore = obj;
            *stop = YES;
        }
    }];
    if (stores.count>0 && !selectStore) {
        selectStore = stores.firstObject;
    }
    [self toSelectStore:selectStore];
}

- (void)setPrepaidPrice:(NSString *)prepaidPrice {
    _prepaidPrice = prepaidPrice;
    self.priceL.text = [NSString stringWithFormat:@"预付：%@元",prepaidPrice];
}

- (void)toSelectStore:(FlashBuyProductDetailStore *)store {
    self.selectStore.select = NO;
    store.select = YES;
    self.selectStore = store;
    self.selectStoreNameL.text = store.storeName;
    [self.tableView reloadData];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailSelectStoreView:actionType:value:)]) {
        [self.delegate flashBuyProductDetailSelectStoreView:self actionType:(FlashBuyProductDetailSelectStoreViewActionType)sender.tag value:_selectStore];
    }
}

- (void)show {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.contentViewBottomMargin.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hide:(void(^)(BOOL finish))completionBlock {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.contentViewBottomMargin.constant = - CGRectGetHeight(self.contentView.bounds);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completionBlock) completionBlock(finished);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlashBuyProductDetailSelectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectStoreCellID];
    NSUInteger row = indexPath.row;
    if (row<self.stores.count) {
        FlashBuyProductDetailStore *store = self.stores[row];
        cell.store = store;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row<self.stores.count) {
        FlashBuyProductDetailStore *store = self.stores[row];
        [self toSelectStore:store];
    }
}


@end
