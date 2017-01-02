//
//  CollectionStoreView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreView.h"
#import "CollectionStoreHeader.h"
#import "CollectionStoreCell.h"
#import "CollectionStoreFooter.h"

#import "CollectionStoreItem.h"

#import "RecommendStoreCollectStoreView.h"

static NSString *const CellID = @"CollectionStoreCell";
static NSString *const HeadID = @"CollectionStoreHeader";
static NSString *const FootID = @"CollectionStoreFooter";

@interface CollectionStoreView ()<CollectionStoreHeaderDelegate,RecommendStoreCollectStoreViewDelegate>
@property (nonatomic, strong) RecommendStoreCollectStoreView *footerView;
@end

@implementation CollectionStoreView

- (RecommendStoreCollectStoreView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendStoreCollectStoreView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreCell" bundle:nil] forCellReuseIdentifier:CellID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
        [self resetFooterView];
    }
    return self;
}

- (void)resetFooterView {
    [self.footerView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.footerView contentHeight]);
        self.tableView.tableFooterView = self.footerView;
    });
}

- (void)nilRecommendData {
    [self.footerView nilData];
    [self resetFooterView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.items.count) {
        CollectionStoreItem *item = self.items[section];
        return item.productLst.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CollectionStoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    header.section = section;
    if (section<self.items.count) {
        header.item = self.items[section];
    }
    header.deleteBtn.hidden = !self.editing;
    header.delegate = self;
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.items.count) {
        CollectionStoreItem *item = self.items[section];
        if (row<item.productLst.count) {
            cell.product = item.productLst[row];
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CollectionStoreFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
    if (section<self.items.count) {
        footer.item = self.items[section];
        footer.actionBlock = ^(CollectionStoreItem *item){
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:item.segueModel completion:nil];
            }
        };
    }
    return footer;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.items.count) {
        CollectionStoreItem *item = self.items[section];
        NSArray<CollectionStoreProduct *> *productLst = item.productLst;
        if (row<productLst.count) {
            CollectionStoreProduct *product = productLst[row];
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:product.segueModel completion:nil];
            }
        }
    }
}

#pragma mark - CollectionStoreHeaderDelegate

- (void)collectionStoreHeader:(CollectionStoreHeader *)header actionType:(CollectionStoreHeaderActionType)type value:(id)value {
    switch (type) {
        case CollectionStoreHeaderActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        case CollectionStoreHeaderActionTypeDelete:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeDelete value:value completion:^(id value) {
                    BOOL success = [value boolValue];
                    if (!success) return;
                    NSMutableArray *itemsAry = [NSMutableArray arrayWithArray:self.items];
                    if (header.section>=itemsAry.count) return;
                    [itemsAry removeObjectAtIndex:header.section];
                    self.items = [NSArray arrayWithArray:itemsAry];
                    [self.tableView reloadData];
                }];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - RecommendStoreCollectStoreViewDelegate

- (void)recommendStoreCollectStoreView:(RecommendStoreCollectStoreView *)view actionType:(RecommendStoreCollectStoreViewActionType)type value:(id)value {
    switch (type) {
        case RecommendStoreCollectStoreViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        case RecommendStoreCollectStoreViewActionTypeCollect:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeCollect value:value completion:nil];
            }
        }
            break;
        default:
            break;
    }
}


- (void)dealloc {
    [self.footerView nilData];
}

@end
