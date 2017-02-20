//
//  WebViewController.m
//  KidsTC
//
//  Created by zhanping on 8/29/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WebViewController.h"

#import "GHeader.h"
#import "NSString+Category.h"
#import "NSDictionary+Category.h"
#import "UIBarButtonItem+Category.h"
#import "ZPPopover.h"
#import "KTCImageUploader.h"
#import "KTCCommentManager.h"
#import "FailureViewManager.h"
#import "RefreshHeader.h"
#import "BuryPointManager.h"

#import "TabBarController.h"
#import "ColumnViewController.h"
#import "ZPPhotoBrowserViewController.h"
#import "ArticleCommentViewController.h"
#import "MWPhotoBrowser.h"
#import "ProductDetailViewController.h"
#import "TCStoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "CouponListViewController.h"
#import "FlashBuyProductDetailViewController.h"
#import "CommonShareViewController.h"
#import "TZImagePickerController.h"
#import "ArticleColumnViewController.h"
#import "ProductOrderNormalDetailViewController.h"
#import "ProductOrderTicketDetailViewController.h"
#import "ProductOrderFreeDetailViewController.h"
#import "FlashServiceOrderDetailViewController.h"
#import "ProductOrderListViewController.h"
#import "CommentTableViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "ProductOrderFreeListViewController.h"
#import "WholesaleOrderDetailViewController.h"
#import "WolesaleProductDetailViewController.h"
#import "CommentUtilsViewController.h"

#import "RadishMallViewController.h"
#import "RadishProductOrderListViewController.h"
#import "RadishOrderDetailViewController.h"
#import "RadishProductDetailViewController.h"
#import "SeckillViewController.h"
#import "ActivityProductViewController.h"

static NSString *const Prefix         = @"hook::";            //前缀
typedef enum : NSUInteger {
    WebViewOptNavBarTypeShow=1,//显示
    WebViewOptNavBarTypeHide,//隐藏
    WebViewOptNavBarTypeTransparent,//透明
} WebViewOptNavBarType;

typedef enum : NSUInteger {
    WebViewOptTabBarTypeShow,//显示
    WebViewOptTabBarTypeHide//隐藏
} WebViewOptTabBarType;

@interface WebViewController ()<UIWebViewDelegate,ZPPopoverDelegate,TZImagePickerControllerDelegate,MWPhotoBrowserDelegate,CommentUtilsViewControllerDelegate>
@property (nonatomic, weak  ) UIButton                *backWebBtn;
@property (nonatomic, weak  ) UIButton                *closeBtn;
@property (nonatomic, strong) CommonShareObject       *shareObject;
@property (nonatomic, assign) WebViewShareCallBackType webViewShareCallBackType;
@property (nonatomic, strong) NSString *shareCallBack;
@property (nonatomic, assign) CommonShareType shareType;
@property (nonatomic, strong) NSString                *callBackJS;
@property (nonatomic, strong) KTCCommentManager       *commentManager;
@property (nonatomic, strong) NSDictionary            *commentParam;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkValiteAndBury];
    
    self.naviTheme = NaviThemeWihte;
    
    [self setupWebView];
    
    [self loadData];
    
    [self setupNavigationItems];
    
    WeakSelf(self)
    self.failurePageActionBlock = ^(){
        StrongSelf(self)
        [self loadData];
    };
}

- (void)checkValiteAndBury {
    NSString *urlStr = [NSString stringWithFormat:@"%@",_urlString];
    if (![urlStr isNotNull]) {
        [[iToast makeText:@"网页地址为空"] show];
        [self back];
        return;
    }
    
    /*
     if (![[urlStr lowercaseString] hasPrefix:@"http"]) {
     [[iToast makeText:@"无效的网页地址"] show];
     [self back];
     return;
     }
     */
    
    NSDictionary *params = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_navi_h5" actionId:30100 params:params];
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)loadData {
    if ([_urlString isNotNull]) {
        if(self.navigationController)[TCProgressHUD showInView:self.view];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2/*延迟执行时间*/ * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *state = [self.webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
            [self dealWithFinishLoad];
            //加载完成
            if ([state isEqualToString:@"complete"]||
                [state isEqualToString:@"loading"]||
                [state isEqualToString:@"interactive"]) {
            }
        });
    }else{
        [[iToast makeText:@"网页地址为空"] show];
        [self back];
    }
}

- (void)setupNavigationItems {
    
    if(!self.navigationController) return;
    
    UIBarButtonItem *backBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(webBack) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
        btn.hidden = YES;
        self.backWebBtn = btn;
    }];
    UIBarButtonItem *closeBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(webClose) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [btn setImage:[UIImage imageNamed:@"navigation_close"] forState:UIControlStateNormal];
        btn.hidden = YES;
        self.closeBtn = btn;
    }];
    self.navigationItem.leftBarButtonItems = @[backBarButtonItem,closeBarButtonItem];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"ProductDetail_navi_more" highImageName:nil postion:UIBarButtonPositionRightCenter target:self action:@selector(rightBarButtonItemAction)];
}

