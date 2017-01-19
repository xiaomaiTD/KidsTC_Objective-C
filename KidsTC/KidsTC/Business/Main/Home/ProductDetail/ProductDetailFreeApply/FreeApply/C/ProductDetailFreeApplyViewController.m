//
//  ProductDetailFreeApplyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"
#import "SettlementResultNewViewController.h"
#import "ProductDetailFreeApplyView.h"
#import "ProductDetailFreeApplyShowModel.h"
#import "TabBarController.h"
#import "NavigationController.h"

#import "UserAddressEditViewController.h"
#import "UserAddressManageViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "SettlementPickStoreViewController.h"
#import "ProductDetailFreeApplySelectStoreViewController.h"
#import "ProductDetailFreeApplySelectBirthViewController.h"
#import "ProductDetailFreeApplySelectAgeViewController.h"
#import "ProductDetailFreeApplySelectSexViewController.h"
#import "ProductDetailFreeApplySelectPlaceViewController.h"


@interface ProductDetailFreeApplyViewController ()<ProductDetailFreeApplyViewDelegate>
@property (nonatomic, strong) ProductDetailFreeApplyView *applyView;
@property (nonatomic, strong) ProductDetailFreeApplyShowModel *showModel;
@end

@implementation ProductDetailFreeApplyViewController

