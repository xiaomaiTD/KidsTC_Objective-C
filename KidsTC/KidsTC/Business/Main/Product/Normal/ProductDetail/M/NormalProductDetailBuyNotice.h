//
//  NormalProductDetailBuyNotice.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailNotice.h"

@interface NormalProductDetailBuyNotice : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<NormalProductDetailNotice *> *notice;
@end
