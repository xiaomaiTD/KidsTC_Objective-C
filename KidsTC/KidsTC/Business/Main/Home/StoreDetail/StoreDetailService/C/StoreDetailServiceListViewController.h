//
//  StoreDetailServiceListViewController.h
//  KidsTC
//
//  Created by Altair on 1/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class StoreOwnedServiceModel;

@interface StoreDetailServiceListViewController : ViewController

- (instancetype)initWithListItemModels:(NSArray<StoreOwnedServiceModel *> *)models;

@end
