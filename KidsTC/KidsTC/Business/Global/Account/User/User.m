//
//  User.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "User.h"
#import "NSString+Category.h"
#import "CookieManager.h"
#import <SAMKeychain/SAMKeychain.h>
#import "NavigationController.h"
#import "GHeader.h"
#import "Constant.h"
#import "Macro.h"
#import "NotificationService.h"
#import "GetUserPopulationModel.h"
#import "TabBarController.h"
#import "BuryPointManager.h"

//用户uid skey
static NSString *const USERDEFAULT_UID_KEY = @"UserDefaultUidKey";
static NSString *const KEYCHAIN_SERVICE_UIDSKEY = @"com.KidsTC.iPhoneAPP.uid";
//角色typ sex
static NSString *const RoleTypeDefaultKey = @"RoleTypeDefaultKey";
static NSString *const RoleSexDefaultKey = @"RoleSexDefaultKey";
static NSString *const RoleHasShowSelectKey = @"RoleHasShowSelectKey";

NSString *const kRoleSelectViewControllerFinishShow = @"kRoleSelectViewControllerFinishShow";

@interface User ()
@property (nonatomic, assign) BOOL roleHasShowSelect;
@end

@implementation User
singleM(User)
@synthesize uid = _uid, skey = _skey, role = _role;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self getUserLocalSave];
        
        [self getRloeLocalSave];
    }
    return self;
}

- (NSString *)uid {
    if (!_uid) {
        [self getUserLocalSave];
    }
    if (!_uid) {
        _uid = @"";
    }
    return _uid;
}

- (NSString *)skey {
    if (!_skey) {
        [self getUserLocalSave];
    }
    if (!_skey) {
        _skey = @"";
    }
    return _skey;
}

#pragma mark - ===================LOGIN===================

- (void)updateUid:(NSString *)uid skey:(NSString *)skey{
    if ([uid isNotNull] && [skey isNotNull]) {
        _uid = uid;
        _skey = skey;
        _hasLogin = YES;
        [[CookieManager shareCookieManager] setCookieWithName:CookieKey_uid andValue:_uid];
        [[CookieManager shareCookieManager] setCookieWithName:CookieKey_skey andValue:_skey];
        [[NotificationService shareNotificationService] bindAccount:YES];
        [self userLocalSave];
    }
}

- (void)checkLoginWithTarget:(UIViewController *)target resultBlock:(LoginResultBlock)resultBlock{
    if (_hasLogin) {
        if(resultBlock) resultBlock(_uid,nil);
    }else{
        if (!target) {
            target = [TabBarController shareTabBarController].selectedViewController;
        }
        LoginViewController *controller = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        controller.resultBlock = ^(NSString *uid, NSError*error) {
            if (resultBlock) resultBlock(uid,error);
            [self getUserPopulation];
        };
        NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
        [target presentViewController:navi animated:YES completion:nil];
    }
}

- (void)checkLoginStatusFromServer {
    if ([_uid isNotNull] && [_skey isNotNull]) {
        TCLog(@"checkLoginStatusFromServer - 本地存储了uid和skey，可以开始检查是否登录");
        NSDictionary *param = @{@"uid":_uid,@"skey":_skey};
        [Request startWithName:@"LOGIN_IS_LOGIN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCLog(@"checkLoginStatusFromServer - 服务器端已经登录");
            _hasLogin = YES;
            [[CookieManager shareCookieManager] setCookieWithName:CookieKey_uid andValue:_uid];
            [[CookieManager shareCookieManager] setCookieWithName:CookieKey_skey andValue:_skey];
            [self getUserPopulation];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (error.code == -1000) {
                TCLog(@"checkLoginStatusFromServer - 服务器端没有登录");
            }else{
                TCLog(@"checkLoginStatusFromServer - 请求失败，不做处理");
            }
        }];
    }else{
        TCLog(@"checkLoginStatusFromServer - 本地没有存储uid和skey，不用检查是否登录");
    }
}

- (void)logoutManually:(BOOL)manually withSuccess:(void (^)())success failure:(void (^)(NSError *error))failure{
    if (manually) {//手动
        if ([_uid isNotNull] && [_skey isNotNull] && _hasLogin) {
            NSDictionary *param = @{@"uid":_uid,
                                    @"skey":_skey};
            [Request startWithName:@"LOGIN_LOGINOUT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                [self logoutLocal];
                if (success) success();
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) failure(error);
            }];
        }else{
            if (success) success();
        }
        [self buryPointType:1];
    }else{//自动
        [self buryPointType:2];
        [self logoutLocal];
        if (success) success();
    }
}

- (void)buryPointType:(NSInteger)type  {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *uid = [User shareUser].uid;
    if ([uid isNotNull]) {
        [param setObject:uid forKey:@"uid"];
    }
    [param setObject:@(type) forKey:@"type"];
    [BuryPointManager trackEvent:@"event_result_logoff" actionId:21518 params:param];
}

- (void)logoutLocal{
    [[NotificationService shareNotificationService] bindAccount:NO];
    [self deleteLocalSave];
    [self cleanMemory];
    [NotificationCenter postNotificationName:kUserLogoutNotification object:nil];
}

