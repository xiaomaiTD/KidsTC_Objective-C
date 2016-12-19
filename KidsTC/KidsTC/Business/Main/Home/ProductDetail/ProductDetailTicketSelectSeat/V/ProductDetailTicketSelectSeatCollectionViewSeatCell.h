//
//  ProductDetailTicketSelectSeatCollectionViewSeatCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailTicketSelectSeatSeat.h"

@interface ProductDetailTicketSelectSeatCollectionViewSeatCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *seatL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *origionalPriceL;
@property (nonatomic, strong) ProductDetailTicketSelectSeatSeat *seat;
@end
