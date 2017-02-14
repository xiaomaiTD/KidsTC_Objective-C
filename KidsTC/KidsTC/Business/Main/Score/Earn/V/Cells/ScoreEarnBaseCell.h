//
//  ScoreEarnBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreUserInfoData.h"
#import "ScoreOrderItem.h"
#import "ScoreProductData.h"
#import "ScoreEarnShowItem.h"

typedef enum : NSUInteger {
    ScoreEarnBaseCellActionTypePlant = 50,
    ScoreEarnBaseCellActionTypeExchange,
    ScoreEarnBaseCellActionTypeOrderDetail,
    ScoreEarnBaseCellActionTypeContact,
    ScoreEarnBaseCellActionTypeComment,
    ScoreEarnBaseCellActionTypeSegue,
} ScoreEarnBaseCellActionType;
@class ScoreEarnBaseCell;

@protocol ScoreEarnBaseCellDelegate <NSObject>
- (void)scoreEarnBaseCell:(ScoreEarnBaseCell *)cell actionType:(ScoreEarnBaseCellActionType)type value:(id)value;
@end

@interface ScoreEarnBaseCell : UITableViewCell
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,strong) NSArray<ScoreOrderItem *> *orderItems;
@property (nonatomic,strong) ScoreProductData *productData;
@property (nonatomic,  weak) id<ScoreEarnBaseCellDelegate> delegate;
@property (nonatomic,strong) ScoreEarnShowItem *item;
@end
