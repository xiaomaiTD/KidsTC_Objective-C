//
//  ProductOrderListItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderListBtn.h"
#import "ProductOrderListCountDown.h"
/*
 
 orderKind	Integer	1

 deliver	Null	null
 countDown	Null	null
 unitPrice	Integer	2980
 
 
 supplierMobie	Null	null
 reservationRemark	Null	null
 orderBtns	Array
 defaultBtn	Integer	12
 commentNo	Integer	0
 commentType	Integer	0
 */
@interface ProductOrderListItem : NSObject
@property (nonatomic, strong) NSString *orderNo;
//@property (nonatomic, strong) NSString *orderKind;
@property (nonatomic, strong) NSString *statusName;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *supplierIcon;
//@property (nonatomic, strong) NSString *deliver;
@property (nonatomic, strong) ProductOrderListCountDown *countDown;
@property (nonatomic, strong) NSString *unitPrice;
@property (nonatomic, strong) NSString *payNum;
@property (nonatomic, strong) NSString *payPrice;
@property (nonatomic, strong) NSString *supplierMobie;
@property (nonatomic, strong) NSString *reservationRemark;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) ProductOrderListBtnType defaultBtn;
@property (nonatomic, strong) NSString *commentNo;
@property (nonatomic, assign) NSInteger commentType;
//selfDefine
@property (nonatomic, strong) NSArray<ProductOrderListBtn *> *btns;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@end
