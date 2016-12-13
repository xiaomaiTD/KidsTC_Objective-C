//
//  ProductDetailSubViewsProvider.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSubViewsProvider.h"
#import "NSString+Category.h"

#import "ProductDetailViewTicketHeader.h"

#import "ProductDetailBannerCell.h"
#import "ProductDetailInfoCell.h"
#import "ProductDetailDateCell.h"
#import "ProductDetailAddressCell.h"
#import "ProductDetailTitleCell.h"
#import "ProductDetailContentEleCell.h"
#import "ProductDetailContentEleEmptyCell.h"
#import "ProductDetailJoinCell.h"
#import "ProductDetaiFreeJoinCell.h"
#import "ProductDetailTwoColumnWebViewCell.h"
#import "ProductDetailTwoColumnConsultTipCell.h"
#import "ProductDetailTwoColumnConsultEmptyCell.h"
#import "ProductDetailTwoColumnConsultConsultCell.h"
#import "ProductDetailTwoColumnConsultMoreCell.h"
#import "ProductDetailStandardCell.h"
#import "ProductDetailCouponCell.h"
#import "ProductDetailNoticeCell.h"
#import "ProductDetailApplyCell.h"
#import "ProductDetailContactCell.h"
#import "ProductDetailCommentCell.h"
#import "ProductDetailCommentMoreCell.h"
#import "ProductDetailRecommendCell.h"
#import "ProductDetailTicketInfoCell.h"
#import "ProductDetailTicketDesCell.h"
#import "ProductDetailTicketDesBtnCell.h"
#import "ProductDetailTicketPromiseCell.h"
#import "ProductDetailTicketActorCell.h"
#import "ProductDetaiFreeInfoCell.h"
#import "ProductDetaiFreeStoreInfoCell.h"
#import "ProductDetaiFreeLifeTipCell.h"

#import "ProductDetailNormalToolBar.h"
#import "ProductDetailTicketToolBar.h"
#import "ProductDetaiFreeToolBar.h"

@interface ProductDetailSubViewsProvider ()

@property (nonatomic, strong) ProductDetailViewBaseHeader *header;

@property (nonatomic, strong) ProductDetailBannerCell *bannerCell;
@property (nonatomic, strong) ProductDetailInfoCell *infoCell;
@property (nonatomic, strong) ProductDetailDateCell *dateCell;
@property (nonatomic, strong) ProductDetailAddressCell *addressCell;
@property (nonatomic, strong) ProductDetailJoinCell *joinCell;
@property (nonatomic, strong) ProductDetailTwoColumnWebViewCell *twoColumnWebViewCell;
@property (nonatomic, strong) ProductDetailTwoColumnConsultTipCell *twoColumnConsultTipCell;
@property (nonatomic, strong) ProductDetailTwoColumnConsultEmptyCell *twoColumnConsultEmptyCell;
@property (nonatomic, strong) ProductDetailTwoColumnConsultMoreCell *twoColumnConsultMoreCell;
@property (nonatomic, strong) ProductDetailCouponCell *couponCell;
@property (nonatomic, strong) ProductDetailNoticeCell *noticeCell;
@property (nonatomic, strong) ProductDetailContactCell *contactCell;
@property (nonatomic, strong) ProductDetailCommentMoreCell *commentMoreCell;

@property (nonatomic, strong) ProductDetailTicketInfoCell *ticketInfoCell;
@property (nonatomic, strong) ProductDetailTicketDesCell *ticketDesCell;
@property (nonatomic, strong) ProductDetailTicketDesBtnCell *ticketDesBtnCell;
@property (nonatomic, strong) ProductDetailTicketPromiseCell *ticketPromiseCell;
@property (nonatomic, strong) ProductDetailTicketActorCell *ticketActorCell;

