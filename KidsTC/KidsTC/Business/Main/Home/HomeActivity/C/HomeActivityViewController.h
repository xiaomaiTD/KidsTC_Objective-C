//
//  HomeActivityViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/8/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"

@interface HomeActivityViewController : ViewController
@property (nonatomic, strong) NSString *pageUrl;
@property (nonatomic, copy) void (^resultBlock)();
@end
