//
//  ProductDetailTicketSelectSeatCollectionViewNumFooter.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailTicketSelectSeatSeat.h"

typedef enum : NSUInteger {
    ProductDetailNumFooterActionTypeBuyCountDidChange = 1,
} ProductDetailNumFooterActionType;
@class ProductDetailTicketSelectSeatCollectionViewNumFooter;
@protocol ProductDetailTicketSelectSeatCollectionViewNumFooterDelegate <NSObject>
- (void)ProductDetailTicketSelectSeatCollectionViewNumFooter:(ProductDetailTicketSelectSeatCollectionViewNumFooter *)footer actionType:(ProductDetailNumFooterActionType)type value:(id)value;
@end

@interface ProductDetailTicketSelectSeatCollectionViewNumFooter : UICollectionReusableView
@property (nonatomic, weak) id<ProductDetailTicketSelectSeatCollectionViewNumFooterDelegate> delegate;
@property (nonatomic, strong) ProductDetailTicketSelectSeatSeat *seat;
@end
