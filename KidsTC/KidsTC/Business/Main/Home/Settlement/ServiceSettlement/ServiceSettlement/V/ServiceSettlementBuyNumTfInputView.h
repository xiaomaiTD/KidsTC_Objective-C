//
//  ServiceSettlementBuyNumTfInputView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ServiceSettlementBuyNumTfInputViewActionTypeCancel = 1,
    ServiceSettlementBuyNumTfInputViewActionTypeSure,
} ServiceSettlementBuyNumTfInputViewActionType;

@class ServiceSettlementBuyNumTfInputView;
@protocol ServiceSettlementBuyNumTfInputViewDelegate <NSObject>

- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view actionType:(ServiceSettlementBuyNumTfInputViewActionType)type value:(id)value;

@end

@interface ServiceSettlementBuyNumTfInputView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (nonatomic, weak) id<ServiceSettlementBuyNumTfInputViewDelegate> delegate;
@end
