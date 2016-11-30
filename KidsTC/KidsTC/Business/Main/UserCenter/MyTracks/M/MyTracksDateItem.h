//
//  MyTracksDateItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksItem.h"

@interface MyTracksDateItem : NSObject
@property (nonatomic, strong) NSString *timeDesc;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<MyTracksItem *> *BrowseHistoryLst;
@end
