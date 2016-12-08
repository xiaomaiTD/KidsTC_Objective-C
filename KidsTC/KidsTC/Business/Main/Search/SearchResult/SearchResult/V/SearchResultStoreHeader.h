//
//  SearchResultStoreHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultStore.h"
@interface SearchResultStoreHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) SearchResultStore *store;
@property (nonatomic, copy) void(^actionBlock)(SearchResultStore *store);
@end
