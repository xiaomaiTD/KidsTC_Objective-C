//
//  TCStoreDetailColumn.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailColumn.h"

@implementation TCStoreDetailColumn
+ (instancetype)columnWithType:(TCStoreDetailColumnColumnType)type title:(NSString *)title select:(BOOL)select indexPath:(NSIndexPath *)indexPath {
    TCStoreDetailColumn *column = [TCStoreDetailColumn new];
    column.type = type;
    column.title = title;
    column.select = select;
    column.indexPath = indexPath;
    return column;
}
- (void)setSelect:(BOOL)select {
    _select = select;
    self.targetBtn.selected = select;
}
@end
