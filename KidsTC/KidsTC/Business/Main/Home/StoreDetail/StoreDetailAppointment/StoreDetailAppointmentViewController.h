//
//  StoreDetailAppointmentViewController.h
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "ActivityLogoItem.h"

@interface StoreDetailAppointmentViewController : ViewController
@property (nonatomic, strong) NSArray<ActivityLogoItem *> *activeModelsArray;
@property (nonatomic, strong) NSString *storeId;
@end
