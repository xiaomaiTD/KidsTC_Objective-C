//
//  HomeElementBaseModel.h
//  ICSON
//
//  Created by 钱烨 on 4/11/15.
//  Copyright (c) 2015 肖晓春. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface HomeElementBaseModel : NSObject

@property (nonatomic, strong) NSURL *imageUrl; //展示图片的链接URL

@property (nonatomic, strong) SegueModel *segueModel;

- (instancetype)initWithHomeData:(NSDictionary *)data;

- (void)parseHomeData:(NSDictionary *)data;

@end
