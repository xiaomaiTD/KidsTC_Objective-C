//
//  NormalProductDetailColumnHeader.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalProductDetailData.h"

extern CGFloat const kNormalProductDetailColumnHeaderH;

@interface NormalProductDetailColumnHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) NormalProductDetailData *data;
@property (nonatomic, copy) void(^actionBlock)();
@end
