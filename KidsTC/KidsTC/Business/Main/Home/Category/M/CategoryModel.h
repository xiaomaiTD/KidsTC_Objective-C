//
//  CategoryModel.h
//  KidsTC
//
//  Created by zhanping on 6/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParmsModel.h"
#import "Model.h"

@interface CategoryListItem : Model
@property (nonatomic, strong) NSString *SearchUrl;
@property (nonatomic, strong) NSString *SysNo;
@property (nonatomic, strong) NSString *PSysNo;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *CategoryImg;
@property (nonatomic, strong) NSArray<CategoryListItem *> *ScondCategory;
@property (nonatomic, strong) SearchParmsProductOrStoreModel *search_parms;
@end

@interface CategoryModel : Model
@property (nonatomic, strong) NSArray<CategoryListItem *> *data;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@end
