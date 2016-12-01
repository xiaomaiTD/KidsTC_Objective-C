//
//  CollectProductReduceCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectProductItem.h"
@interface CollectProductReduceCell : UITableViewCell
@property (nonatomic, strong) CollectProductItem *item;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) void(^deleteAction)();
@end
