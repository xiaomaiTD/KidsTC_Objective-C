//
//  ProductOrderListAllTitleSectionItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleSectionItem.h"

@implementation ProductOrderListAllTitleSectionItem
+(instancetype)sectionItemWithTitle:(NSString *)title rowItems:(NSArray<ProductOrderListAllTitleRowItem *> *)rowItems {
    ProductOrderListAllTitleSectionItem *sectionItem = [ProductOrderListAllTitleSectionItem new];
    sectionItem.title = title;
    sectionItem.rowItems = rowItems;
    return sectionItem;
}
+(NSArray<ProductOrderListAllTitleSectionItem *> *)sectionItems {
    NSMutableArray *sectionItems = [NSMutableArray array];
    
    return nil;
}
@end
