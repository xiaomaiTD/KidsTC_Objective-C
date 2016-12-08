//
//  SearchResultStoreProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface SearchResultStoreProduct : NSObject
@property (nonatomic, strong) NSString *ProductSysNo;
@property (nonatomic, strong) NSString *ProductName;
@property (nonatomic, assign) ProductDetailType ProductType;
@property (nonatomic, strong) NSString *ChannelId;
@property (nonatomic, strong) NSString *ProductSearchType;
@property (nonatomic, strong) NSString *ImgUrl;
@property (nonatomic, strong) NSString *Price;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