@property (nonatomic, strong) ProductDetaiFreeInfoCell *freeInfoCell;
@property (nonatomic, strong) ProductDetaiFreeJoinCell *freeJoinCell;
@property (nonatomic, strong) ProductDetaiFreeStoreInfoCell *freeStoreInfoCell;
@property (nonatomic, strong) ProductDetaiFreeLifeTipCell *freeLifeTipCell;

@property (nonatomic, strong) ProductDetailBaseToolBar *toolBar;
@property (nonatomic, strong) ProductDetailCountDownView *countDownView;
@property (nonatomic, strong) ProductDetailTwoColumnToolBar *twoColumnToolBar;

@end

@implementation ProductDetailSubViewsProvider
singleM(ProductDetailSubViewsProvider)

#pragma mark - cells

- (ProductDetailBannerCell *)bannerCell {
    if (!_bannerCell)
    {
        _bannerCell = [self viewWithNib:@"ProductDetailBannerCell"];
    }
    return _bannerCell;
}

- (ProductDetailInfoCell *)infoCell {
    if (!_infoCell)
    {
        _infoCell = [self viewWithNib:@"ProductDetailInfoCell"];
    }
    return _infoCell;
}

- (ProductDetailDateCell *)dateCell {
    if (!_dateCell)
    {
        _dateCell = [self viewWithNib:@"ProductDetailDateCell"];
    }
    return _dateCell;
}

- (ProductDetailAddressCell *)addressCell {
    if (!_addressCell)
    {
        _addressCell = [self viewWithNib:@"ProductDetailAddressCell"];
    }
    return _addressCell;
}

- (ProductDetailTitleCell *)titleCell {
    return [self viewWithNib:@"ProductDetailTitleCell"];
}

- (ProductDetailContentEleCell *)contentEleCell {
    return [self viewWithNib:@"ProductDetailContentEleCell"];
}

- (ProductDetailContentEleEmptyCell *)contentEleEmptyCell {
    return [self viewWithNib:@"ProductDetailContentEleEmptyCell"];
}

- (ProductDetailJoinCell *)joinCell {
    if (!_joinCell)
    {
        _joinCell = [self viewWithNib:@"ProductDetailJoinCell"];
    }
    return _joinCell;
}

- (ProductDetailTwoColumnWebViewCell *)twoColumnWebViewCell {
    if (!_twoColumnWebViewCell)
    {
        _twoColumnWebViewCell = [self viewWithNib:@"ProductDetailTwoColumnWebViewCell"];
    }
    return _twoColumnWebViewCell;
}

- (ProductDetailTwoColumnConsultTipCell *)twoColumnConsultTipCell {
    if (!_twoColumnConsultTipCell)
    {
        _twoColumnConsultTipCell = [self viewWithNib:@"ProductDetailTwoColumnConsultTipCell"];
    }
    return _twoColumnConsultTipCell;
}

- (ProductDetailTwoColumnConsultEmptyCell *)twoColumnConsultEmptyCell {
    if (!_twoColumnConsultEmptyCell)
    {
        _twoColumnConsultEmptyCell = [self viewWithNib:@"ProductDetailTwoColumnConsultEmptyCell"];
    }
    return _twoColumnConsultEmptyCell;
}

- (ProductDetailTwoColumnConsultConsultCell *)twoColumnConsultConsultCell {
    return [self viewWithNib:@"ProductDetailTwoColumnConsultConsultCell"];
}

- (ProductDetailTwoColumnConsultMoreCell *)twoColumnConsultMoreCell {
    if (!_twoColumnConsultMoreCell)
    {
        _twoColumnConsultMoreCell = [self viewWithNib:@"ProductDetailTwoColumnConsultMoreCell"];
    }
    return _twoColumnConsultMoreCell;
}

- (ProductDetailStandardCell *)standardCell {
    return [self viewWithNib:@"ProductDetailStandardCell"];
}

- (ProductDetailCouponCell *)couponCell {
    if (!_couponCell)
    {
        _couponCell = [self viewWithNib:@"ProductDetailCouponCell"];
    }
    return _couponCell;
}

