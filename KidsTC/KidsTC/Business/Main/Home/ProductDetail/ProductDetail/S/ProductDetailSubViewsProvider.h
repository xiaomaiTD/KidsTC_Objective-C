//
//  ProductDetailSubViewsProvider.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductDetailData.h"

#import "ProductDetailViewBaseHeader.h"
#import "ProductDetailBaseCell.h"
#import "ProductDetailTwoColumnToolBar.h"
#import "ProductDetailCountDownView.h"
#import "ProductDetailBaseToolBar.h"

#import "ProductDetailTwoColumnWebViewCell.h"

@interface ProductDetailSubViewsProvider : NSObject

@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak  ) ProductDetailBaseCell *twoColumnCell;
@property (nonatomic, assign) NSUInteger twoColumnSectionUsed;

- (ProductDetailViewBaseHeader *)header;

- (NSArray<NSArray<ProductDetailBaseCell *> *> *)sections;

- (ProductDetailBaseToolBar *)toolBar;
- (ProductDetailCountDownView *)countDownView;
- (ProductDetailTwoColumnToolBar *)twoColumnToolBar;

- (void)nilViews;

@end