#pragma mark private

- (void)userLocalSave{
    [USERDEFAULTS setObject:_uid forKey:USERDEFAULT_UID_KEY];
    [USERDEFAULTS synchronize];
    [SAMKeychain setPassword:_skey forService:KEYCHAIN_SERVICE_UIDSKEY account:_uid error:nil];
}

- (void)getUserLocalSave{
    _uid = [USERDEFAULTS objectForKey:USERDEFAULT_UID_KEY];
    if ([_uid isNotNull]) {
        _skey = [SAMKeychain passwordForService:KEYCHAIN_SERVICE_UIDSKEY account:_uid];
    }
    _hasLogin = ([_uid isNotNull] && [_skey isNotNull]);
}

- (void)deleteLocalSave{
    if (![_uid isNotNull]) {
        _uid = [USERDEFAULTS objectForKey:USERDEFAULT_UID_KEY];
    }
    if ([_uid isNotNull]) {
        [SAMKeychain deletePasswordForService:KEYCHAIN_SERVICE_UIDSKEY account:_uid];
    }
    [USERDEFAULTS removeObjectForKey:USERDEFAULT_UID_KEY];
    [USERDEFAULTS synchronize];
}

- (void)cleanMemory{
    _uid = nil;
    _skey = nil;
    _hasLogin = NO;
    [[CookieManager shareCookieManager] deleteCookieWithName:CookieKey_uid];
    [[CookieManager shareCookieManager] deleteCookieWithName:CookieKey_skey];
}

#pragma mark - ===================ROLE===================

//获取用户年龄段
- (void)getUserPopulation {
    if (!_hasLogin) {
        TCLog(@"当前没有用户登录，不用同步年龄段！");
        return;
    }
    [Request startWithName:@"GET_USER_POPULATION" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        GetUserPopulationData *data = [GetUserPopulationModel modelWithDictionary:dic].data;
        Role *role = [Role roleWityID:data.WirelessPopulationType];
        if (data && role && _role.roleIdentifier != data.WirelessPopulationType) {
            self.role = role;
            [NotificationCenter postNotificationName:kRoleHasChangedNotification object:nil];
        }else{
            //当用户没有年龄段的时候，同步本地年龄段到服务器
            [self updateUserPopulation];
        }
    } failure:nil];
}

//上报用户年龄段
- (void)updateUserPopulation {
    if (!_hasLogin) {
        TCLog(@"当前没有用户登录，不用上报年龄段！");
        return;
    }
    NSDictionary *param = @{@"populationType":_role.roleIdentifierString};
    [Request startWithName:@"UPDATE_USER_POPULATION" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        
    } failure:nil];
}

- (void)setRole:(Role *)role{
    _role = role;
    [self roleLocalSave];
    [[CookieManager shareCookieManager] setCookies];
    [NotificationCenter postNotificationName:kRoleHasChangedNotification object:nil];
}

- (void)checkRoleWithWindow:(UIWindow *)window resultBlock:(void(^)())resuleBlock{
    if (self.roleHasShowSelect) {
        [self finishShow:resuleBlock];
    }else{
        RoleSelectViewController *controller = [[RoleSelectViewController alloc]initWithNibName:@"RoleSelectViewController" bundle:nil];
        window.hidden = NO;
        window.rootViewController = controller;
        [window makeKeyAndVisible];
        WeakSelf(controller)
        controller.resultBlock = ^void(){
            StrongSelf(controller)
            [UIView animateWithDuration:0.5 animations:^{
                controller.view.alpha = 0;
            } completion:^(BOOL finished) {
                [self finishShow:resuleBlock];
            }];
        };
    }
}

#pragma mark private

- (void)roleLocalSave{
    [USERDEFAULTS setInteger:_role.type forKey:RoleTypeDefaultKey];
    [USERDEFAULTS setInteger:_role.sex forKey:RoleSexDefaultKey];
    [USERDEFAULTS synchronize];
}

- (void)getRloeLocalSave{
    
    RoleType roleType = (RoleType)[USERDEFAULTS integerForKey:RoleTypeDefaultKey];
    RoleSex roleSex = (RoleSex)[USERDEFAULTS integerForKey:RoleSexDefaultKey];
    switch (roleType) {
        case RoleTypeZeroToOne:
        case RoleTypeTwoToThree:
        case RoleTypeFourToSix:
        case RoleTypeSevenToTwelveMale:
        {
            _role = [Role instanceWithType:roleType sex:roleSex];
        }
            break;
        default:
        {
            _role = [Role instanceWithType:RoleTypeZeroToOne sex:RoleSexUnknown];
        }
            break;
    }
    self.roleHasShowSelect = [USERDEFAULTS boolForKey:RoleHasShowSelectKey];
}

- (void)finishShow:(void(^)())resuleBlock{
    if (resuleBlock) resuleBlock();
    self.roleHasShowSelect = YES;
    [USERDEFAULTS setBool:YES forKey:RoleHasShowSelectKey];
    [USERDEFAULTS synchronize];
    [NotificationCenter postNotificationName:kRoleSelectViewControllerFinishShow object:nil];
}

@end