- (ProductDetailNoticeCell *)noticeCell {
    if (!_noticeCell)
    {
        _noticeCell = [self viewWithNib:@"ProductDetailNoticeCell"];
    }
    return _noticeCell;
}

- (ProductDetailApplyCell *)applyCell {
    return [self viewWithNib:@"ProductDetailApplyCell"];
}

- (ProductDetailContactCell *)contactCell {
    if (!_contactCell)
    {
        _contactCell = [self viewWithNib:@"ProductDetailContactCell"];
    }
    return _contactCell;
}

- (ProductDetailCommentCell *)commentCell {
    return [self viewWithNib:@"ProductDetailCommentCell"];
}

- (ProductDetailCommentMoreCell *)commentMoreCell {
    if (!_commentMoreCell)
    {
        _commentMoreCell = [self viewWithNib:@"ProductDetailCommentMoreCell"];
    }
    return _commentMoreCell;
}

- (ProductDetailRecommendCell *)recommendCell {
    return [self viewWithNib:@"ProductDetailRecommendCell"];
}

- (ProductDetailTicketInfoCell *)ticketInfoCell {
    if (!_ticketInfoCell)
    {
        _ticketInfoCell = [self viewWithNib:@"ProductDetailTicketInfoCell"];
    }
    return _ticketInfoCell;
}

- (ProductDetailTicketDesCell *)ticketDesCell {
    if (!_ticketDesCell)
    {
        _ticketDesCell = [self viewWithNib:@"ProductDetailTicketDesCell"];
    }
    return _ticketDesCell;
}

- (ProductDetailTicketDesBtnCell *)ticketDesBtnCell {
    if (!_ticketDesBtnCell)
    {
        _ticketDesBtnCell = [self viewWithNib:@"ProductDetailTicketDesBtnCell"];
    }
    return _ticketDesBtnCell;
}

- (ProductDetailTicketPromiseCell *)ticketPromiseCell {
    if (!_ticketPromiseCell)
    {
        _ticketPromiseCell = [self viewWithNib:@"ProductDetailTicketPromiseCell"];
    }
    return _ticketPromiseCell;
}

- (ProductDetailTicketActorCell *)ticketActorCell {
    if (!_ticketActorCell)
    {
        _ticketActorCell = [self viewWithNib:@"ProductDetailTicketActorCell"];
    }
    return _ticketActorCell;
}

- (ProductDetaiFreeInfoCell *)freeInfoCell {
    if (!_freeInfoCell)
    {
        _freeInfoCell = [self viewWithNib:@"ProductDetaiFreeInfoCell"];
    }
    return _freeInfoCell;
}

- (ProductDetaiFreeJoinCell *)freeJoinCell {
    if (!_freeJoinCell)
    {
        _freeJoinCell = [self viewWithNib:@"ProductDetaiFreeJoinCell"];
    }
    return _freeJoinCell;
}

- (ProductDetaiFreeStoreInfoCell *)freeStoreInfoCell {
    if (!_freeStoreInfoCell)
    {
        _freeStoreInfoCell = [self viewWithNib:@"ProductDetaiFreeStoreInfoCell"];
    }
    return _freeStoreInfoCell;
}

- (ProductDetaiFreeLifeTipCell *)freeLifeTipCell {
    if (!_freeLifeTipCell)
    {
        _freeLifeTipCell = [self viewWithNib:@"ProductDetaiFreeLifeTipCell"];
    }
    return _freeLifeTipCell;
}

#pragma mark - header

