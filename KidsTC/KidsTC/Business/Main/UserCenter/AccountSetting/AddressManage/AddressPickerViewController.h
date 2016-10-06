//
//  AddressPickerViewController.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "AddressModel.h"
@interface AddressPickerViewController : ViewController
@property (nonatomic, strong) NSArray<AddressDataItem *> *recordData;
@property (nonatomic, copy) void (^resultBlock)(NSArray<AddressDataItem *> *result);
- (void)show;
@end
