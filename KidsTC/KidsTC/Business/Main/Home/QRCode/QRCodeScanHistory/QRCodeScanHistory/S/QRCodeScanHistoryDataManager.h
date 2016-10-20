//
//  QRCodeScanHistoryDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "QRCodeScanHistoryItem.h"
@interface QRCodeScanHistoryDataManager : NSObject
singleH(QRCodeScanHistoryDataManager)
@property (nonatomic, strong) NSMutableArray<QRCodeScanHistoryItem *> *items;
- (void)addItem:(QRCodeScanHistoryItem *)item;
- (void)remove:(NSUInteger)index;
- (void)cleanUp;
@end
