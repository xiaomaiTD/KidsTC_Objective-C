//
//  SearchResultFactorShowModelManager.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResultFactorShowModel.h"

/**
 - (NSArray<NSDictionary *> *)storeSortDicts{
 NSDictionary *dic0 = @{product_sotre_title:@"智能排序",product_sotre_value:@"1"};
 NSDictionary *dic1 = @{product_sotre_title:@"按星级排序",product_sotre_value:@"5"};
 NSDictionary *dic2 = @{product_sotre_title:@"离我最近",product_sotre_value:@"6"};
 return [NSArray<NSDictionary *> arrayWithObjects:dic0, dic1, dic2, nil];
 }
 */



typedef void(^SearchResultFactorDataCallBackBlock)(SearchResultFactorShowModel *productFactorShowModel,SearchResultFactorShowModel *storeFactorShowModel);

@interface SearchResultFactorShowModelManager : NSObject
+(instancetype)shareManager;
- (void)loadSearchResultFactorDataCallBack:(SearchResultFactorDataCallBackBlock)callBack;
@end
