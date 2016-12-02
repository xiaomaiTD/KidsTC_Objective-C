//
//  NearbyCollectionViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyCollectionViewCellActionTypeNursery = 1,
    NearbyCollectionViewCellActionTypeExhibition,
    NearbyCollectionViewCellActionTypeCalendar,
    
} NearbyCollectionViewCellActionType;

@class NearbyCollectionViewCell;
@protocol NearbyCollectionViewCellDelegate <NSObject>
- (void)nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyCollectionViewCellActionType)type value:(id)value;
@end

@interface NearbyCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<NearbyCollectionViewCellDelegate> delegate;
@end
