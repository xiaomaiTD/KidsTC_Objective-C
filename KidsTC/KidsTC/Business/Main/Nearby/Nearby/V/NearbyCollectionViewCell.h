//
//  NearbyCollectionViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"
#import "MultiItemsToolBar.h"
typedef enum : NSUInteger {
    NearbyCollectionViewCellActionTypeNursery = 1,
    NearbyCollectionViewCellActionTypeExhibition = 2,
    NearbyCollectionViewCellActionTypeCalendar = 3,
    
    
    NearbyCollectionViewCellActionTypeLoadData = 100,
    NearbyCollectionViewCellActionTypeSegue = 101,
    NearbyCollectionViewCellActionTypeLike = 102,
} NearbyCollectionViewCellActionType;

@class NearbyCollectionViewCell;
@protocol NearbyCollectionViewCellDelegate <NSObject>
- (void)nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyCollectionViewCellActionType)type value:(id)value;
@end

@interface NearbyCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<NearbyCollectionViewCellDelegate> delegate;
@property (nonatomic, weak) NearbyData *data;
@property (nonatomic, assign) NSInteger index;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