- (void)setupBackItem:(NSString *)imageName
        highImageName:(NSString *)highImageName{}

- (void)webBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self back];
    }
}

- (void)webClose{
    [self back];
}

- (void)rightBarButtonItemAction{
    CGFloat rightMargin = 25;
    if ([UIScreen mainScreen].bounds.size.width>400) rightMargin = 29;
    CGFloat barBtnX = CGRectGetWidth([[UIScreen mainScreen] bounds]) - rightMargin;
    CGFloat barBtnY = 46;
    ZPPopoverItem *popoverItem1 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_share" title:@"分享"];
    ZPPopoverItem *popoverItem2 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_home"  title:@"首页"];
    ZPPopoverItem *popoverItem3 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_topic" title:@"话题"];
    ZPPopover *popover = [ZPPopover popoverWithTopPointInWindow:CGPointMake(barBtnX, barBtnY) items:@[popoverItem1,popoverItem2,popoverItem3]];
    popover.delegate = self;
    [popover show];
}

#pragma mark - ZPPopoverDelegate

- (void)didSelectMenuItemAtIndex:(NSUInteger)index {
    if (index == 0) {
        if (!_shareObject) _shareObject = self.defaultShareObj;
        [self shareWithObj:self.shareObject];
    }else if (index == 1) {
        [[TabBarController shareTabBarController] selectIndex:0];
    }else if (index == 2){
        [[TabBarController shareTabBarController] selectIndex:1];
    }
}

- (void)reload {
    [self loadData];
}

- (CommonShareObject *)defaultShareObj {
    NSString *urlString = [self.urlString isNotNull]?self.urlString:@"http://m.kidstc.com/";
    NSString *productName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    NSString *desc = [NSString stringWithFormat:@"%@与您分享",productName];
    UIImage *image = [UIImage imageNamed:[self getAppIconName]];
    
    CommonShareObject *shareObj = [CommonShareObject shareObjectWithTitle:self.navigationItem.title description:desc thumbImage:image urlString:urlString];
    shareObj.followingContent = @"【童成网】";
    return shareObj;
}

- (NSString *)getAppIconName{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = nil;
    if (iconsArr.count>0) {
        iconLastName = [iconsArr lastObject];
    }
    return iconLastName;
}

