//
//  WholesaleProductDetailTeam.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WholesaleProductDetailTeam : NSObject
@property (nonatomic, strong) NSString *openGroupSysNo;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, assign) NSInteger surplusCount;
@property (nonatomic, assign) BOOL canApply;
@property (nonatomic, assign) BOOL isApply;
@end
