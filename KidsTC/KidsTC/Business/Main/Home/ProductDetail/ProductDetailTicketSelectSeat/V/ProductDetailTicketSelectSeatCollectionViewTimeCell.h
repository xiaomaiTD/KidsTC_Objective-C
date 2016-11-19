//
//  ProductDetailTicketSelectSeatCollectionViewTimeCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailTicketSelectSeatTime.h"

typedef enum : NSUInteger {
    ProductDetailTicketSelectSeatCollectionViewTimeCellActionTypeClickBtn = 1,
} ProductDetailTicketSelectSeatCollectionViewTimeCellActionType;


@class ProductDetailTicketSelectSeatCollectionViewTimeCell;
@protocol ProductDetailTicketSelectSeatCollectionViewTimeCellDelegate <NSObject>\
- (void)productDetailTicketSelectSeatCollectionViewTimeCell:(ProductDetailTicketSelectSeatCollectionViewTimeCell *)cell actionType:(ProductDetailTicketSelectSeatCollectionViewTimeCellActionType)type value:(id)value;

@end


@interface ProductDetailTicketSelectSeatCollectionViewTimeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<ProductDetailTicketSelectSeatCollectionViewTimeCellDelegate> delegate;
@property (nonatomic, strong) ProductDetailTicketSelectSeatTime *time;
@end
