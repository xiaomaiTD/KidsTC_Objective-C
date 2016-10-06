//
//  StoreDetialMapViewController.h
//  KidsTC
//
//  Created by zhanping on 8/2/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "StoreListItemModel.h"
@interface StoreDetialMapViewController : ViewController
@property (nonatomic, strong) NSArray<StoreListItemModel *> *models;
@property (nonatomic, strong) StoreListItemModel *selectedModel;
@end
