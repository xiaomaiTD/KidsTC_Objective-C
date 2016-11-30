//
//  CollectProductAllCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectProductItem.h"

@interface CollectProductAllCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, strong) CollectProductItem *item;
@property (nonatomic, copy) void(^deleteAction)();
@end