- (void)makeSegue:(ViewController *)controller {
    if (self.navigationController) {
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UINavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
        if (navi && [navi isKindOfClass:[UINavigationController class]]) {
            [self back];
            [navi pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *absoluteString = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    TCLog(@"WebView-request-absoluteString-ALL-:\n%@\n",absoluteString);
    if ([absoluteString hasPrefix:Prefix]) {
        NSString *hook = [absoluteString substringFromIndex:Prefix.length];
        NSArray *hooks = [hook componentsSeparatedByString:@"::"];
        NSString *meth = [[hooks firstObject] stringByAppendingString:@":"];
        NSString *para = [hooks lastObject];
        SEL sel        = NSSelectorFromString(meth);
        if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:sel withObject:para];
#pragma clang diagnostic pop
        }else{
            TCLog(@"WebView-request-absoluteString-NO-:\n%@\n",absoluteString);
            //[[iToast makeText:@"暂不支持的交互方式"] show];
        }
        return NO;
    }
    //self.shareObject     = nil;
    //self.callBackJS      = nil;
    self.urlString       = absoluteString;
    TCLog(@"WebView-request-absoluteString-YES-:\n%@\n",absoluteString);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    TCLog(@"");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    TCLog(@"");
    [self dealWithFinishLoad];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    TCLog(@"");
    [self dealWithFinishLoad];
    [self loadDataFailureAction:YES];
}

#pragma mark UIWebViewDelegate helpers

- (void)dealWithFinishLoad {
    [self setNaviTitle];
    [self setHideLeftBarButtonItems];
    [TCProgressHUD dismiss];
}

- (void)setNaviTitle{
    if(!self.navigationController) return;
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = [title isNotNull]?title:@"";
}

- (void)setHideLeftBarButtonItems{
    if(!self.navigationController) return;
    BOOL canGoBack = self.webView.canGoBack;
    BOOL naviCount = self.navigationController.viewControllers.count>1;
    self.backWebBtn.hidden  = !(canGoBack || naviCount);
    self.closeBtn.hidden = !(canGoBack && naviCount);
}

#pragma mark - ==============actions==============
#pragma mark 关闭窗口
- (void)close_activity:(NSString *)param{
    [self webClose];
}
#pragma mark 服务详情
- (void)productdetail:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *serviceId = [dic objectForKey:@"id"];
    NSString *channelId = [dic objectForKey:@"chid"];
    ProductDetailType type = ProductDetailTypeNormal;
    id typeId = dic[@"type"];
    if ([typeId respondsToSelector:@selector(integerValue)]) {
        type = [typeId integerValue];
        switch (type) {
            case ProductDetailTypeNormal:
            case ProductDetailTypeTicket:
            case ProductDetailTypeFree:
                break;
            default:
            {
                type = ProductDetailTypeNormal;
            }
                break;
        }
    }
    if ([serviceId isNotNull]) {
        channelId = [channelId isNotNull]?channelId:@"0";
        ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:serviceId channelId:channelId];
        controller.type = type;
        [self makeSegue:controller];
        NSDictionary *params = @{@"url":self.urlString,
                                 @"pid":serviceId,
                                 @"cid":channelId};
        [BuryPointManager trackEvent:@"event_skip_serve_detail" actionId:30001 params:params];
    }else{
        [[iToast makeText:@"服务id为空"] show];
    }
}
#pragma mark 门店详情
- (void)storeDetail:(NSString *)param {
    NSRange range = [param rangeOfString:@"id="];
    NSString *ID = [param substringFromIndex:(range.location+range.length)];
    if ([ID isNotNull]) {
        TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
        controller.storeId = ID;
        [self makeSegue:controller];
        NSDictionary *params = @{@"url":self.urlString,
                                 @"sid":ID};
        [BuryPointManager trackEvent:@"event_skip_store_detail" actionId:30003 params:params];
    }else{
        [[iToast makeText:@"门店id为空"] show];
    }
}
#pragma mark 攻略详情
- (void)strategyDetail:(NSString *)param {
    NSRange range = [param rangeOfString:@"id="];
    NSString *ID = [param substringFromIndex:(range.location+range.length)];
    if ([ID isNotNull]) {
        ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:ID];
        [self makeSegue:controller];
        NSDictionary *params = @{@"url":self.urlString,
                                 @"id":ID};
        [BuryPointManager trackEvent:@"event_skip_stgy_detail" actionId:30004 params:params];
    }else{
        [[iToast makeText:@"攻略id为空"] show];
    }
}
#pragma mark 栏目详情
- (void)showColumnDetail:(NSString *)param {
    NSRange range = [param rangeOfString:@"sysNo="];
    NSString *sysNo = [param substringFromIndex:(range.location+range.length)];
    if ([sysNo isNotNull]) {
        ArticleColumnViewController *controller = [[ArticleColumnViewController alloc]init];
        controller.columnSysNo = sysNo;
        [self makeSegue:controller];
        NSDictionary *paramsDic = @{@"url":self.urlString,
                                    @"id":sysNo};
        [BuryPointManager trackEvent:@"event_skip_column_detail" actionId:30014 params:paramsDic];
    }else{
        [[iToast makeText:@"栏目id为空"] show];
    }
}
#pragma mark 闪购详情
- (void)flashServeDetail:(NSString *)param {
    NSRange range = [param rangeOfString:@"pid="];
    NSString *pid = [param substringFromIndex:(range.location+range.length)];
    if ([pid isNotNull]) {
        FlashBuyProductDetailViewController *controller = [[FlashBuyProductDetailViewController alloc] init];
        controller.pid = pid;
        [self makeSegue:controller];
        
        NSDictionary *params = @{@"url":self.urlString,
                                 @"pid":pid};
        [BuryPointManager trackEvent:@"event_skip_flash_detail" actionId:30002 params:params];
    }else{
        [[iToast makeText:@"闪购详情关联id为空"] show];
    }
}
#pragma mark 拼团详情
- (void)fightGroupDetail:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    ViewController *toController = nil;
    NSString *pid = [NSString stringWithFormat:@"%@", dic[@"pid"]];
    id gidID = dic[@"gid"];
    if (gidID && [gidID respondsToSelector:@selector(longLongValue)]) {
        long long gid = [gidID longLongValue];
        if (gid>0) {
            WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc] init];
            controller.productId = pid;
            controller.openGroupId = [NSString stringWithFormat:@"%lld",gid];
            toController = controller;
        }
    }
    if (!toController) {
        WolesaleProductDetailViewController *controller = [[WolesaleProductDetailViewController alloc] init];
        controller.productId = pid;
        toController = controller;
    }
    if(toController)[self makeSegue:toController];
}
#pragma mark 订单详情
- (void)orderDetail:(NSString *)param {
    /*
     NSRange range = [param rangeOfString:@"orderId="];
     NSString *orderId = [param substringFromIndex:(range.location+range.length)];
     */
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *orderId = [NSString stringWithFormat:@"%@",dic[@"orderId"]];
    if (![orderId isNotNull]) {
        [[iToast makeText:@"关联id为空"] show];
        return;
    }
    OrderKind kind = OrderKindNormal;
    id kindId = dic[@"type"];
    if ([kindId respondsToSelector:@selector(integerValue)]) {
        kind = (OrderKind)[kindId integerValue];
    }
    
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ViewController *controller = nil;
        switch (kind) {
            case OrderKindNormal:
            {
                ProductOrderNormalDetailViewController *vc = [[ProductOrderNormalDetailViewController alloc]init];
                vc.orderId = orderId;
                controller = vc;
            }
                break;
            case OrderKindTicket:
            {
                ProductOrderTicketDetailViewController *vc = [[ProductOrderTicketDetailViewController alloc]init];
                vc.orderId = orderId;
                controller = vc;
            }
                break;
            case OrderKindFree:
            {
                ProductOrderFreeDetailViewController *vc = [[ProductOrderFreeDetailViewController alloc]init];
                vc.orderId = orderId;
                controller = vc;
            }
                break;
            default:
            {
                [[iToast makeText:@"暂不支持的订单类型"] show];
                return;
            }
                break;
        }
        [self makeSegue:controller];
        NSDictionary *params = @{@"url":self.urlString,
                                 @"orderId":orderId};
        [BuryPointManager trackEvent:@"event_skip_order_detail" actionId:30005 params:params];
    }];
}
#pragma mark 闪购订单详情
- (void)flashOrderDetail:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *orderId = [NSString stringWithFormat:@"%@",dic[@"orderId"]];
    if (![orderId isNotNull]) {
        [[iToast makeText:@"关联id为空"] show];
        return;
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc]init];
        controller.orderId = orderId;
        [self makeSegue:controller];
    }];
}
#pragma mark 普通订单列表
- (void)orderList:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    ProductOrderListOrderType type = ProductOrderListOrderTypeAll;
    id typeId = dic[@"kind"];
    if ([typeId respondsToSelector:@selector(integerValue)]) {
        type = (ProductOrderListOrderType)[typeId integerValue];
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductOrderListViewController *controller = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeAll];
        [controller insetOrderType:type];
        [self makeSegue:controller];
    }];
}
#pragma mark 票务订单列表
- (void)ticketOrderList:(NSString *)param {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductOrderListViewController *controller = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeAll];
        controller.orderType = ProductOrderListOrderTypeTicket;
        [self makeSegue:controller];
    }];
}
#pragma mark 闪购订单列表
- (void)flashOrderList:(NSString *)param {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        FlashServiceOrderListViewController *controller = [[FlashServiceOrderListViewController alloc] init];
        [self makeSegue:controller];
    }];
}
#pragma mark 报名订单列表
- (void)enrollOrderList:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    FreeType type = FreeTypeFreeActivity;
    id typeId = dic[@"freeType"];
    if ([typeId respondsToSelector:@selector(integerValue)]) {
        type = (FreeType)[typeId integerValue];
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductOrderFreeListViewController *controller = [[ProductOrderFreeListViewController alloc] init];
        controller.type = type;
        [self makeSegue:controller];
    }];
}
#pragma mark 萝卜商城
- (void)radishMall:(NSString *)param {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        RadishMallViewController *controller = [[RadishMallViewController alloc] init];
        [self makeSegue:controller];
    }];
}
#pragma mark 萝卜订单列表
- (void)radishOrderList:(NSString *)param {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        RadishProductOrderListViewController *controller = [[RadishProductOrderListViewController alloc] init];
        [self makeSegue:controller];
    }];
}
#pragma mark 萝卜订单详情
- (void)radishOrderDetail:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *orderId = [NSString stringWithFormat:@"%@",dic[@"orderId"]];
    if (![orderId isNotNull]) {
        [[iToast makeText:@"关联id为空"] show];
        return;
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        RadishOrderDetailViewController *controller = [[RadishOrderDetailViewController alloc] init];
        controller.orderId = orderId;
        [self makeSegue:controller];
    }];
}
#pragma mark 萝卜商品详情
- (void)radishProductDetail:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *serviceId = [dic objectForKey:@"pid"];
    NSString *channelId = [dic objectForKey:@"cid"];
    if (![serviceId isNotNull]) {
        [[iToast makeText:@"关联服务为空"] show];
        return;
    }
    RadishProductDetailViewController *controller = [[RadishProductDetailViewController alloc] init];
    controller.productId = serviceId;
    controller.channelId = channelId;
    [self makeSegue:controller];
}
#pragma mark 秒杀活动
- (void)seckillActivity:(NSString *)param {
    SeckillViewController *controller = [[SeckillViewController alloc] initWithNibName:@"SeckillViewController" bundle:nil];
    [self makeSegue:controller];
}
#pragma mark 服务活动
- (void)productActivity:(NSString *)param {
    NSDictionary *dic = [NSDictionary parsetUrl:param];
    NSString *aid = [dic objectForKey:@"aid"];
    if (![aid isNotNull]) {
        [[iToast makeText:@"关联编号为空"] show];
        return;
    }
    ActivityProductViewController *controller = [[ActivityProductViewController alloc] init];
    controller.ID = aid;
    [self makeSegue:controller];
}

