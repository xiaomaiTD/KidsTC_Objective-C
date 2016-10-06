//
//  FDToolBarView.h
//  KidsTC
//
//  Created by zhanping on 5/18/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashDetailModel.h"
@interface FDItemButton : UIButton

@end

typedef enum : NSUInteger {
    FDToolBarViewBtnType_Invite=1,
    FDToolBarViewBtnType_BuyNow,
    FDToolBarViewBtnType_FlashBuy
} FDToolBarViewBtnType;

@class FDToolBarView;
@protocol FDToolBarViewDelegate <NSObject>
- (void)toolBarView:(FDToolBarView *)toolBarView didClickOnType:(FDToolBarViewBtnType)type;
- (void)toolBarViewdidEndTimeCountdown:(FDToolBarView *)toolBarView;
@end
@interface FDToolBarView : UIView
@property (nonatomic, weak) id<FDToolBarViewDelegate> delegate;
@property (nonatomic, weak) FDData *data;

@end
