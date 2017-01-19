//
//  ProductDetailTicketSelectSeatNumView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/19.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailTicketSelectSeatSeat.h"
typedef enum : NSUInteger {
    ProductDetailTicketSeatNumActionTypeBuyCountDidChange = 1,
} ProductDetailTicketSeatNumActionType;
@class ProductDetailTicketSelectSeatNumView;
@protocol ProductDetailTicketSelectSeatNumViewDelegate <NSObject>
- (void)productDetailTicketSelectSeatNumView:(ProductDetailTicketSelectSeatNumView *)view actionType:(ProductDetailTicketSeatNumActionType)type value:(id)value;
@end

@interface ProductDetailTicketSelectSeatNumView : UIView
@property (nonatomic, weak) id<ProductDetailTicketSelectSeatNumViewDelegate> delegate;
@property (nonatomic, strong) ProductDetailTicketSelectSeatSeat *seat;
@end
