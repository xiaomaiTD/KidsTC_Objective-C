//
//  TCStoreDetailColumn.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TCStoreDetailColumnColumnTypeWebDetail = 1,
    TCStoreDetailColumnColumnTypeComment,
    TCStoreDetailColumnColumnTypeFacility,
} TCStoreDetailColumnColumnType;

@interface TCStoreDetailColumn : NSObject
@property (nonatomic, assign) TCStoreDetailColumnColumnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) UIButton *targetBtn;
+ (instancetype)columnWithType:(TCStoreDetailColumnColumnType)type title:(NSString *)title select:(BOOL)select indexPath:(NSIndexPath *)indexPath;
@end
