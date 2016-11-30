//
//  MyTracksCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTracksItem.h"
@interface MyTracksCell : UITableViewCell
@property (nonatomic, strong) MyTracksItem *item;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) void(^deleteAction)();
@end
