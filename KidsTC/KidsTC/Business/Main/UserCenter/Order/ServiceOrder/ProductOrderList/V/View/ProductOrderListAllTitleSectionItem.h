//
//  ProductOrderListAllTitleSectionItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderListAllTitleRowItem.h"

@interface ProductOrderListAllTitleSectionItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ProductOrderListAllTitleRowItem *> *rowItems;
+(instancetype)sectionItemWithTitle:(NSString *)title rowItems:(NSArray<ProductOrderListAllTitleRowItem *> *)rowItems;
+(NSArray<ProductOrderListAllTitleSectionItem *> *)sectionItems;
@end
