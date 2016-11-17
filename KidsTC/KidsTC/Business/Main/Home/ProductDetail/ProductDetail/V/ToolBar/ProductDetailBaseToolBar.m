//
//  ProductDetailBaseToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailBaseToolBar.h"

CGFloat const kProductDetailBaseToolBarHeight = 54;

@implementation ProductDetailBaseToolBar

- (void)setData:(ProductDetailData *)data {
    _data = data;
    self.hidden = data==nil;
}

@end
