//
//  ProductDetailFreeApplySelectPlaceCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailPlace.h"
@interface ProductDetailFreeApplySelectPlaceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (nonatomic, strong) ProductDetailPlace *place;
@end
