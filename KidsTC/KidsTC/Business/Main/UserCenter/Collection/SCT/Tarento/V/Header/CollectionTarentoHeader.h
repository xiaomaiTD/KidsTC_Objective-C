//
//  CollectionTarentoHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionTarentoItem.h"

@interface CollectionTarentoHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, strong) CollectionTarentoItem *item;
@property (nonatomic, copy) void(^actionBlock)(CollectionTarentoItem *item);
@property (nonatomic, copy) void(^deleteBlock)(CollectionTarentoItem *item);
@end