- (ProductDetailFreeApplyShowModel *)showModel {
    if (!_showModel) {
        ProductDetailData *data = self.data;
        _showModel = [ProductDetailFreeApplyShowModel new];
        _showModel.userPhone = [User shareUser].phone;
        _showModel.userAddress = nil;
        _showModel.activityDate = data.time;
        NSArray<ProductDetailStore *> *stores = data.store;
        if (stores.count>0) {
            _showModel.activityStore = stores.firstObject;
        }
        if (data.place.count>data.currentPlaceIndex) {
            _showModel.place = data.place[data.currentPlaceIndex];
        }
        _showModel.placeType = data.placeType;
        _showModel.babyName = @"";
        _showModel.babyBirth = nil;
        _showModel.babyAge = 0;
        _showModel.babySex = nil;
        _showModel.parentName = @"";
        _showModel.hidePen = ![_showModel.userPhone isNotNull];
    }
    return _showModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填写报名信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.pageId = 10508;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = self.data.serveId;
    if ([pid isNotNull]) {
        [params setValue:pid forKey:@"pid"];
    }
    NSString *cid = self.data.chId;
    if ([cid isNotNull]) {
        [params setValue:cid forKey:@"cid"];
    }
    self.trackParams = [NSDictionary dictionaryWithDictionary:params];
    
    ProductDetailFreeApplyView *applyView = [[ProductDetailFreeApplyView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    applyView.delegate = self;
    applyView.data = self.data;
    applyView.showModel = self.showModel;
    [self.view addSubview:applyView];
    self.applyView = applyView;
    
}

#pragma mark - ProductDetailFreeApplyViewDelegate

- (void)productDetailFreeApplyView:(ProductDetailFreeApplyView *)view
                        actionType:(ProductDetailFreeApplyViewActionType)type
                             value:(id)value
{
    switch (type) {
        case ProductDetailFreeApplyViewActionTypeUserAddressTip:
        {
            [self userAddress:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeUserAddress:
        {
            [self userAddress:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeActivityDate:
        {
            [self activityDate:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeActivityStore:
        {
            [self activityStore:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeActivityPlace:
        {
            [self activityPlace:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeSelectBirth:
        {
            [self selectBirth:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeSelectAge:
        {
            [self selectAge:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeSelectSex:
        {
            [self selectSex:value];
        }
            break;
        case ProductDetailFreeApplyViewActionTypeSure:
        {
            [self sure:value];
        }
            break;
        default:
            break;
    }
}

- (void)userAddressTip:(id)value {
    UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
    controller.editType = UserAddressEditTypeAdd;
    controller.resultBlock = ^void(UserAddressManageDataItem *item){
        self.showModel.userAddress = item;
        [self.applyView reloadSections];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)userAddress:(id)value {
    UserAddressManageViewController *controller = [[UserAddressManageViewController alloc]init];
    controller.fromeType = UserAddressManageFromTypeSettlement;
    controller.pickeAddressBlock = ^void (UserAddressManageDataItem *item){
        self.showModel.userAddress = item;
        [self.applyView reloadSections];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)activityDate:(id)value {
    ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
    controller.times = self.data.time.times;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)activityStore:(id)value {
    SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc] init];
    controller.channelId = self.data.chId;
    controller.serveId = self.data.serveId;
    NSArray<ProductDetailStore *> *stores = self.data.store;
    if (stores.count>0) {
        controller.storeId = stores.firstObject.storeId;
    }
    controller.pickStoreBlock = ^(SettlementPickStoreDataItem *store){
        ProductDetailStore *activityStore = [ProductDetailStore new];
        activityStore.storeId = store.storeId;
        activityStore.storeName = store.storeName;
        self.showModel.activityStore = activityStore;
        [self.applyView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)activityPlace:(id)value {
    ProductDetailFreeApplySelectPlaceViewController *controller = [[ProductDetailFreeApplySelectPlaceViewController alloc] initWithNibName:@"ProductDetailFreeApplySelectPlaceViewController" bundle:nil];
    controller.currentIndex = self.data.currentPlaceIndex;
    controller.places = self.data.place;
    controller.actionBlock = ^(NSInteger selectIndex){
        if (selectIndex<self.data.place.count) {
            self.data.currentPlaceIndex = selectIndex;
            self.showModel.place = self.data.place[selectIndex];
            [self.applyView reloadData];
        }
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)selectBirth:(id)value {
    ProductDetailFreeApplySelectBirthViewController *controller = [[ProductDetailFreeApplySelectBirthViewController alloc] initWithNibName:@"ProductDetailFreeApplySelectBirthViewController" bundle:nil];
    controller.makeSureBlock = ^(NSDate *date) {
        self.showModel.babyBirth = date;
        [self.applyView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)selectAge:(id)value {
    ProductDetailFreeApplySelectAgeViewController *controller = [[ProductDetailFreeApplySelectAgeViewController alloc] initWithNibName:@"ProductDetailFreeApplySelectAgeViewController" bundle:nil];
    controller.age = self.showModel.babyAge;
    controller.makeSureBlock = ^(NSInteger age){
        self.showModel.babyAge = age;
        [self.applyView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)selectSex:(id)value {
    ProductDetailFreeApplySelectSexViewController *controller = [[ProductDetailFreeApplySelectSexViewController alloc] initWithNibName:@"ProductDetailFreeApplySelectSexViewController" bundle:nil];
    controller.makeSureBlock = ^(NSDictionary *sexDic){
        self.showModel.babySex = sexDic;
        [self.applyView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)sure:(id)value {
    
    NSDictionary *param = self.param;
    if (!param) return;
    
    [Request startWithName:@"FREE_PRODUCT_ENROLL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"恭喜您，报名成功"] show];
        
        SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc] initWithNibName:@"SettlementResultNewViewController" bundle:nil];
        controller.productType = ProductDetailTypeFree;
        controller.paid = YES;
        controller.data = self.data;
        controller.orderId = [NSString stringWithFormat:@"%@",dic[@"data"]];
        NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
        UIViewController *target = [TabBarController shareTabBarController].selectedViewController;
        [target presentViewController:navi animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[iToast makeText:@"报名失败，请稍后再试！"] show];
    }];
    
}

- (NSDictionary *)param {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *pid = self.data.serveId;
    if ([pid isNotNull]) {
        [param setObject:pid forKey:@"pid"];
    }else{
        return nil;
    }
    NSString *chid = self.data.chId;
    if (![chid isNotNull]) {
        chid = @"0";
    }
    [param setObject:chid forKey:@"chid"];
    
    NSString *storeId = self.showModel.activityStore.storeId;
    if ([storeId isNotNull]) {
        [param setObject:storeId forKey:@"storeNo"];
    }else{
        [[iToast makeText:@"门店编号为空！"] show];
        return nil;
    }
    
    if (_data.placeType == PlaceTypePlace) {
        NSString *theaterNo = self.showModel.place.sysNo;
        if ([theaterNo isNotNull]) {
            [param setObject:theaterNo forKey:@"theaterNo"];
        }else{
            [[iToast makeText:@"地址编号为空！"] show];
            return nil;
        }
    }
    
    ProductDetailEnrollInfo *enrollInfo = self.data.enrollInfo;
    
    NSMutableDictionary *enrollJsonDic = [NSMutableDictionary dictionary];
    if (enrollInfo.isBabyName) {
        if ([self.showModel.babyName isNotNull]) {
            [enrollJsonDic setObject:self.showModel.babyName forKey:@"BabyName"];
        }else{
            [[iToast makeText:@"请填写您宝宝的姓名"] show];
            return nil;
        }
    }
    
    if (enrollInfo.isBabyBirthday) {
        if (self.showModel.babyBirth) {
            NSString *babyBirth = [NSString zp_stringWithDate:self.showModel.babyBirth Format:DF_yMd];
            [enrollJsonDic setObject:babyBirth forKey:@"BabyBirthday"];
        }else{
            [[iToast makeText:@"请填写您宝宝的生日"] show];
            return nil;
        }
    }
    
    if (enrollInfo.isBabySex) {
        NSDictionary *babySex = self.showModel.babySex;
        NSInteger sex = 0;
        if (babySex) {
            NSArray *allValues = babySex.allValues;
            if (allValues.count>0) {
                sex = [allValues.firstObject integerValue];
            }
        }
        if (sex) {
            [enrollJsonDic setObject:@(sex) forKey:@"BabySex"];
        }else{
            [[iToast makeText:@"请填写您宝宝的性别"] show];
            return nil;
        }
    }
    
    if (enrollInfo.isHouseholdName) {
        if ([self.showModel.parentName isNotNull]) {
            [enrollJsonDic setObject:self.showModel.parentName forKey:@"HouseholdName"];
        }else{
            [[iToast makeText:@"请填写宝宝父母的姓名"] show];
            return nil;
        }
    }
    
    if (enrollInfo.isBabyAge) {
        [enrollJsonDic setObject:@(self.showModel.babyAge) forKey:@"BabyAge"];
    }
    
    if (enrollInfo.isUserPhone) {
        if ([self.showModel.userPhone isNotNull]) {
            [enrollJsonDic setObject:self.showModel.userPhone forKey:@"UserPhone"];
        }else{
            [[iToast makeText:@"请填写手机号"] show];
            return nil;
        }
    }
    
    if (enrollInfo.isUserAddress) {
        UserAddressManageDataItem *userAddress = self.showModel.userAddress;
        if ([userAddress.ID isNotNull]) {
            [enrollJsonDic setObject:userAddress.ID forKey:@"UserAddressNo"];
        }else{
            [[iToast makeText:@"请填写收货地址"] show];
            return nil;
        }
    }
    
    NSString *enrollJson = [NSString zp_stringWithJsonObj:enrollJsonDic];
    if ([enrollJson isNotNull]) {
        [param setObject:enrollJson forKey:@"enrollJson"];
    }
    
    NSString *userRemark = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KProductDetailFreeApplyUserRemark]];
    if ([userRemark isNotNull]) {
        [param setObject:userRemark forKey:@"userRemark"];
    }
    
    return [NSDictionary dictionaryWithDictionary:param];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    //self.applyView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.keyboardHeight);
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    //self.applyView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
}

- (void)dealloc {
    [USERDEFAULTS setObject:@"" forKey:KProductDetailFreeApplyUserRemark];
    [USERDEFAULTS synchronize];
}

@end
