//
//  QRCodeScanHistoryDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "QRCodeScanHistoryDataManager.h"
static NSString *const QRCodeScanHistoryDataFileName = @"QRCodeScanHistoryData";
@interface QRCodeScanHistoryDataManager ()

@end

@implementation QRCodeScanHistoryDataManager
singleM(QRCodeScanHistoryDataManager)

- (NSMutableArray<QRCodeScanHistoryItem *> *)items {
    if (!_items) {
        NSString *filePath = FILE_CACHE_PATH(QRCodeScanHistoryDataFileName);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            _items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)addItem:(QRCodeScanHistoryItem *)item {
    [self.items insertObject:item atIndex:0];
    [self save];
}

- (void)remove:(NSUInteger)index {
    if (index<self.items.count) {
        [self.items removeObjectAtIndex:index];
        [self save];
    }
}

- (void)cleanUp {
    self.items = [NSMutableArray array];
    [self save];
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.items];
    NSString *filePath = FILE_CACHE_PATH(QRCodeScanHistoryDataFileName);
    [data writeToFile:filePath atomically:YES];
}

@end
