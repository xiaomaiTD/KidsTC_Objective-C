//
//  StrategyTagColumnModel.h
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StrategyModel.h"


@interface StrategyTagColumnShare : NSObject
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *shareUrl;
@end

@interface StrategyTagColumnData : NSObject
@property (nonatomic, strong) StrategyTagColumnShare *share;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<StrategyListItem *> *list;
@end


@interface StrategyTagColumnModel : NSObject
@property (nonatomic, strong) StrategyTagColumnData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger page;
@end
