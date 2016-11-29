//
//  CollectionTarentoFooter.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionTarentoItem.h"
@interface CollectionTarentoFooter : UITableViewHeaderFooterView
@property (nonatomic, strong) CollectionTarentoItem *item;
@property (nonatomic, copy) void(^actionBlock)(CollectionTarentoItem *item);
@end