#pragma mark 回到首页
- (void)home:(NSString *)param {
    [[TabBarController shareTabBarController] selectIndex:0];
    NSDictionary *params = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_skip_home" actionId:30008 params:params];
}
#pragma mark 优惠券列表
- (void)couponList:(NSString *)param {
    //NSRange range = [param rangeOfString:@"status="];
    //NSString *status = [param substringFromIndex:(range.location+range.length)];
    CouponListViewController *controller = [[CouponListViewController alloc] init];
    [self makeSegue:controller];
}
#pragma mark 检查登录
- (void)login:(NSString *)param {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self reload];
    }];
    NSDictionary *params = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_skip_login" actionId:30009 params:params];
}
#pragma mark 评论视图
- (void)evaluate:(NSString *)param {
    NSDictionary *params = [NSDictionary parsetUrl:param];
    if (params.count>0) {
        self.commentParam = params;
        [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
            CommentUtilsViewController *controller = [[CommentUtilsViewController alloc] initWithNibName:@"CommentUtilsViewController" bundle:nil];
            controller.delegate = self;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
            self.callBackJS = [params objectForKey:@"callback"];
        }];
        NSDictionary *params = @{@"url":self.urlString};
        [BuryPointManager trackEvent:@"event_skip_serve_evaluate" actionId:30010 params:params];
    }else{
        [[iToast makeText:@"参数为空"] show];
    }
}
// CommentUtilsViewControllerDelegate
- (void)commentUtilsViewController:(CommentUtilsViewController *)controller didClickSendWithPhotos:(NSArray *)photos text:(NSString *)text {
    if (text.length<1) {
        [[iToast makeText:@"请至少输入1个字"] show];
        return;
    }
    if (photos.count>0) {//评论-有照片-先上传照片
        [TCProgressHUD showSVP];
        [[KTCImageUploader sharedInstance] startUploadWithImagesArray:photos splitCount:2 withSucceed:^(NSArray *locateUrlStrings) {
            [self uploadImgCommentSuccess:locateUrlStrings content:text];
        } failure:^(NSError *error) {
            [self uploadImgCommentFailure:error];
        }];
    } else {//评论-无照片
        [TCProgressHUD showSVP];
        [self submitCommentsWithUploadLocations:nil content:text];
    }
}
//上传图片 成功
- (void)uploadImgCommentSuccess:(NSArray *)urlStrings content:(NSString *)content {
    [self submitCommentsWithUploadLocations:urlStrings content:content];
}
//上传图片 失败
- (void)uploadImgCommentFailure:(NSError *)error {
    NSString *errStr = error.userInfo[@"data"];
    NSString *errMsg = [errStr isNotNull]?errStr:@"照片上传失败，请重新提交";
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}
//提交评论
- (void)submitCommentsWithUploadLocations:(NSArray *)locationUrls content:(NSString *)content {
    KTCCommentObject *object = [[KTCCommentObject alloc] init];
    if ([self.commentParam objectForKey:@"relationSysNo"]) {
        object.identifier = [NSString stringWithFormat:@"%@", [self.commentParam objectForKey:@"relationSysNo"]];
    }
    object.relationType = (CommentRelationType)[[self.commentParam objectForKey:@"relationType"] integerValue];
    object.isAnonymous = NO;
    object.isComment = [[self.commentParam objectForKey:@"isComment"] boolValue];
    if ([self.commentParam objectForKey:@"replyId"]) {
        object.commentIdentifier = [NSString stringWithFormat:@"%@", [self.commentParam objectForKey:@"replyId"]];
    }
    object.content = content;
    object.uploadImageStrings = locationUrls;
    if (!self.commentManager) self.commentManager = [[KTCCommentManager alloc] init];
    
    WeakSelf(self)
    [self.commentManager addCommentWithObject:object succeed:^(NSDictionary *data) {
        StrongSelf(self)
        [self submitCommentSucceed:data];
    } failure:^(NSError *error) {
        StrongSelf(self)
        [self submitCommentFailed:error];
    }];
}
//提交评论 请求成功
- (void)submitCommentSucceed:(NSDictionary *)data {
    [[iToast makeText:@"评论成功！"] show];
    if ([self.callBackJS length] > 0) {
        [self.webView stringByEvaluatingJavaScriptFromString:self.callBackJS];
    }
    self.callBackJS = nil;
    [TCProgressHUD dismissSVP];
    
    UIViewController *controller = self.presentedViewController;
    if (controller) [controller dismissViewControllerAnimated:YES completion:nil];
}
//提交评论 请求失败
- (void)submitCommentFailed:(NSError *)error {
    NSString *errMsg = @"提交评论失败，请重新提交。";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}

