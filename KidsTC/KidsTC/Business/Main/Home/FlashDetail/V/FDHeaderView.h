//
//  FDHeaderView.h
//  KidsTC
//
//  Created by zhanping on 5/17/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashDetailModel.h"
#import "TTTAttributedLabel.h"
#import "SegueModel.h"
#import "StoreListItemModel.h"

/**
 *  小编寄语
 */
@interface FDNoteView : UIView
@property (nonatomic, weak) FDNote *note;
@end

/**
 *  购买须知
 */
@interface FDPurchaseNotesView : UIView
@property (nonatomic, weak) NSArray<FDBuyNoticeItem *> *buyNotice;
@end

/**
 *  简介
 */
@interface FDBriefIntroductionView : UIView
@property (nonatomic, weak) NSString *contentString;
@end

/**
 *  闪购流程
 */
@interface FDFlowView : UIView
@property (nonatomic, weak) FDData *data;
@end

/**
 *  产品信息
 */
@interface FDInfoView : UIView
@property (nonatomic, weak) FDData *data;
@end

/**
 *  地理位置信息
 */
@interface FDMapaddrLabel : UILabel
@property (nonatomic, weak) NSArray<NSDictionary *> *store;

@end

/**
 *  头视图
 */
@class FDHeaderView;
@protocol FDHeaderViewDelegate <NSObject>
- (void)fdHeaderView:(FDHeaderView *)fdHeaderView didClickOnMapLabelWithStore:(NSArray<StoreListItemModel *> *)store;
- (void)fdHeaderView:(FDHeaderView *)fdHeaderView didClickWithSegue:(SegueModel *)segue;
@end
@interface FDHeaderView : UIView
@property (nonatomic, weak) FDData *data;
@property (nonatomic, weak) id<FDHeaderViewDelegate> delegate;
@end
