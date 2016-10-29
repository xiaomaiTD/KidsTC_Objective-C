//
//  QRCodeScanBarCodeModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface QRCodeScanBarCodeProduct : NSObject
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imageUrl;
@end

@interface QRCodeScanBarCodeData : NSObject
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) QRCodeScanBarCodeProduct *product;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface QRCodeScanBarCodeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) QRCodeScanBarCodeData *data;
@end
