//
//  StrategyDetailRelatedServiceListViewController.h
//  KidsTC
//
//  Created by Altair on 1/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class StrategyDetailServiceItemModel;

@interface StrategyDetailRelatedServiceListViewController : ViewController

- (instancetype)initWithListItemModels:(NSArray<StrategyDetailServiceItemModel *> *)models;

@end
