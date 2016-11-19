//
//  ProductDetailTicketSelectSeatCollectionViewSeatCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailTicketSelectSeatSeat.h"

typedef enum : NSUInteger {
    ProductDetailTicketSelectSeatCollectionViewSeatCellActionTypeClickBtn = 1,
} ProductDetailTicketSelectSeatCollectionViewSeatCellActionType;


@class ProductDetailTicketSelectSeatCollectionViewSeatCell;
@protocol ProductDetailTicketSelectSeatCollectionViewSeatCellDelegate <NSObject>\
- (void)productDetailTicketSelectSeatCollectionViewSeatCell:(ProductDetailTicketSelectSeatCollectionViewSeatCell *)cell actionType:(ProductDetailTicketSelectSeatCollectionViewSeatCellActionType)type value:(id)value;

@end

@interface ProductDetailTicketSelectSeatCollectionViewSeatCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<ProductDetailTicketSelectSeatCollectionViewSeatCellDelegate> delegate;
@property (nonatomic, strong) ProductDetailTicketSelectSeatSeat *seat;
@end
