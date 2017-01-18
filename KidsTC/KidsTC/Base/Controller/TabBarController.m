//
//  TabBarController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/15.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "TabBarController.h"
#import "AppDelegate.h"
#import "NavigationController.h"

#import "TCHomeViewController.h"
#import "ArticleHomeViewController.h"
#import "StrategyViewController.h"
#import "NearbyViewController.h"
#import "AccountCenterViewController.h"
#import "WebViewController.h"

#import "ThemeManager.h"
#import "Macro.h"
#import "UIImage+Category.h"
#import "CustomTabBar.h"
#import "YYFPSLabel.h"

#import "ComposeManager.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"
#import "ReachabilityManager.h"
#import "NetWorkTipView.h"


@interface TabBarController ()<CustomTabBarDelegate>
@property (nonatomic, strong) CustomTabBar *customTabBar;
#ifdef DEBUG
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
#endif

@property (nonatomic, strong) NetWorkTipView *netWorkTipView;

@end

@implementation TabBarController
singleM(TabBarController)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Theme *theme = [ThemeManager shareThemeManager].theme;
    NSArray<TabBarItemElement *> *elements = theme.elements;
    [self setupViewControllersWithElements:elements];
    [self updataHomeNaviColor:theme.homeNavColor];
    [self setupTabBarWithColor:theme.tabColor elements:elements];
    [NotificationCenter addObserver:self selector:@selector(updataTheme) name:kUpdataThemeNoti object:nil];
    [NotificationCenter addObserver:self selector:@selector(reachabilityStatusChange:) name:kReachabilityStatusChangeNoti object:nil];
    
#ifdef DEBUG
#define YYFPSLabelInset 12
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = SCREEN_HEIGHT - (YYFPSLabelInset+49);
    _fpsLabel.left = YYFPSLabelInset;
    _fpsLabel.alpha = 1;
    //[self.view addSubview:_fpsLabel];
#endif
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return self.getPresentedViewController.shouldAutorotate;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.getPresentedViewController.supportedInterfaceOrientations;
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *topVC = self.selectedViewController;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma mark - public

/**
 *  根据脚标Index，选中TabBarController的某一个控制器
 *
 *  @param index 脚标
 */
- (void)selectIndex:(NSUInteger)index{
    [self popToRoot:self.selectedViewController];
    [self.customTabBar selectIndex:index];
    [self popToRoot:self.selectedViewController];
}

