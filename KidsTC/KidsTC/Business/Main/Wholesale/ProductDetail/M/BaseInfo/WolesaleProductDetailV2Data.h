//
//  WolesaleProductDetailV2Data.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WolesaleProductDetailV2Data : NSObject
@property (nonatomic, strong) NSString *promotionText;
@property (nonatomic, strong) NSArray<NSString *> *banners;
@property (nonatomic, strong) NSString *savingPrice;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, strong) NSString *timeDesc;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attPpromotionText;
@end
