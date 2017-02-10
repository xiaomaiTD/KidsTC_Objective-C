//
//  TCStoreDetailComment.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCStoreDetailComment : NSObject
@property (nonatomic, assign) NSUInteger all;
@property (nonatomic, assign) NSUInteger bad;
@property (nonatomic, assign) NSUInteger good;
@property (nonatomic, assign) NSUInteger normal;
@property (nonatomic, assign) NSUInteger pic;
@property (nonatomic, strong) NSArray<NSString *> *userHeadImgs;
@end