#pragma mark 立即分享
- (void)share:(NSString *)param {
    CommonShareObject *shareObject = [self shareObjWithParam:param];
    if (shareObject) {
        [self shareWithObj:shareObject];
        NSDictionary *params = @{@"url":self.urlString};
        [BuryPointManager trackEvent:@"event_click_share" actionId:30011 params:params];
    }else{
        [[iToast makeText:@"无效的分享数据"] show];
    }
}
#pragma mark 注入分享
- (void)saveShare:(NSString *)param {
    self.shareObject = [self shareObjWithParam:param];
}

#pragma mark 快速分享
- (void)directShare:(NSString *)param {
    CommonShareObject *shareObject = [self shareObjWithParam:param];
    if (shareObject) {
        CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:shareObject sourceType:KTCShareServiceTypeNews];
        controller.webViewShareCallBackType = self.webViewShareCallBackType;
        controller.webViewCallBack = ^(KTCShareServiceChannel channel, BOOL success){
            if (!success)return;
            if([self.shareCallBack isNotNull]) {
                NSString *channelStr = [NSString stringWithFormat:@"\"%zd\"",channel];
                NSMutableString *callBackJS = [[NSMutableString alloc]initWithString:self.shareCallBack];
                if ([self.shareCallBack containsString:@"()"]) {
                    NSRange range = [self.shareCallBack rangeOfString:@"("];
                    [callBackJS insertString:channelStr atIndex:range.location+1];
                }
                [self executeJS:callBackJS];
            }
        };
        [controller shareWithType:self.shareType object:shareObject sourceType:KTCShareServiceTypeNews];
        NSDictionary *params = @{@"url":self.urlString};
        [BuryPointManager trackEvent:@"event_click_share" actionId:30011 params:params];
    }else{
        [[iToast makeText:@"无效的分享数据"] show];
    }
}

