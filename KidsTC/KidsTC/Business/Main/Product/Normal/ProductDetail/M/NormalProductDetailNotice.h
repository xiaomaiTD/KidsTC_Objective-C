//
//  NormalProductDetailNotice.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailNotice : NSObject
@property (nonatomic, strong) NSString *clause;
@property (nonatomic, strong) NSString *notice;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attNotice;
@end
