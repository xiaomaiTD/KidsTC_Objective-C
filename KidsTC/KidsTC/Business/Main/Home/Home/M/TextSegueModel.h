//
//  TextSegueModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface TextSegueModel : NSObject
@property (nonatomic, copy, readonly) NSString *linkWords;
@property (nonatomic, strong, readonly) SegueModel *segueModel;
@property (nonatomic, copy, readonly) NSString *promotionWords;
@property (nonatomic, readonly) NSRange linkRange;
@property (nonatomic, readonly) NSArray<NSString *> *linkRangeStrings;
@property (nonatomic, strong) UIColor *linkColor;

- (instancetype)initWithLinkParam:(NSDictionary *)param promotionWords:(NSString *)words;
@end
