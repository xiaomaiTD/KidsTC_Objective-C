//
//  RecommendProductView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProductView.h"

@interface RecommendProductView ()

@end

@implementation RecommendProductView

- (void)setProducts:(NSArray<RecommendProduct *> *)products {
    _products = products;
    self.hidden = _products.count<1;
}

- (void)reloadData {}

- (CGFloat)contentHeight {
    return 0;
}

- (void)nilData{}

@end
