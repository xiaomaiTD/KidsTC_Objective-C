//
//  User.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "LoginViewController.h"
#import "RoleSelectViewController.h"
#import "Role.h"

extern NSString *const kRoleSelectViewControllerFinishShow;

@interface User : NSObject
singleH(User)
@property (nonatomic, strong) Role *role;
@property (nonatomic, strong, readonly) NSString *uid;
@property (nonatomic, strong, readonly) NSString *skey;
@property (nonatomic, assign, readonly) BOOL hasLogin;
@property (nonatomic, strong) NSString *phone;
/**
 *  app每次从杀死状态下到前台 都需要从服务器检查登录状态
 */
- (void)checkLoginStatusFromServer;

/**
 *  更新用户在本地的登录状态
 *
 *  @param uid
 *  @param skey
 */
- (void)updateUid:(NSString *)uid skey:(NSString *)skey;

/**
 *  检查用户是否登录 拥有事件回调处理能力
 *
 *  @param target 当前控制器
 *  @param resultBlock 用户已经登录 或者 跳到登录界面登录成功后 的回调
 */
- (void)checkLoginWithTarget:(UIViewController *)target resultBlock:(LoginResultBlock)resultBlock;

/**
 *  退出登录
 *
 *  @param manually 是否手动退出登录 YES 代表需要发送请求退出登录 NO 代表只需清除本地的用户登录信息
 *  @param success  成功退出登录后的回调
 *  @param failure  失败退出登录后的回调
 */
- (void)logoutManually:(BOOL)manually withSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

//获取用户年龄段
- (void)getUserPopulation;

//上报用户年龄段
- (void)updateUserPopulation;

/**
 *  检查是否需要选择用户角色
 *
 *  @param target      当前控制器
 *  @param resuleBlock 用户已经已经拥有角色、或者选择完角色后的回调
 */
- (void)checkRoleWithWindow:(UIWindow *)window resultBlock:(void(^)())resuleBlock;

@end
