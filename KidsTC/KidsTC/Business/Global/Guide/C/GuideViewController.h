//
//  GuideViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"
#import "GuideModel.h"

@interface GuideViewController : ViewController
@property (nonatomic, strong) NSArray<GuideDataItem *> *datas;
@property (nonatomic, copy) void (^resultBlock) ();
@end
