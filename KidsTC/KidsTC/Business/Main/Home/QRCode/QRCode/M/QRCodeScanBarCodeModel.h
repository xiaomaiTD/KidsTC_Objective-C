//
//  QRCodeScanBarCodeModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface QRCodeScanBarCodeData : NSObject
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface QRCodeScanBarCodeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) QRCodeScanBarCodeData *data;
@end
