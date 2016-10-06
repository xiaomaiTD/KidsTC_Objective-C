//
//  FDChooseStoreView.h
//  KidsTC
//
//  Created by zhanping on 5/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashDetailModel.h"

@interface FDChooseStoreView : UIView
@property (nonatomic, weak) FDData *data;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, copy) void (^commitBlock) (NSString *selectedStoreId);
@end
