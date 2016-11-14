//
//  ProductDetailSubViewsProvider.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

#import "ProductDetailData.h"

#import "ProductDetailViewBaseHeader.h"
#import "ProductDetailBaseCell.h"
#import "ProductDetailTwoColumnToolBar.h"
#import "ProductDetailCountDownView.h"
#import "ProductDetailBaseToolBar.h"

#import "ProductDetailTwoColumnCell.h"
#import "ProductDetailTwoColumnBottomBarCell.h"

@interface ProductDetailSubViewsProvider : NSObject
singleH(ProductDetailSubViewsProvider)
@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) ProductDetailData *data;

@property (nonatomic, strong) ProductDetailTwoColumnCell *twoColumnCellUsed;
@property (nonatomic, strong) ProductDetailTwoColumnBottomBarCell *twoColumnBottomBarCellUsed;
@property (nonatomic, assign) NSUInteger twoColumnSectionUsed;

- (ProductDetailViewBaseHeader *)header;

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)sections;

- (ProductDetailTwoColumnToolBar *)twoColumnToolBar;

- (ProductDetailCountDownView *)countDownView;

- (ProductDetailBaseToolBar *)toolBar;

@end
