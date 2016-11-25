//
//  CollectProductCategoryItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductItem.h"

@interface CollectProductCategoryItem : NSObject
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSString *cagegroyNo;
@property (nonatomic, strong) NSArray<CollectProductItem *> *productLst;

//selfDefine
@property (nonatomic, strong) CollectProductItem *firstItem;
@property (nonatomic, strong) NSArray<CollectProductItem *> *items;
@end
