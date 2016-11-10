//
//  ProductDetailViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailData.h"

@interface ProductDetailViewController : ViewController
- (instancetype)initWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId;
@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, strong) NSString *consultStr;
@end
