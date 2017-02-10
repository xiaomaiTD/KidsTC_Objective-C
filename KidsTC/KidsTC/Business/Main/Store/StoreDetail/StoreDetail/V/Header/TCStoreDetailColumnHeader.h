//
//  TCStoreDetailColumnHeader.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCStoreDetailData.h"

extern CGFloat const kTCStoreDetailColumnHeaderH;

@class TCStoreDetailColumnHeader;
@protocol TCStoreDetailColumnHeaderDelegate <NSObject>
- (void)tcStoreDetailColumnHeader:(TCStoreDetailColumnHeader *)haeder didSelectColumn:(TCStoreDetailColumn *)column;
@end

@interface TCStoreDetailColumnHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) TCStoreDetailData *data;
@property (nonatomic, copy) void(^actionBlock)();
@property (nonatomic, weak) id<TCStoreDetailColumnHeaderDelegate> delegate;
- (void)selectColumn:(TCStoreDetailColumn *)column;
@end
