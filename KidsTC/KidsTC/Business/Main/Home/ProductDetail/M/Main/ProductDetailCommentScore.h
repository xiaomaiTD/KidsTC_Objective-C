//
//  ProductDetailCommentScore.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailScoreItem.h"

@interface ProductDetailCommentScore : NSObject
@property (nonatomic, assign) CGFloat OverallScore;
@property (nonatomic, strong) NSArray<ProductDetailScoreItem *> *ScoreDetail;
@end
