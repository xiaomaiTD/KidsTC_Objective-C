//
//  ProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailView.h"

#import "NSString+Category.h"

#import "ProductDetailToolBar.h"

#import "ProductDetailBaseCell.h"
#import "ProductDetailBannerCell.h"
#import "ProductDetailInfoCell.h"
#import "ProductDetailDateCell.h"
#import "ProductDetailAddressCell.h"
#import "ProductDetailTitleCell.h"
#import "ProductDetailContentEleCell.h"
#import "ProductDetailJoinCell.h"
#import "ProductDetailTwoColumnCell.h"
#import "ProductDetailStandardCell.h"
#import "ProductDetailCouponCell.h"
#import "ProductDetailNoticeCell.h"
#import "ProductDetailApplyCell.h"
#import "ProductDetailContactCell.h"
#import "ProductDetailCommentCell.h"
#import "ProductDetailCommentMoreCell.h"
#import "ProductDetailRecommendCell.h"

@interface ProductDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductDetailToolBarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) ProductDetailToolBar *toolBar;

@property (nonatomic, strong) ProductDetailBannerCell      *bannerCell;
@property (nonatomic, strong) ProductDetailInfoCell        *infoCell;
@property (nonatomic, strong) ProductDetailDateCell        *dateCell;
@property (nonatomic, strong) ProductDetailAddressCell     *addressCell;
@property (nonatomic, strong) ProductDetailJoinCell        *joinCell;
@property (nonatomic, strong) ProductDetailTwoColumnCell   *twoColumnCell;
@property (nonatomic, strong) ProductDetailCouponCell      *couponCell;
@property (nonatomic, strong) ProductDetailNoticeCell      *noticeCell;
@property (nonatomic, strong) ProductDetailContactCell     *contactCell;

@property (nonatomic, strong) NSArray<NSArray<ProductDetailBaseCell *> *> *sections;
@end

@implementation ProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareCells];
        
        [self setupTableView];
        
        [self setupToolBar];
        
    }
    return self;
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    [self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kProductDetailToolBarHeight, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.estimatedRowHeight = 44.0f;
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    NSMutableArray *section00 = [NSMutableArray new];
    if (_data.narrowImg.count>0) {
        [section00 addObject:_bannerCell];
    }
    [section00 addObject:_infoCell];
    if ([_data.time.desc isNotNull]) {
        [section00 addObject:_dateCell];
    }
    if (_data.store.count>0) {
        [section00 addObject:_addressCell];
    }
    if (section00.count>0) [sections addObject:section00];
    
    
    //content
    [_data.buyNotice enumerateObjectsUsingBlock:^(ProductDetailBuyNotice *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section01 = [NSMutableArray new];
        if ([obj.title isNotNull]) {
            ProductDetailTitleCell *titleCell = self.titleCell;
            titleCell.text = obj.title;
            [section01 addObject:titleCell];
        }
        [obj.notice enumerateObjectsUsingBlock:^(ProductDetailNotice *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailContentEleCell *contentEleCell = self.contentEleCell;
            contentEleCell.notice = obj;
            [section01 addObject:contentEleCell];
        }];
        if (section01.count>0) [sections addObject:section01];
    }];
    
    
    //他们已参加
    if (_data.comment.userHeadImgs.count>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        [section03 addObject:_joinCell];
        if (section03.count>0) [sections addObject:section03];
    }
    
    
    //detail
    NSMutableArray *section04 = [NSMutableArray new];
    [section04 addObject:_twoColumnCell];
    if (section04.count>0) [sections addObject:section04];
    
    
    //套餐明细
    if (_data.product_standards.count>0) {
        NSMutableArray *section05 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell = self.titleCell;
        titleCell.text = @"套餐明细";
        [section05 addObject:titleCell];
        [_data.product_standards enumerateObjectsUsingBlock:^(ProductDetailStandard *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailStandardCell *standardCell = self.standardCell;
            standardCell.index = idx;
            [section05 addObject:standardCell];
        }];
        if (section05.count>0) [sections addObject:section05];
    }
    
    
    //领取优惠券
    if (_data.coupons.count>0) {
        NSMutableArray *section06 = [NSMutableArray new];
        [section06 addObject:_couponCell];
        if (section06.count>0) [sections addObject:section06];
    }
    
    //购买须知
    NSMutableArray *section07 = [NSMutableArray new];
    ProductDetailTitleCell *titleCell07 = self.titleCell;
    titleCell07.text = @"购买须知";
    [section07 addObject:titleCell07];
    if (_data.insurance.items.count>0) {
        [section07 addObject:_noticeCell];
    }
    if (_data.attApply.count>0) {
        [_data.attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailApplyCell *applyCell = self.applyCell;
            applyCell.attStr = obj;
            [section07 addObject:applyCell];
        }];
    }
    [section07 addObject:_contactCell];
    if (section07.count>0) [sections addObject:section07];
    
    
    //活动评价
    if (_data.commentList.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell08 = self.titleCell;
        titleCell08.text = @"活动评价";
        [section08 addObject:titleCell08];
        [_data.commentList enumerateObjectsUsingBlock:^(ProduceDetialCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=2) {
                [section08 addObject:self.commentMoreCell];
                *stop = YES;
            }else{
                ProductDetailCommentCell *commentCell = self.commentCell;
                commentCell.index = idx;
                [section08 addObject:commentCell];
            }
        }];
        if (section08.count>0) [sections addObject:section08];
    }
    
    if (_data.recommends.count>0) {
        NSMutableArray *section09 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell09 = self.titleCell;
        titleCell09.text = @"为您推荐";
        [section09 addObject:titleCell09];
        [_data.recommends enumerateObjectsUsingBlock:^(ProductDetailRecommendItem *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailRecommendCell *recommendCell = self.recommendCell;
            recommendCell.index = idx;
            [section09 addObject:recommendCell];
        }];
        if (section09.count>0) [sections addObject:section09];
    }
    
    
    
    self.sections = [NSArray arrayWithArray:sections];
    
}

