//
//  WholesaleOrderListItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleOrderListBtn.h"
#import "WholesaleOrderListCountDown.h"
#import "WholesaleProductDetailShare.h"
#import "CommonShareObject.h"
#import "SegueModel.h"

@interface WholesaleOrderListItem : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *fightGroupSysNo;
@property (nonatomic, strong) NSString *fightGroupOpenGroupSysNo;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, assign) BOOL isRedirect;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) WholesaleProductDetailShare *share;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) WholesaleOrderListCountDown *countDown;
@property (nonatomic, strong) NSString *openGroupHeader;
@property (nonatomic, strong) NSString *openGroupUserName;
@property (nonatomic, strong) NSString *productImgae;
@property (nonatomic, strong) NSString *fightGroupUserCount;
@property (nonatomic, strong) NSString *surplusCountDesc;
@property (nonatomic, strong) NSArray<NSNumber *> *btns;
@property (nonatomic, assign) WholesaleOrderListBtnType defaultBtn;
@property (nonatomic,strong) NSString *commentNo;
@property (nonatomic,assign) NSInteger commentRelationType;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, strong) NSArray<WholesaleOrderListBtn *> *orderBtns;
@property (nonatomic, strong) CommonShareObject *shareObject;
@end
