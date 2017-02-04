//
//  WholesaleProductDetailBuyNotice.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleProductDetailNotice.h"

@interface WholesaleProductDetailBuyNotice : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<WholesaleProductDetailNotice *> *notice;
@end
