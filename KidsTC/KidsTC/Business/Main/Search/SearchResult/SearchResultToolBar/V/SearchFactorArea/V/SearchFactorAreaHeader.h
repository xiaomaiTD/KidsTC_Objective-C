//
//  SearchFactorAreaHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorAreaDataItem.h"
@interface SearchFactorAreaHeader : UICollectionReusableView
@property (nonatomic, strong) SearchFactorAreaDataItem *item;
@property (nonatomic, copy) void(^actionBlock)(SearchFactorAreaDataItem *item);
@end