- (void)prepareCells {
    
    _bannerCell    = [self viewWithNib:@"ProductDetailBannerCell"];
    _infoCell      = [self viewWithNib:@"ProductDetailInfoCell"];
    _dateCell      = [self viewWithNib:@"ProductDetailDateCell"];
    _addressCell   = [self viewWithNib:@"ProductDetailAddressCell"];
    _joinCell      = [self viewWithNib:@"ProductDetailJoinCell"];
    _twoColumnCell = [self viewWithNib:@"ProductDetailTwoColumnCell"];
    _couponCell    = [self viewWithNib:@"ProductDetailCouponCell"];
    _noticeCell    = [self viewWithNib:@"ProductDetailNoticeCell"];
    _contactCell   = [self viewWithNib:@"ProductDetailContactCell"];
    
}

- (ProductDetailTitleCell *)titleCell {
    return [self viewWithNib:@"ProductDetailTitleCell"];
}

- (ProductDetailContentEleCell *)contentEleCell {
    return [self viewWithNib:@"ProductDetailContentEleCell"];
}

- (ProductDetailStandardCell *)standardCell {
    return [self viewWithNib:@"ProductDetailStandardCell"];
}

- (ProductDetailApplyCell *)applyCell {
    return [self viewWithNib:@"ProductDetailApplyCell"];
}

- (ProductDetailCommentCell *)commentCell {
    return [self viewWithNib:@"ProductDetailCommentCell"];
}

- (ProductDetailCommentMoreCell *)commentMoreCell {
    return [self viewWithNib:@"ProductDetailCommentMoreCell"];
}

- (ProductDetailRecommendCell *)recommendCell {
    return [self viewWithNib:@"ProductDetailRecommendCell"];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    //cell.backgroundColor = RandomColor;
    cell.data = _data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    ProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - kProductDetailToolBarHeight, SCREEN_WIDTH, kProductDetailToolBarHeight);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark ProductDetailToolBarDelegate

- (void)productDetailToolBar:(ProductDetailToolBar *)toolBar btnType:(ProductDetailToolBarBtnType)type value:(id)value {
    
    switch (type) {
        case ProductDetailToolBarBtnTypeContact:
        {
            
        }
            break;
            
        case ProductDetailToolBarBtnTypeAttention:
        {
            
        }
            break;
            
        case ProductDetailToolBarBtnTypeBuy:
        {
            
        }
            break;
    }
    
}

@end
