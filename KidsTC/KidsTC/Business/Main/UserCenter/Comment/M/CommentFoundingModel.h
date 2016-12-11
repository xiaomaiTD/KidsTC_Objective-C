//
//  CommentFoundingModel.h
//  KidsTC
//
//  Created by Altair on 11/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "AppointmentOrderModel.h"
#import "StoreDetailModel.h"
#import "KTCCommentManager.h"
#import "CommentScoreConfigModel.h"
#import "ServiceOrderDetailModel.h"
#import "FlashServiceOrderDetailModel.h"
#import "FlashServiceOrderListModel.h"
#import "ProductOrderListItem.h"
#import "ProductOrderFreeListItem.h"
#import "ProductOrderFreeDetailData.h"

@interface CommentFoundingModel : NSObject

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *relationSysNo;

@property (nonatomic, assign) CommentRelationType relationType;

@property (nonatomic, assign) CommentFoundingSourceType sourceType;

@property (nonatomic, strong) NSURL *imageUrl;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *objectName;

@property (nonatomic, copy) NSString *commentText;

@property (nonatomic, strong) NSArray *uploadPhotoLocationStrings;

@property (nonatomic, strong) CommentScoreConfigModel *scoreConfigModel;

@property (nonatomic, assign) BOOL needHideName;

+ (instancetype)modelFromServiceOrderModel:(OrderModel *)orderModel;

+ (instancetype)modelFromStoreAppointmentModel:(AppointmentOrderModel *)orderModel;

+ (instancetype)modelFromStore:(StoreDetailModel *)detailModel;

+ (instancetype)modelFromFlashServiceOrderListItem:(FlashServiceOrderListItem *)item;

+ (instancetype)modelFromFlashServiceOrderDetailData:(FlashServiceOrderDetailData *)data;

+ (instancetype)modelFromServiceOrderDetailModel:(ServiceOrderDetailModel *)orderModel;

+ (instancetype)modelFromProductOrderListItem:(ProductOrderListItem *)item;

+ (instancetype)modelFromProductOrderFreeListItem:(ProductOrderFreeListItem *)item;

+ (instancetype)modelFromProductOrderFreeDetailData:(ProductOrderFreeDetailData *)data;

@end
