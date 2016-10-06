//
//  CategoryManager.h
//  KidsTC
//
//  Created by zhanping on 6/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "GHeader.h"
@interface CategoryDataManager : NSObject
singleH(CategoryDataManager)
@property (nonatomic, strong) CategoryModel *model;
- (void)synchronize;
@end
