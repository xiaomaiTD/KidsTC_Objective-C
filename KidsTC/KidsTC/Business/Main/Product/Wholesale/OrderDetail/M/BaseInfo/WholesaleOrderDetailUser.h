//
//  WholesaleOrderDetailUser.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WholesaleOrderDetailUser : NSObject
@property (nonatomic, strong) NSString *openGroupSysNo;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *unionId;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, strong) NSString *surplusCount;
@property (nonatomic, assign) BOOL canApply;
@property (nonatomic, assign) BOOL isApply;
@end
