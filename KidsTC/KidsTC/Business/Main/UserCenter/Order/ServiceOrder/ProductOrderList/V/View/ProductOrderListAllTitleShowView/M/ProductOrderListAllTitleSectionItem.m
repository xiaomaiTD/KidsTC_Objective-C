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
    
    NSMutableArray *section00 = [NSMutableArray array];
    ProductOrderListAllTitleRowItem *section00_00 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeAll];
    ProductOrderListAllTitleRowItem *section00_01 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeCompleted];
    ProductOrderListAllTitleRowItem *section00_02 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeCancled];
    if (section00_00) [section00 addObject:section00_00];
    if (section00_01) [section00 addObject:section00_01];
    if (section00_02) [section00 addObject:section00_02];
    ProductOrderListAllTitleSectionItem *sectionItem00 = [ProductOrderListAllTitleSectionItem sectionItemWithTitle:@"" rowItems:section00];
    if (sectionItem00) [sectionItems addObject:sectionItem00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    ProductOrderListAllTitleRowItem *section01_00 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeTicket];
    ProductOrderListAllTitleRowItem *section01_01 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeRealObject];
    ProductOrderListAllTitleRowItem *section01_02 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeActivity];
    ProductOrderListAllTitleRowItem *section01_03 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeFlash];
    ProductOrderListAllTitleRowItem *section01_04 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeAppoinment];
    if (section01_00) [section01 addObject:section01_00];
    if (section01_01) [section01 addObject:section01_01];
    if (section01_02) [section01 addObject:section01_02];
    if (section01_03) [section01 addObject:section01_03];
    if (section01_04) [section01 addObject:section01_04];
    ProductOrderListAllTitleSectionItem *sectionItem01 = [ProductOrderListAllTitleSectionItem sectionItemWithTitle:@"生活服务" rowItems:section01];
    if (sectionItem01) [sectionItems addObject:sectionItem01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    ProductOrderListAllTitleRowItem *section02_00 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeRadish];
    ProductOrderListAllTitleRowItem *section02_01 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeLottery];
    ProductOrderListAllTitleRowItem *section02_02 = [ProductOrderListAllTitleRowItem itemWithType:ProductOrderListAllTitleRowItemActionTypeActivityRegister];
    if (section02_00) [section02 addObject:section02_00];
    if (section02_01) [section02 addObject:section02_01];
    if (section02_02) [section02 addObject:section02_02];
    ProductOrderListAllTitleSectionItem *sectionItem02 = [ProductOrderListAllTitleSectionItem sectionItemWithTitle:@"休闲娱乐" rowItems:section02];
    if (sectionItem02) [sectionItems addObject:sectionItem02];
    
    return [NSArray arrayWithArray:sectionItems];
}
@end
