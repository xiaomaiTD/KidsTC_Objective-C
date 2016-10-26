//
//  ProductDetailComment.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailComment : NSObject
@property (nonatomic, assign) NSUInteger all;
@property (nonatomic, assign) NSUInteger bad;
@property (nonatomic, assign) NSUInteger good;
@property (nonatomic, assign) NSUInteger normal;
@property (nonatomic, assign) NSUInteger pic;
@property (nonatomic, strong) NSArray<NSString *> *userHeadImgs;
@end
