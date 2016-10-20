//
//  QRCodeScanHistoryTableViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeScanHistoryItem.h"
@interface QRCodeScanHistoryTableViewCell : UITableViewCell
@property (nonatomic, strong) QRCodeScanHistoryItem *item;
@end
