//
//  PosterViewController.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "PosterModel.h"
@interface PosterViewController : ViewController
@property (nonatomic, copy) void (^resultBlock) ();
@property (nonatomic, weak) NSArray<PosterAdsItem *> *ads;
@end
