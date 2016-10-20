//
//  TCHomeMainCollectionCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/17.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHomeCategory.h"

typedef enum : NSUInteger {
    TCHomeMainCollectionCellActionTypeLoadData=1,
    TCHomeMainCollectionCellActionTypeSegue,
    TCHomeMainCollectionCellActionTypeScroll,
    TCHomeMainCollectionCellActionTypeHomeRefresh
} TCHomeMainCollectionCellActionType;

@class TCHomeMainCollectionCell;
@protocol TCHomeMainCollectionCellDelegate <NSObject>
- (void)tcHomeMainCollectionCell:(TCHomeMainCollectionCell *)cell actionType:(TCHomeMainCollectionCellActionType)type value:(id)value;
@end

@interface TCHomeMainCollectionCell : UICollectionViewCell
@property (nonatomic, strong) TCHomeCategory *category;
@property (nonatomic, weak) id<TCHomeMainCollectionCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)backToTop;
- (void)scrollTo:(NSIndexPath *)indexPath;
@end