#pragma mark 上传图片
- (void)upload_img:(NSString *)param {
    NSDictionary *params = [NSDictionary parsetUrl:param];
    self.callBackJS = [params objectForKey:@"callback"];
    NSUInteger maxCount = [[params objectForKey:@"maxCount"] integerValue];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    NSDictionary *paramsDic = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_skip_take_picture" actionId:30012 params:paramsDic];
}
//TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count<=0) return;
    TCLog(@"普通上传图片--开始上传");
    [TCProgressHUD showSVP];
    [[KTCImageUploader sharedInstance] startUploadWithImagesArray:photos splitCount:1 withSucceed:^(NSArray *locateUrlStrings) {
        TCLog(@"普通上传图片--上传成功");
        [self uploadImgNormalSuccess:locateUrlStrings];
    } failure:^(NSError *error) {
        TCLog(@"普通上传图片--上传失败");
        [self uploadImgNormalFailure:error];
    }];
}
//图片上传 成功
- (void)uploadImgNormalSuccess:(NSArray *)urlStrings {
    if ([self.callBackJS isNotNull]) {
        NSString *allImgUrlString = @"";
        NSUInteger count = urlStrings.count;
        for (int i = 0; i<count; i++) {
            if (i == 0) allImgUrlString = [allImgUrlString stringByAppendingString:@"\""];
            allImgUrlString = [allImgUrlString stringByAppendingString:urlStrings[i]];
            if (i != count-1) allImgUrlString = [allImgUrlString stringByAppendingString:@","];
            if (i == count-1) allImgUrlString = [allImgUrlString stringByAppendingString:@"\""];
        }
        NSMutableString *callBackJS = [[NSMutableString alloc]initWithString:self.callBackJS];
        if ([self.callBackJS containsString:@"()"]) {
            NSRange range = [self.callBackJS rangeOfString:@"("];
            [callBackJS insertString:allImgUrlString atIndex:range.location+1];
        }
        [self executeJS:callBackJS];
    }
    [TCProgressHUD dismissSVP];
}
//图片上传 失败
- (void)uploadImgNormalFailure:(NSError *)error {
    NSString *errStr = error.userInfo[@"data"];
    NSString *errMsg = [errStr isNotNull]?errStr:@"照片上传失败，请重新提交";
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}
#pragma mark 资讯图集
- (void)showColumnAlbum:(NSString *)param {
    NSRange range = [param rangeOfString:@"sysNo="];
    NSString *sysNo = [param substringFromIndex:(range.location+range.length)];
    if ([sysNo isNotNull]) {
        ZPPhotoBrowserViewController *controller = [[ZPPhotoBrowserViewController alloc] init];
        controller.articleId = sysNo;
        [self makeSegue:controller];
    }else{
        [[iToast makeText:@"关联资讯id为空"] show];
    }
}
#pragma mark 资讯评论
- (void)showColumnEva:(NSString *)param {
    NSRange range = [param rangeOfString:@"sysNo="];
    NSString *sysNo = [param substringFromIndex:(range.location+range.length)];
    if ([sysNo isNotNull]) {
        ArticleCommentViewController *controller = [[ArticleCommentViewController alloc] init];
        controller.relationId = sysNo;
        [self makeSegue:controller];
        NSDictionary *paramsDic = @{@"url":self.urlString,
                                    @"id":sysNo};
        [BuryPointManager trackEvent:@"event_skip_news_evaluate" actionId:30013 params:paramsDic];
    }else{
        [[iToast makeText:@"关联资讯id为空"] show];
    }
}
#pragma mark 资讯栏目
- (void)showColumnList:(NSString *)param {
    ColumnViewController *controller = [[ColumnViewController alloc]init];
    [self makeSegue:controller];
}
#pragma mark 返回上一页
- (void)pageBack:(NSString *)param {
    [self webBack];
}
#pragma mark 显示大图
- (void)showAlbumList:(NSString *)param {
    NSRange range = [param rangeOfString:@"jsonStr="];
    NSString *jsonStr = [param substringFromIndex:(range.location+range.length)];
    NSDictionary *dic = [NSDictionary dictionaryWithJson:jsonStr];
    if (dic.count>0) {
        [self showPhotoBrowser:dic];
    }else{
        [[iToast makeText:@"大图列表参数为空"] show];
    }
}
- (void)showPhotoBrowser:(NSDictionary *)dic {
    NSString *currentStr = [NSString stringWithFormat:@"%@",dic[@"current"]];
    NSArray *urls = dic[@"urls"];
    if (urls.count>0) {
        __block NSUInteger currentIndex = 0;
        __block NSMutableArray *photos = [NSMutableArray array];
        [urls enumerateObjectsUsingBlock:^(NSString  *urlStr, NSUInteger idx, BOOL *stop) {
            MWPhoto *photo = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:urlStr]];
            if (photo) [photos addObject:photo];
            if ([currentStr isNotNull] && [currentStr isEqualToString:urlStr])currentIndex = idx;
        }];
        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        [photoBrowser setCurrentPhotoIndex:currentIndex];
        [self presentViewController:photoBrowser animated:YES completion:nil];
    }
}
#pragma mark 关闭加载
- (void)closeLoading:(NSString *)param {
    [TCProgressHUD dismiss];
}
#pragma mark 注入标题
- (void)setTitle:(NSString *)param {
    NSRange range = [param rangeOfString:@"title="];
    NSString *title = [param substringFromIndex:(range.location+range.length)];
    title = [title isNotNull]?title:@"";
    self.navigationItem.title = title;
}
#pragma mark 隐藏/显示/透明导航栏
- (void)OptNavigationBar:(NSString *)param {
    NSRange range = [param rangeOfString:@"opt_type="];
    WebViewOptNavBarType type = [[param substringFromIndex:(range.location+range.length)] integerValue];
    switch (type) {
        case WebViewOptNavBarTypeShow:
        {
            self.naviColor = [UIColor whiteColor];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
            break;
        case WebViewOptNavBarTypeHide:
        {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
            break;
        case WebViewOptNavBarTypeTransparent:
        {
            self.naviColor = [UIColor clearColor];
        }
            break;
        default:
        {
            return;
        }
            break;
    }
    self.naviTheme = NaviThemeWihte;
    self.webView.scrollView.scrollIndicatorInsets = self.webView.scrollView.contentInset;
}
#pragma mark 隐藏/显示tabBar
- (void)operationTabBar:(NSString *)param {
    NSRange range = [param rangeOfString:@"hide="];
    WebViewOptTabBarType type = [[param substringFromIndex:(range.location+range.length)] integerValue];
    
    UITabBar *tabBar = [TabBarController shareTabBarController].tabBar;
    CGRect frame = tabBar.frame;
    CGFloat x = 0, w = CGRectGetWidth(frame), h = CGRectGetHeight(frame), y;
    
    CGFloat alpha;
    
    UIEdgeInsets oldInsets = self.webView.scrollView.contentInset;
    CGFloat top = oldInsets.top, left = oldInsets.left, bottom, right = oldInsets.right;
    
    switch (type) {
        case WebViewOptTabBarTypeHide:
        {
            y = SCREEN_HEIGHT;
            alpha = 0;
            bottom = 0;
        }
            break;
        case WebViewOptTabBarTypeShow:
        {
            y = SCREEN_HEIGHT-h;
            alpha = 1;
            bottom = 49;
        }
            break;
        default:
        {
            return;
        }
            break;
    }
    CGRect rect = CGRectMake(x, y, w, h);
    UIEdgeInsets newInsets = UIEdgeInsetsMake(top, left, bottom, right);
    [UIView animateWithDuration:0.2 animations:^{
        tabBar.frame = rect;
        tabBar.alpha = alpha;
        self.webView.scrollView.contentInset = newInsets;
        self.webView.scrollView.scrollIndicatorInsets = newInsets;
    }];
}

#pragma mark ==================================== -

#pragma mark actions helpers

- (void)executeJS:(NSString *)js {
    TCLog(@"callBackJS:%@",js);
    NSString *jsMyAlert = [NSString stringWithFormat:@"setTimeout(function(){%@}, 1);",js];
    [self.webView stringByEvaluatingJavaScriptFromString:jsMyAlert];
}

- (CommonShareObject *)shareObjWithParam:(NSString *)paramString {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    NSArray *paramsArray = [paramString componentsSeparatedByString:@";"];
    for (NSString *string in paramsArray) {
        NSRange titleRange = [string rangeOfString:@"title="];
        NSRange descRange  = [string rangeOfString:@"desc="];
        NSRange picRange   = [string rangeOfString:@"pic="];
        NSRange urlRange   = [string rangeOfString:@"url="];
        NSRange callBackRange = [string rangeOfString:@"callBack="];
        NSRange callBackTypeRange = [string rangeOfString:@"callBackType="];
        NSRange shareTypeRange = [string rangeOfString:@"shareType="];
        if (titleRange.location != NSNotFound) {
            NSString *title = [string substringFromIndex:titleRange.length];
            [tempDic setObject:title forKey:@"title"];
            continue;
        }
        if (descRange.location != NSNotFound) {
            NSString *desc = [string substringFromIndex:descRange.length];
            [tempDic setObject:desc forKey:@"desc"];
            continue;
        }
        if (picRange.location != NSNotFound) {
            NSString *pic = [string substringFromIndex:picRange.length];
            [tempDic setObject:pic forKey:@"pic"];
            continue;
        }
        if (urlRange.location != NSNotFound) {
            NSString *url = [string substringFromIndex:urlRange.length];
            [tempDic setObject:url forKey:@"url"];
            NSDictionary *urlParamsDic = [NSDictionary parsetUrl:url];
            if ([urlParamsDic objectForKey:@"id"]) {
                NSString *identifier = [NSString stringWithFormat:@"%@", [urlParamsDic objectForKey:@"id"]];
                [tempDic setObject:identifier forKey:@"id"];
            }
            continue;
        }
        if (callBackRange.location != NSNotFound) {
            self.shareCallBack = [string substringFromIndex:callBackRange.length];
            continue;
        }
        if (callBackTypeRange.location != NSNotFound) {
            self.webViewShareCallBackType = [[string substringFromIndex:callBackTypeRange.length] integerValue];
            continue;
        }
        if (shareTypeRange.location != NSNotFound) {
            self.shareType = (CommonShareType)([[string substringFromIndex:shareTypeRange.length] integerValue] - 1);
            continue;
        }
    }
    NSString *title          = [tempDic objectForKey:@"title"];
    NSString *desc           = [tempDic objectForKey:@"desc"];
    NSString *thumbUrlString = [tempDic objectForKey:@"pic"];
    NSString *linkUrlString  = [tempDic objectForKey:@"url"];
    NSString *identifier     = [tempDic objectForKey:@"id"];
    CommonShareObject *shareObject = [CommonShareObject shareObjectWithTitle:title description:desc thumbImageUrl:[NSURL URLWithString:thumbUrlString] urlString:linkUrlString];
    shareObject.identifier = identifier;
    shareObject.followingContent = @"【童成网】";
    return shareObject;
}

- (void)shareWithObj:(CommonShareObject *)obj {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:obj sourceType:KTCShareServiceTypeNews];
    controller.webViewShareCallBackType = self.webViewShareCallBackType;
    controller.webViewCallBack = ^(KTCShareServiceChannel channel, BOOL success){
        if (!success)return;
        if([self.shareCallBack isNotNull]) {
            NSString *channelStr = [NSString stringWithFormat:@"\"%zd\"",channel];
            NSMutableString *callBackJS = [[NSMutableString alloc]initWithString:self.shareCallBack];
            if ([self.shareCallBack containsString:@"()"]) {
                NSRange range = [self.shareCallBack rangeOfString:@"("];
                [callBackJS insertString:channelStr atIndex:range.location+1];
            }
            [self executeJS:callBackJS];
        }
    };
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)dealloc {
    self.webView.delegate = nil;
    self.webView.scrollView.delegate = nil;
}

@end
