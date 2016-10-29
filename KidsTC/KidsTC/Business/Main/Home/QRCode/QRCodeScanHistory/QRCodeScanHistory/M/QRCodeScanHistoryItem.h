//
//  QRCodeScanHistoryItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "Model.h"
#import "SegueModel.h"
typedef enum : NSUInteger {
    QRCodeScanHistoryItemTypeQRCode=1,
    QRCodeScanHistoryItemTypeBarCode,
    QRCodeScanHistoryItemTypeProduct,
} QRCodeScanHistoryItemType;

@interface QRCodeScanHistoryItem : Model
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) QRCodeScanHistoryItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) SegueModel *segueModel;
@end
