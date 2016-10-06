//
//  SettlementResultShareViewController.h
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

#import "SettlementResultShareModel.h"
@interface SettlementResultShareViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) SettlementResultShareModel *model;
@property (nonatomic, copy) void (^resultBlock)(SettlementResultShareData *data);
@end
