//
//  ProductOrderNormalDetailPayInfoCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailBaseCell.h"

typedef enum : NSUInteger {
    ProductOrderNormalDetailPayInfoCellTypeTypePrice=1,
    ProductOrderNormalDetailPayInfoCellTypeTypePromotion,
    ProductOrderNormalDetailPayInfoCellTypeTypeScore,
    ProductOrderNormalDetailPayInfoCellTypeTransportationExpenses
} ProductOrderNormalDetailPayInfoCellType;

@interface ProductOrderNormalDetailPayInfoCell : ProductOrderNormalDetailBaseCell
@property (nonatomic, assign) ProductOrderNormalDetailPayInfoCellType type;
@end
