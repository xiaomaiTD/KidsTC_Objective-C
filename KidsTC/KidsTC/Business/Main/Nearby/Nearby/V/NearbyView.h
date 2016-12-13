//
//  NearbyView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyCollectionViewCell.h"
#import "NearbyModel.h"
#import "NearbyCategoryToolBarItem.h"

typedef enum : NSUInteger {
    NearbyViewActionTypeNursery = 1,
    NearbyViewActionTypeExhibition = 2,
    NearbyViewActionTypeCalendar = 3,
    NearbyViewActionTypeLoadData = 4,
    NearbyViewActionTypeSegue = 5,
    NearbyViewActionTypeLike = 6,
    NearbyViewActionTypeDidSelectCategory = 50,
} NearbyViewActionType;
@class NearbyView;
@protocol NearbyViewDelegate <NSObject>
- (void)nearbyView:(NearbyView *)view nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyViewActionType)type value:(id)value;
@end
@interface NearbyView : UIView
@property (nonatomic, weak) id<NearbyViewDelegate> delegate;
@property (nonatomic, weak) NSArray<NearbyData *> *datas;
@end
