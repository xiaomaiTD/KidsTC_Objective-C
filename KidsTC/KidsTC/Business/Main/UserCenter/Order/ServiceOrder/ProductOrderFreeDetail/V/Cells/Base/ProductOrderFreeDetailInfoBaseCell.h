//
//  ProductOrderFreeDetailInfoBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeDetailLotteryData.h"
#import "ProductOrderFreeDetailData.h"
@interface ProductOrderFreeDetailInfoBaseCell : UITableViewCell
@property (nonatomic, strong) ProductOrderFreeDetailLotteryData *lotteryData;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
@end
