//
//  QRCodeScanBarCodeModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "QRCodeScanBarCodeModel.h"

@implementation QRCodeScanBarCodeProduct


@end

@implementation QRCodeScanBarCodeData
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end

@implementation QRCodeScanBarCodeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
