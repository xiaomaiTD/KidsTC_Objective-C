//
//  WholesaleProductDetailOtherProductModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailOtherProduct.h"
#import "WholesaleProductDetailCount.h"

@interface WholesaleProductDetailOtherProductModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<WholesaleProductDetailOtherProduct *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
