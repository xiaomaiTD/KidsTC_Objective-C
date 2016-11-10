//
//  ProductDetailSubViewsProvider.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSubViewsProvider.h"
#import "NSString+Category.h"

#import "ProductDetailBannerCell.h"
#import "ProductDetailInfoCell.h"
#import "ProductDetailDateCell.h"
#import "ProductDetailAddressCell.h"
#import "ProductDetailTitleCell.h"
#import "ProductDetailContentEleCell.h"
#import "ProductDetailContentEleEmptyCell.h"
#import "ProductDetailJoinCell.h"
#import "ProductDetailTwoColumnCell.h"
#import "ProductDetailTwoColumnBottomBarCell.h"
#import "ProductDetailStandardCell.h"
#import "ProductDetailCouponCell.h"
#import "ProductDetailNoticeCell.h"
#import "ProductDetailApplyCell.h"
#import "ProductDetailContactCell.h"
#import "ProductDetailCommentCell.h"
#import "ProductDetailCommentMoreCell.h"
#import "ProductDetailRecommendCell.h"

#import "ProductDetailNormalToolBar.h"
#import "ProductDetailTicketToolBar.h"
#import "ProductDetaiFreeToolBar.h"

@implementation ProductDetailSubViewsProvider
singleM(ProductDetailSubViewsProvider)

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)sections {
    
    NSArray<NSArray<ProductDetailBaseCell *> *> *sections = nil;
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            sections = [self normalSections];
        }
            break;
        case ProductDetailTypeTicket:
        {
            sections = [self normalSections];
        }
            break;
        case ProductDetailTypeFree:
        {
            sections = [self normalSections];
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
    _twoColumnCellUsed = self.twoColumnCell;
    _twoColumnBottomBarCellUsed = self.twoColumnBottomBarCell;
    [section04 addObject:_twoColumnCellUsed];
    [section04 addObject:_twoColumnBottomBarCellUsed];
    _twoColumnSectionUsed = sections.count;
    if (section04.count>0) {
        [sections addObject:section04];
    }
    
    
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

#pragma mark - cells

- (ProductDetailBannerCell *)bannerCell {
    return [self viewWithNib:@"ProductDetailBannerCell"];
}

- (ProductDetailInfoCell *)infoCell {
    return [self viewWithNib:@"ProductDetailInfoCell"];
}

- (ProductDetailDateCell *)dateCell {
    return [self viewWithNib:@"ProductDetailDateCell"];
}

- (ProductDetailAddressCell *)addressCell {
    return [self viewWithNib:@"ProductDetailAddressCell"];
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
    return [self viewWithNib:@"ProductDetailJoinCell"];
}

- (ProductDetailTwoColumnCell *)twoColumnCell {
    return [self viewWithNib:@"ProductDetailTwoColumnCell"];
}

- (ProductDetailTwoColumnBottomBarCell *)twoColumnBottomBarCell {
    return [self viewWithNib:@"ProductDetailTwoColumnBottomBarCell"];
}

- (ProductDetailStandardCell *)standardCell {
    return [self viewWithNib:@"ProductDetailStandardCell"];
}

- (ProductDetailCouponCell *)couponCell {
    return [self viewWithNib:@"ProductDetailCouponCell"];
}

- (ProductDetailNoticeCell *)noticeCell {
    return [self viewWithNib:@"ProductDetailNoticeCell"];
}

- (ProductDetailApplyCell *)applyCell {
    return [self viewWithNib:@"ProductDetailApplyCell"];
}

- (ProductDetailContactCell *)contactCell {
    return [self viewWithNib:@"ProductDetailContactCell"];
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

#pragma mark - toolBar

- (ProductDetailTwoColumnToolBar *)twoColumnToolBar {
    return [self viewWithNib:@"ProductDetailTwoColumnToolBar"];
}

- (ProductDetailCountDownView *)countDownView {
    return [self viewWithNib:@"ProductDetailCountDownView"];
}

- (ProductDetailBaseToolBar *)toolBar {
    
    ProductDetailBaseToolBar *toolBar = nil;
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            toolBar = [self viewWithNib:@"ProductDetailNormalToolBar"];
        }
            break;
        case ProductDetailTypeTicket:
        {
            toolBar = [self viewWithNib:@"ProductDetailTicketToolBar"];
        }
            break;
        case ProductDetailTypeFree:
        {
            toolBar = [self viewWithNib:@"ProductDetaiFreeToolBar"];
        }
            break;
    }
    
    return toolBar;
}

#pragma mark - viewWithNib

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

@end