- (void)popToRoot:(NavigationController *)navi{
    if ([navi isKindOfClass:[NavigationController class]]&&
        navi.viewControllers.count > 1 &&
        [navi respondsToSelector:@selector(popToRootViewControllerAnimated:)]) {
        [navi popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - setupViewControllers
/**
 *  初始化控制器
 *
 *  @param elements 控制器元素
 */
- (void)setupViewControllersWithElements:(NSArray<TabBarItemElement *> *)elements{
    NSMutableArray *navis = [NSMutableArray array];
    for (TabBarItemElement *ele in elements) {
        UIViewController *controller = nil;
        switch (ele.type) {
            case TabBarItemElementTypeHome:
            {
                controller = [[TCHomeViewController alloc]init];
            }
                break;
            case TabBarItemElementTypeArticle:
            {
                controller = [[ArticleHomeViewController alloc]init];
            }
                break;
            case TabBarItemElementTypeStrategy:
            {
                controller = [[NearbyViewController alloc]init];
            }
                break;
            case TabBarItemElementTypeUserCenter:
            {
                controller = [[AccountCenterViewController alloc]init];
            }
                break;
            case TabBarItemElementTypeAddLink:
            {
                WebViewController *wvc = [[WebViewController alloc] init];
                wvc.urlString = ele.additionalUrl;
                controller = wvc;
            }
                break;
            case TabBarItemElementTypeAddCompose:
            {
                controller = [[ViewController alloc] init];
            }
                break;
        }
        if (controller) {
            NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
            [navis addObject:navi];
        }
    }
    self.viewControllers = navis;
}

#pragma mark - setupTabBar
/**
 *  初始化TabBar
 *
 *  @param color    TabBar的背景色
 *  @param elements TabBarItem的元素
 */
- (void)setupTabBarWithColor:(UIColor *)color elements:(NSArray<TabBarItemElement *> *)elements{
    if (self.customTabBar) {
        [self.customTabBar removeFromSuperview];
        self.customTabBar = nil;
    }
    CustomTabBar *customTabBar = [[CustomTabBar alloc]init];
    customTabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    customTabBar.delegate = self;
    customTabBar.elements = elements;
    if (color) customTabBar.backgroundColor = color;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
    [customTabBar makeBadgeIndex:1 type:TipButtonBadgeTypeIcon value:1];
    [customTabBar makeBadgeIndex:elements.count-1 type:TipButtonBadgeTypeIcon value:1];
}

#pragma mark - CustomTabBarDelegate
/**
 *  TabBarDelegate回调事件
 *
 *  @param customTabBar 当前TabBar
 *  @param index        当前TabBar选中的元素类型
 */
- (void)customTabBar:(CustomTabBar *)customTabBar didSelectElementType:(TabBarItemElementType)type{
    /*
     TabBarItemElementTypeHome=1,       //首页
     TabBarItemElementTypeArticle,      //资讯
     TabBarItemElementTypeStrategy,     //亲子攻略
     TabBarItemElementTypeUserCenter,   //我
     TabBarItemElementTypeAddLink,      //附加-活动
     TabBarItemElementTypeAddCompose    //附加-发布
     */
    
    NSInteger index = -1;
    
    switch (type) {
        case TabBarItemElementTypeHome://首页
        {
            index = 0;
        }
            break;
        case TabBarItemElementTypeArticle://资讯
        {
            index = 1;
        }
            break;
        case TabBarItemElementTypeStrategy://亲子攻略
        {
            index = self.viewControllers.count-2;
        }
            break;
        case TabBarItemElementTypeUserCenter://我
        {
            index = self.viewControllers.count-1;
        }
            break;
        case TabBarItemElementTypeAddLink://附加-活动
        {
            index = 2;
        }
            break;
        case TabBarItemElementTypeAddCompose://附加-发布
        {
            index = -1;
            [self showCompose];
            return;
        }
            break;
    }
    
    if (self.selectedIndex != index && index < self.viewControllers.count) {
        self.selectedIndex = index;
        UINavigationController *navi = self.viewControllers[index];
        UIViewController *vc = navi.topViewController;
        if ([vc isKindOfClass:[WebViewController class]]){
            WebViewController *wvc = (WebViewController *)vc;
            [wvc reload];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([wvc.urlString isNotNull]) {
                [params setValue:wvc.urlString forKey:@"url"];
            }
            [BuryPointManager trackEvent:@"event_skip_home_event" actionId:20109 params:params];
        }
    }
    [customTabBar clearBadgeIndex:index];
}

- (void)showCompose {
    [[ComposeManager shareComposeManager] showCompose:^{
        [self.customTabBar selectIndex:self.selectedIndex];
    }];
}



#pragma mark - 更新主题
/**
 *  收到更新主题通知
 */
- (void)updataTheme{
    TCLog(@"收到主题重置通知，更新主题--%@",[NSThread currentThread]);
    Theme *theme = [ThemeManager shareThemeManager].theme;
    [self updataHomeNaviColor:theme.homeNavColor];
    [self updataTabBarWithColor:theme.tabColor elements:theme.elements];
}
/**
 *  更新TabBar
 *
 *  @param color    TabBar背景色
 *  @param elements TabBarItem元素
 */
- (void)updataTabBarWithColor:(UIColor *)color elements:(NSArray<TabBarItemElement *> *)elements{
    CustomTabBar *customTabBar = self.customTabBar;
    if (color) customTabBar.backgroundColor = color;
    NSArray<CustomTabBarButton *> *btns = customTabBar.btns;
    for (CustomTabBarButton *btn in btns) {
        TabBarItemElementType type = btn.element.type;
        for (TabBarItemElement *ele in elements) {
            if (type == ele.type) btn.element = ele;
        }
    }
}
/**
 *  更新主页导航栏的背景色
 *
 *  @param color 主页导航栏的背景色
 */
- (void)updataHomeNaviColor:(UIColor *)color{
    if (!color) return;
    UINavigationController *homeNavi = self.viewControllers[0];
    ViewController *controller = homeNavi.viewControllers[0];
    controller.naviColor = color;
}


#pragma mark - reachabilityStatusChange

- (void)reachabilityStatusChange:(NSNotification *)noti {
    
    AFNetworkReachabilityStatus status = [noti.object integerValue];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        if (!_netWorkTipView) {
            _netWorkTipView = [[NSBundle mainBundle] loadNibNamed:@"NetWorkTipView" owner:self options:nil].firstObject;
            _netWorkTipView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 50);
            [self.view addSubview:_netWorkTipView];
            _netWorkTipView.tapActionBlock = ^(){
                NSURL *url = [NSURL URLWithString:@"prefs:root="];
                //NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            };
        }
        _netWorkTipView.hidden = NO;
    }else{
        _netWorkTipView.hidden = YES;
    }
}

@end
