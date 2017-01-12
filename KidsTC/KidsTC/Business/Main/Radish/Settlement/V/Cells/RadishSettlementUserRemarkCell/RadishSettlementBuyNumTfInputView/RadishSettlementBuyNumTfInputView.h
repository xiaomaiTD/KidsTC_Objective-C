//
//  RadishSettlementBuyNumTfInputView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RadishSettlementBuyNumTfInputViewActionTypeCancel = 1,
    RadishSettlementBuyNumTfInputViewActionTypeSure,
} RadishSettlementBuyNumTfInputViewActionType;

@class RadishSettlementBuyNumTfInputView;
@protocol RadishSettlementBuyNumTfInputViewDelegate <NSObject>
- (void)radishSettlementBuyNumTfInputView:(RadishSettlementBuyNumTfInputView *)view actionType:(RadishSettlementBuyNumTfInputViewActionType)type value:(id)value;
@end

@interface RadishSettlementBuyNumTfInputView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (nonatomic, weak) id<RadishSettlementBuyNumTfInputViewDelegate> delegate;
@end
