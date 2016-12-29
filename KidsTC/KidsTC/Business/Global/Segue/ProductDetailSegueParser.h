//
//  ProductDetailSegueParser.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface ProductDetailSegueParser : NSObject
+ (SegueModel *)segueModelWithProductType:(ProductDetailType)productType productId:(NSString *)productId channelId:(NSString *)channelId;
@end