- (ProductDetailViewBaseHeader *)header {
    if (!_header) {
        switch (_type) {
            case ProductDetailTypeNormal:
            {
                _header = nil;
            }
                break;
            case ProductDetailTypeTicket:
            {
                _header = [self viewWithNib:@"ProductDetailViewTicketHeader"];
            }
                break;
            case ProductDetailTypeFree:
            {
                _header = nil;
            }
                break;
        }
    }
    return _header;
}

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)sections {
    
    NSArray<NSArray<ProductDetailBaseCell *> *> *sections = nil;
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            sections = self.normalSections;
        }
            break;
        case ProductDetailTypeTicket:
        {
            sections = self.ticketSections;
        }
            break;
        case ProductDetailTypeFree:
        {
            sections = self.freeSections;
        }
            break;
    }
    return sections;
}

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)normalSections {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    NSMutableArray *section00 = [NSMutableArray new];
    if (_data.narrowImg.count>0) {
        [section00 addObject:self.bannerCell];
    }
    [section00 addObject:self.infoCell];
    if ([_data.time.desc isNotNull] && _data.time.times.count>0) {
        [section00 addObject:self.dateCell];
    }
    if (_data.store.count>0) {
        [section00 addObject:self.addressCell];
    }
    if (section00.count>0) [sections addObject:section00];
    
    
    //content
    [_data.buyNotice enumerateObjectsUsingBlock:^(ProductDetailBuyNotice *obj1, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section01 = [NSMutableArray new];
        if ([obj1.title isNotNull]) {
            ProductDetailTitleCell *titleCell = self.titleCell;
            titleCell.text = obj1.title;
            [section01 addObject:titleCell];
        }
        [obj1.notice enumerateObjectsUsingBlock:^(ProductDetailNotice *obj2, NSUInteger idx, BOOL *stop) {
            ProductDetailContentEleCell *contentEleCell = self.contentEleCell;
            contentEleCell.notice = obj2;
            [section01 addObject:contentEleCell];
        }];
        if (obj1.notice.count>0) {
            [section01 addObject:self.contentEleEmptyCell];
        }
        if (section01.count>0) [sections addObject:section01];
    }];
    
    
    //他们已参加
    if (_data.comment.userHeadImgs.count>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        [section03 addObject:self.joinCell];
        if (section03.count>0) [sections addObject:section03];
    }
    
    
    //detail
    NSMutableArray *section04 = [NSMutableArray new];
    switch (_data.showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            [section04 addObject:self.twoColumnWebViewCell];
            self.twoColumnCell = self.twoColumnWebViewCell;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            [section04 addObject:self.twoColumnConsultTipCell];
            self.twoColumnCell = self.twoColumnConsultTipCell;
            
            NSArray<ProductDetailConsultItem *> *consults = self.data.consults;
            if (consults.count<1) {
                [section04 addObject:self.twoColumnConsultEmptyCell];
            }else{
                [consults enumerateObjectsUsingBlock:^(ProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
                    ProductDetailTwoColumnConsultConsultCell *consultCell = self.twoColumnConsultConsultCell;
                    consultCell.item = obj;
                    [section04 addObject:consultCell];
                }];
                [section04 addObject:self.twoColumnConsultMoreCell];
            }
        }
            break;
    }
    _twoColumnSectionUsed = sections.count;
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
    if (_data.coupons.count>0 && _data.canProvideCoupon) {
        NSMutableArray *section06 = [NSMutableArray new];
        [section06 addObject:self.couponCell];
        if (section06.count>0) [sections addObject:section06];
    }
    
    //购买须知
    NSMutableArray *section07 = [NSMutableArray new];
    ProductDetailTitleCell *titleCell07 = self.titleCell;
    titleCell07.text = @"购买须知";
    [section07 addObject:titleCell07];
    if (_data.insurance.items.count>0) {
        [section07 addObject:self.noticeCell];
    }
    if (_data.attApply.count>0) {
        [_data.attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailApplyCell *applyCell = self.applyCell;
            applyCell.attStr = obj;
            [section07 addObject:applyCell];
        }];
    }
    [section07 addObject:self.contactCell];
    if (section07.count>0) [sections addObject:section07];
    
    
    //活动评价
    if (_data.commentList.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell08 = self.titleCell;
        titleCell08.text = @"活动评价";
        [section08 addObject:titleCell08];
        [_data.commentList enumerateObjectsUsingBlock:^(ProduceDetialCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=5) {
                *stop = YES;
            }else{
                ProductDetailCommentCell *commentCell = self.commentCell;
                commentCell.index = idx;
                [section08 addObject:commentCell];
            }
        }];
        [section08 addObject:self.commentMoreCell];
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
    
    return [NSArray arrayWithArray:sections];
}

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)ticketSections {
    NSMutableArray *sections = [NSMutableArray array];
    
    //info
    NSMutableArray *section00 = [NSMutableArray array];
    [section00 addObject:self.ticketInfoCell];
    if (_data.attSynopsis.length>0) {
        [section00 addObject:self.ticketDesCell];
        [section00 addObject:self.ticketDesBtnCell];
    }
    if (section00.count>0) [sections addObject:section00];
    
    //address
    NSMutableArray *section01 = [NSMutableArray array];
    if ([_data.time.desc isNotNull] && _data.time.times.count>0) {
        [section01 addObject:self.dateCell];
    }
    if (_data.store.count>0) {
        [section01 addObject:self.addressCell];
    }
    [section01 addObject:self.ticketPromiseCell];
    if (section01.count>0) [sections addObject:section01];
    
    
    //content
    [_data.buyNotice enumerateObjectsUsingBlock:^(ProductDetailBuyNotice *obj1, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section02 = [NSMutableArray new];
        if ([obj1.title isNotNull]) {
            ProductDetailTitleCell *titleCell = self.titleCell;
            titleCell.text = obj1.title;
            [section02 addObject:titleCell];
        }
        [obj1.notice enumerateObjectsUsingBlock:^(ProductDetailNotice *obj2, NSUInteger idx, BOOL *stop) {
            ProductDetailContentEleCell *contentEleCell = self.contentEleCell;
            contentEleCell.notice = obj2;
            [section02 addObject:contentEleCell];
        }];
        if (obj1.notice.count>0) {
            [section02 addObject:self.contentEleEmptyCell];
        }
        if (section02.count>0) [sections addObject:section02];
    }];
    
    //actor
    NSMutableArray *section03 = [NSMutableArray array];
    [section03 addObject:self.ticketActorCell];
    if (section03.count>0) [sections addObject:section03];
    
    //detail
    NSMutableArray *section04 = [NSMutableArray new];
    switch (_data.showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            [section04 addObject:self.twoColumnWebViewCell];
            self.twoColumnCell = self.twoColumnWebViewCell;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            [section04 addObject:self.twoColumnConsultTipCell];
            self.twoColumnCell = self.twoColumnConsultTipCell;
            
            NSArray<ProductDetailConsultItem *> *consults = self.data.consults;
            if (consults.count<1) {
                [section04 addObject:self.twoColumnConsultEmptyCell];
            }else{
                [consults enumerateObjectsUsingBlock:^(ProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
                    ProductDetailTwoColumnConsultConsultCell *consultCell = self.twoColumnConsultConsultCell;
                    consultCell.item = obj;
                    [section04 addObject:consultCell];
                }];
                [section04 addObject:self.twoColumnConsultMoreCell];
            }
        }
            break;
    }
    _twoColumnSectionUsed = sections.count;
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
    if (_data.coupons.count>0 && _data.canProvideCoupon) {
        NSMutableArray *section06 = [NSMutableArray new];
        [section06 addObject:self.couponCell];
        if (section06.count>0) [sections addObject:section06];
    }
    
    //购买须知
    NSMutableArray *section07 = [NSMutableArray new];
    ProductDetailTitleCell *titleCell07 = self.titleCell;
    titleCell07.text = @"购买须知";
    [section07 addObject:titleCell07];
    if (_data.insurance.items.count>0) {
        [section07 addObject:self.noticeCell];
    }
    if (_data.attApply.count>0) {
        [_data.attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailApplyCell *applyCell = self.applyCell;
            applyCell.attStr = obj;
            [section07 addObject:applyCell];
        }];
    }
    [section07 addObject:self.contactCell];
    if (section07.count>0) [sections addObject:section07];
    
    
    //活动评价
    if (_data.commentList.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell08 = self.titleCell;
        titleCell08.text = @"活动评价";
        [section08 addObject:titleCell08];
        [_data.commentList enumerateObjectsUsingBlock:^(ProduceDetialCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=5) {
                *stop = YES;
            }else{
                ProductDetailCommentCell *commentCell = self.commentCell;
                commentCell.index = idx;
                [section08 addObject:commentCell];
            }
        }];
        [section08 addObject:self.commentMoreCell];
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
    
    return [NSArray arrayWithArray:sections];
}

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)freeSections {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    NSMutableArray *section00 = [NSMutableArray new];
    if (_data.narrowImg.count>0) {
        [section00 addObject:self.bannerCell];
    }
    [section00 addObject:self.freeInfoCell];
    if (section00.count>0) [sections addObject:section00];
    
    //content
    [_data.buyNotice enumerateObjectsUsingBlock:^(ProductDetailBuyNotice *obj1, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section01 = [NSMutableArray new];
        if ([obj1.title isNotNull]) {
            ProductDetailTitleCell *titleCell = self.titleCell;
            titleCell.text = obj1.title;
            [section01 addObject:titleCell];
        }
        [obj1.notice enumerateObjectsUsingBlock:^(ProductDetailNotice *obj2, NSUInteger idx, BOOL *stop) {
            ProductDetailContentEleCell *contentEleCell = self.contentEleCell;
            contentEleCell.notice = obj2;
            [section01 addObject:contentEleCell];
        }];
        if (obj1.notice.count>0) {
            [section01 addObject:self.contentEleEmptyCell];
        }
        if (section01.count>0) [sections addObject:section01];
    }];
    
    //他们已参加
    if (_data.joinMember.count>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        [section03 addObject:self.freeJoinCell];
        if (section03.count>0) [sections addObject:section03];
    }
    
    NSMutableArray *section02 = [NSMutableArray new];
    if ([_data.time.desc isNotNull] && _data.time.times.count>0) {
        [section02 addObject:self.dateCell];
    }
    if (_data.store.count>0) {
        [section02 addObject:self.addressCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    
    //detail
    NSMutableArray *section04 = [NSMutableArray new];
    switch (_data.showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            [section04 addObject:self.twoColumnWebViewCell];
            self.twoColumnCell = self.twoColumnWebViewCell;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            [section04 addObject:self.twoColumnConsultTipCell];
            self.twoColumnCell = self.twoColumnConsultTipCell;
            
            NSArray<ProductDetailConsultItem *> *consults = self.data.consults;
            if (consults.count<1) {
                [section04 addObject:self.twoColumnConsultEmptyCell];
            }else{
                [consults enumerateObjectsUsingBlock:^(ProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
                    ProductDetailTwoColumnConsultConsultCell *consultCell = self.twoColumnConsultConsultCell;
                    consultCell.item = obj;
                    [section04 addObject:consultCell];
                }];
                [section04 addObject:self.twoColumnConsultMoreCell];
            }
        }
            break;
    }
    _twoColumnSectionUsed = sections.count;
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
    if (_data.coupons.count>0 && _data.canProvideCoupon) {
        NSMutableArray *section06 = [NSMutableArray new];
        [section06 addObject:self.couponCell];
        if (section06.count>0) [sections addObject:section06];
    }
    
    //购买须知
    NSMutableArray *section07 = [NSMutableArray new];
    ProductDetailTitleCell *titleCell07 = self.titleCell;
    titleCell07.text = @"购买须知";
    [section07 addObject:titleCell07];
    if (_data.insurance.items.count>0) {
        [section07 addObject:self.noticeCell];
    }
    if (_data.attApply.count>0) {
        [_data.attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailApplyCell *applyCell = self.applyCell;
            applyCell.attStr = obj;
            [section07 addObject:applyCell];
        }];
    }
    [section07 addObject:self.contactCell];
    if (section07.count>0) [sections addObject:section07];
    
    
    //活动评价
    if (_data.commentList.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell08 = self.titleCell;
        titleCell08.text = @"活动评价";
        [section08 addObject:titleCell08];
        [_data.commentList enumerateObjectsUsingBlock:^(ProduceDetialCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=5) {
                *stop = YES;
            }else{
                ProductDetailCommentCell *commentCell = self.commentCell;
                commentCell.index = idx;
                [section08 addObject:commentCell];
            }
        }];
        [section08 addObject:self.commentMoreCell];
        if (section08.count>0) [sections addObject:section08];
    }
    
    NSMutableArray *section09 = [NSMutableArray new];
    if (_data.store.count>0){
        [section09 addObject:self.freeStoreInfoCell];
    }
    if (section09.count>0) [sections addObject:section09];
    
    NSMutableArray *section10 = [NSMutableArray new];
    if (_data.tricks.count>0) {
        [section10 addObject:self.freeLifeTipCell];
    }
    if (section10.count>0) [sections addObject:section10];
    
    if (_data.recommends.count>0) {
        NSMutableArray *section11 = [NSMutableArray new];
        ProductDetailTitleCell *titleCell09 = self.titleCell;
        titleCell09.text = @"为您推荐";
        [section11 addObject:titleCell09];
        [_data.recommends enumerateObjectsUsingBlock:^(ProductDetailRecommendItem *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailRecommendCell *recommendCell = self.recommendCell;
            recommendCell.index = idx;
            [section11 addObject:recommendCell];
        }];
        if (section11.count>0) [sections addObject:section11];
    }
    
    return [NSArray arrayWithArray:sections];
}

