//
//  NormalProductDetailComment.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailComment : NSObject
@property (nonatomic, assign) NSUInteger all;
@property (nonatomic, assign) NSUInteger bad;
@property (nonatomic, assign) NSUInteger good;
@property (nonatomic, assign) NSUInteger normal;
@property (nonatomic, assign) NSUInteger pic;
@property (nonatomic, strong) NSArray<NSString *> *userHeadImgs;
@end
