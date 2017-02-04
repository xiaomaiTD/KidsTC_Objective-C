//
//  WholesaleProductDetailCount.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WholesaleProductDetailCount : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger index;
+ (instancetype)itemWithTitle:(NSString *)title index:(NSInteger)index;
@end
