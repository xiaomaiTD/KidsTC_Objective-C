//
//  ServiceDetailRelatedServiceListViewController.h
//  KidsTC
//
//  Created by Altair on 1/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class ServiceMoreDetailHotSalesItemModel;

@interface ServiceDetailRelatedServiceListViewController : ViewController

- (instancetype)initWithListItemModels:(NSArray<ServiceMoreDetailHotSalesItemModel *> *)models;

@end
