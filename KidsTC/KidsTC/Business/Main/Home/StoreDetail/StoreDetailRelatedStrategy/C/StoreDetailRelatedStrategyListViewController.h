//
//  StoreDetailRelatedStrategyListViewController.h
//  KidsTC
//
//  Created by Altair on 1/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class StoreRelatedStrategyModel;

@interface StoreDetailRelatedStrategyListViewController : ViewController

- (instancetype)initWithListItemModels:(NSArray<StoreRelatedStrategyModel *> *)models;

@end