#pragma mark - toolBar

- (ProductDetailBaseToolBar *)toolBar {
    if (!_toolBar)
    {
        switch (_type) {
            case ProductDetailTypeNormal:
            {
                _toolBar = [self viewWithNib:@"ProductDetailNormalToolBar"];
            }
                break;
            case ProductDetailTypeTicket:
            {
                _toolBar = [self viewWithNib:@"ProductDetailTicketToolBar"];
            }
                break;
            case ProductDetailTypeFree:
            {
                _toolBar = [self viewWithNib:@"ProductDetaiFreeToolBar"];
            }
                break;
        }
    }
    return _toolBar;
}

- (ProductDetailCountDownView *)countDownView {
    if (!_countDownView)
    {
        _countDownView = [self viewWithNib:@"ProductDetailCountDownView"];
    }
    return _countDownView;
}

- (ProductDetailTwoColumnToolBar *)twoColumnToolBar {
    if (!_twoColumnToolBar)
    {
        _twoColumnToolBar = [self viewWithNib:@"ProductDetailTwoColumnToolBar"];
    }
    return _twoColumnToolBar;
}

#pragma mark - viewWithNib

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)nilViews {
    [self nilHeader];
    [self nilCells];
    [self nilToolBar];
}

- (void)nilHeader {
    _header = nil;
}

- (void)nilCells {
    
    _bannerCell = nil;
    _infoCell = nil;
    _dateCell = nil;
    _addressCell = nil;
    _joinCell = nil;
    _twoColumnWebViewCell = nil;
    _twoColumnConsultTipCell = nil;
    _twoColumnConsultEmptyCell = nil;
    _twoColumnConsultMoreCell = nil;
    _couponCell = nil;
    _noticeCell = nil;
    _contactCell = nil;
    _commentMoreCell = nil;
    
    _ticketInfoCell = nil;
    _ticketDesCell = nil;
    _ticketDesBtnCell = nil;
    _ticketPromiseCell = nil;
    _ticketActorCell = nil;
    
    _freeInfoCell = nil;
    _freeJoinCell = nil;
    _freeStoreInfoCell = nil;
    _freeLifeTipCell = nil;
}

- (void)nilToolBar {
    _toolBar = nil;
    _countDownView = nil;
    _twoColumnToolBar = nil;
}

@end
