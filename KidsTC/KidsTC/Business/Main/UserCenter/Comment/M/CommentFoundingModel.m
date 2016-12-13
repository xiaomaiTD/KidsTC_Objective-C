//
//  CommentFoundingModel.m
//  KidsTC
//
//  Created by Altair on 11/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentFoundingModel.h"

@implementation CommentFoundingModel

+ (instancetype)modelFromServiceOrderModel:(OrderModel *)orderModel {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = orderModel.orderId;
    commentModel.relationSysNo = orderModel.serviceId;
    commentModel.sourceType = (CommentFoundingSourceType)orderModel.productType;
    commentModel.objectId = orderModel.serviceId;
    commentModel.relationType = (CommentRelationType)orderModel.productType;
    commentModel.objectName = orderModel.orderName;
    commentModel.imageUrl = orderModel.imageUrl;
    return commentModel;
}


+ (instancetype)modelFromStoreAppointmentModel:(AppointmentOrderModel *)orderModel {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.relationSysNo = orderModel.storeId;
    commentModel.orderId = orderModel.orderId;
    commentModel.sourceType = CommentFoundingSourceTypeStore;
    commentModel.relationType = CommentRelationTypeStore;
    commentModel.objectId = orderModel.storeId;
    commentModel.objectName = orderModel.storeName;
    commentModel.imageUrl = orderModel.imageUrl;
    return commentModel;
}

+ (instancetype)modelFromStore:(StoreDetailModel *)detailModel {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.relationSysNo = detailModel.storeId;
    commentModel.sourceType = CommentFoundingSourceTypeStore;
    commentModel.relationType = CommentRelationTypeStore;
    commentModel.objectId = detailModel.storeId;
    commentModel.objectName = detailModel.storeName;
    commentModel.imageUrl = [detailModel.imageUrls firstObject];
    return commentModel;
}

+ (instancetype)modelFromFlashServiceOrderListItem:(FlashServiceOrderListItem *)item{
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.relationSysNo = item.productNo;
    commentModel.orderId = item.orderId;
    commentModel.sourceType = (CommentFoundingSourceType)item.productType;
    commentModel.relationType = (CommentRelationType)item.productType;
    commentModel.objectId = item.productNo;
    commentModel.objectName = item.productName;
    commentModel.imageUrl = [NSURL URLWithString:item.productImg];
    return commentModel;
}

+ (instancetype)modelFromFlashServiceOrderDetailData:(FlashServiceOrderDetailData *)data{
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.relationSysNo = data.productNo;
    commentModel.orderId = data.orderId;
    commentModel.sourceType = (CommentFoundingSourceType)data.productType;
    commentModel.relationType = (CommentRelationType)data.productType;
    commentModel.objectId = data.productNo;
    commentModel.objectName = data.productName;
    commentModel.imageUrl = [NSURL URLWithString:data.productImg];
    return commentModel;
}

+ (instancetype)modelFromServiceOrderDetailModel:(ServiceOrderDetailModel *)orderModel {
    ServiceOrderDetailData *data  = orderModel.data;
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = data.oderId;
    commentModel.relationSysNo = data.serveId;
    commentModel.sourceType = (CommentFoundingSourceType)data.productType;
    commentModel.objectId = data.serveId;
    commentModel.relationType = (CommentRelationType)data.productType;
    commentModel.objectName = data.name;
    commentModel.imageUrl = [NSURL URLWithString:data.imgUrl];
    return commentModel;
}

+ (instancetype)modelFromProductOrderListItem:(ProductOrderListItem *)item {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = item.orderNo;
    commentModel.relationSysNo = item.commentNo;
    commentModel.sourceType = (CommentFoundingSourceType)item.commentType;
    commentModel.objectId = item.commentNo;
    commentModel.relationType = (CommentRelationType)item.commentType;
    commentModel.objectName = item.productName;
    commentModel.imageUrl = [NSURL URLWithString:item.imgUrl];
    return commentModel;
}

+ (instancetype)modelFromProductOrderFreeListItem:(ProductOrderFreeListItem *)item {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = item.orderNo;
    commentModel.relationSysNo = item.productSysNo;
    commentModel.sourceType = (CommentFoundingSourceType)item.productType;
    commentModel.objectId = item.productSysNo;
    commentModel.relationType = (CommentRelationType)item.productType;
    commentModel.objectName = item.productName;
    commentModel.imageUrl = [NSURL URLWithString:item.productImg];
    return commentModel;
}

+ (instancetype)modelFromProductOrderFreeDetailData:(ProductOrderFreeDetailData *)data {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = data.orderNo;
    commentModel.relationSysNo = data.productSysNo;
    commentModel.sourceType = (CommentFoundingSourceType)data.productType;
    commentModel.objectId = data.productSysNo;
    commentModel.relationType = (CommentRelationType)data.productType;
    commentModel.objectName = data.productName;
    commentModel.imageUrl = [NSURL URLWithString:data.productImg];
    return commentModel;
}

+ (instancetype)modelFromProductOrderNormalDetailData:(ProductOrderNormalDetailData *)data {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = data.orderId;
    commentModel.relationSysNo = data.serveId;
    commentModel.sourceType = (CommentFoundingSourceType)data.productType;
    commentModel.objectId = data.serveId;
    commentModel.relationType = (CommentRelationType)data.productType;
    commentModel.objectName = data.name;
    commentModel.imageUrl = [NSURL URLWithString:data.imgUrl];
    return commentModel;
}

+ (instancetype)modelFromProductOrderTicketDetailData:(ProductOrderTicketDetailData *)data {
    CommentFoundingModel *commentModel = [[CommentFoundingModel alloc] init];
    commentModel.orderId = data.orderNo;
    commentModel.relationSysNo = data.productNo;
    commentModel.sourceType = CommentFoundingSourceTypeTicketProduct;
    commentModel.objectId = data.productNo;
    commentModel.relationType = CommentRelationTypeTicketProduct;
    commentModel.objectName = data.serveName;
    commentModel.imageUrl = [NSURL URLWithString:data.img];
    return commentModel;
}

@end
