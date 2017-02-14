//
//  ScoreConsumeShowItem.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreProductItem.h"
#import "ScoreUserInfoData.h"
@interface ScoreConsumeShowItem : NSObject
@property (nonatomic,strong) NSString *cellId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) ScoreProductItem *item;
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
+ (instancetype)itemWithCellId:(NSString *)cellId title:(NSString *)title item:(ScoreProductItem *)item;
@end
