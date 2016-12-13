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
#import "ServiceOrderDetailViewController.h"
#import "ProductDetailViewController.h"
#import "StoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "CouponListViewController.h"
#import "FlashDetailViewController.h"
#import "CommonShareViewController.h"
#import "TZImagePickerController.h"
#import "AUIKeyboardAdhesiveView.h"
#import "ArticleColumnViewController.h"

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

typedef enum : NSUInteger {
    WebViewUploadImgTypeNormal,//普通上传图片
    WebViewUploadImgTypeComment//评论发送照片
} WebViewUploadImgType;

@interface WebViewController ()<UIWebViewDelegate,ZPPopoverDelegate,TZImagePickerControllerDelegate,AUIKeyboardAdhesiveViewDelegate,MWPhotoBrowserDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}
@property (nonatomic, weak  ) UIButton                *backWebBtn;
@property (nonatomic, weak  ) UIButton                *closeBtn;
@property (nonatomic, strong) CommonShareObject       *shareObject;

@property (nonatomic, assign) WebViewUploadImgType    uploadImgType;
@property (nonatomic, strong) NSString                *callBackJS;
@property (nonatomic, assign) NSUInteger              maxCount;

@property (nonatomic, strong) KTCCommentManager       *commentManager;
@property (nonatomic, strong) AUIKeyboardAdhesiveView *keyboardAdhesiveView;
@property (nonatomic, strong) NSDictionary            *commentParam;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    if (![_urlString isNotNull]) {
        [[iToast makeText:@"网页地址为空"] show];
        [self back];
        return;
    }
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
        [btn setImage:[UIImage imageNamed:@"navigation_back_n"] forState:UIControlStateNormal];
        btn.hidden = YES;
        self.backWebBtn = btn;
    }];
    UIBarButtonItem *closeBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(webClose) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navigation_close"] forState:UIControlStateNormal];
        btn.hidden = YES;
        self.closeBtn = btn;
    }];
    self.navigationItem.leftBarButtonItems = @[backBarButtonItem,closeBarButtonItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
}

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
    CGFloat rightMargin = 30;
    if ([UIScreen mainScreen].bounds.size.width>400) rightMargin = 34;
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
    //_selectedPhotos      = nil;
    //_selectedAssets      = nil;
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
    self.backBtn.hidden  = !(canGoBack || naviCount);
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
        StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:ID];
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
        FlashDetailViewController *controller = [[FlashDetailViewController alloc] init];
        controller.pid = pid;
        [self makeSegue:controller];
        
        NSDictionary *params = @{@"url":self.urlString,
                                 @"pid":pid};
        [BuryPointManager trackEvent:@"event_skip_flash_detail" actionId:30002 params:params];
    }else{
        [[iToast makeText:@"闪购详情关联id为空"] show];
    }
}
#pragma mark 订单详情
- (void)orderDetail:(NSString *)param {
    NSRange range = [param rangeOfString:@"orderId="];
    NSString *orderId = [param substringFromIndex:(range.location+range.length)];
    if ([orderId isNotNull]) {
        [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
            ServiceOrderDetailViewController *controller = [[ServiceOrderDetailViewController alloc] init];
            controller.orderId = orderId;
            [self makeSegue:controller];
            
            NSDictionary *params = @{@"url":self.urlString,
                                     @"orderId":orderId};
            [BuryPointManager trackEvent:@"event_skip_order_detail" actionId:30005 params:params];
        }];
    }else{
        [[iToast makeText:@"关联id为空"] show];
    }
}
#pragma mark 回到首页
- (void)home:(NSString *)param {
    [[TabBarController shareTabBarController] selectIndex:0];
    NSDictionary *params = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_skip_home" actionId:30008 params:params];
}
#pragma mark 优惠券列表
- (void)couponList:(NSString *)param {
    NSRange range = [param rangeOfString:@"status="];
    NSString *status = [param substringFromIndex:(range.location+range.length)];
    if ([status isNotNull]) {
#warning TODO..
//        CouponListViewTag tag = (CouponListViewTag)[status integerValue];
//        switch (tag) {
//            case CouponListViewTagUnused:
//            case CouponListViewTagHasUsed:
//            case CouponListViewTagHasOverTime:
//            {
//                CouponListViewController *controller = [[CouponListViewController alloc] initWithCouponListViewTag:tag];
//                [self makeSegue:controller];
//                
//                NSDictionary *params = @{@"url":self.urlString};
//                [BuryPointManager trackEvent:@"event_skip_coupon" actionId:30007 params:params];
//            }
//                break;
//            default:
//            {
//                [[iToast makeText:@"所选优惠券状态不正确"] show];
//            }
//                break;
//        }
    }else{
        [[iToast makeText:@"所选优惠券状态为空"] show];
    }
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
            if (!self.keyboardAdhesiveView) {
                AUIKeyboardAdhesiveViewExtensionFunction *photoFunc = [AUIKeyboardAdhesiveViewExtensionFunction funtionWithType:AUIKeyboardAdhesiveViewExtensionFunctionTypeImageUpload];
                self.keyboardAdhesiveView = [[AUIKeyboardAdhesiveView alloc] initWithAvailableFuntions:[NSArray arrayWithObject:photoFunc]];
                [self.keyboardAdhesiveView.headerView setBackgroundColor:COLOR_PINK];
                [self.keyboardAdhesiveView setTextLimitLength:100];
                [self.keyboardAdhesiveView setUploadImageLimitCount:4];
                self.keyboardAdhesiveView.delegate = self;
            }
            [self.keyboardAdhesiveView expand];
            self.callBackJS = [params objectForKey:@"callback"];
        }];
        NSDictionary *params = @{@"url":self.urlString};
        [BuryPointManager trackEvent:@"event_skip_serve_evaluate" actionId:30010 params:params];
    }else{
        [[iToast makeText:@"参数为空"] show];
    }
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
#pragma mark 上传图片
- (void)upload_img:(NSString *)param {
    NSDictionary *params = [NSDictionary parsetUrl:param];
    self.callBackJS = [params objectForKey:@"callback"];
    self.maxCount = [[params objectForKey:@"maxCount"] integerValue];
    [self pickImg:WebViewUploadImgTypeNormal];
    
    NSDictionary *paramsDic = @{@"url":self.urlString};
    [BuryPointManager trackEvent:@"event_skip_take_picture" actionId:30012 params:paramsDic];
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
            self.naviColor = COLOR_PINK;
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

- (CommonShareObject *)shareObjWithParam:(NSString *)paramString {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    NSArray *paramsArray = [paramString componentsSeparatedByString:@";"];
    for (NSString *string in paramsArray) {
        NSRange titleRange = [string rangeOfString:@"title="];
        NSRange descRange  = [string rangeOfString:@"desc="];
        NSRange picRange   = [string rangeOfString:@"pic="];
        NSRange urlRange   = [string rangeOfString:@"url="];
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
    [self presentViewController:controller animated:YES completion:nil];
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

#pragma mark - 选取图片

- (void)pickImg:(WebViewUploadImgType)type {
    NSUInteger count = (type==WebViewUploadImgTypeNormal)?self.maxCount:4;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    [self.keyboardAdhesiveView hide];
    self.uploadImgType = type;
}

//选择照片完成
#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self finishPickImg:_selectedPhotos];
}

- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    if (self.uploadImgType == WebViewUploadImgTypeComment) [self.keyboardAdhesiveView show];
}

#pragma mark TZImagePickerControllerDelegate helpers

- (void)finishPickImg:(NSArray *)array {
    switch (self.uploadImgType) {
        case WebViewUploadImgTypeNormal:
        {
            [self finishPickImgNormal:array];
        }
            break;
        case WebViewUploadImgTypeComment:
        {
            [self finishPickImgComment:array];
        }
            break;
    }
}

#pragma mark - 选取图片完毕：for上传

- (void)finishPickImgNormal:(NSArray *)array {
    if (array.count<=0) return;
    TCLog(@"普通上传图片--开始上传");
    [TCProgressHUD showSVP];
    [[KTCImageUploader sharedInstance] startUploadWithImagesArray:array splitCount:1 withSucceed:^(NSArray *locateUrlStrings) {
        TCLog(@"普通上传图片--上传成功");
        [self uploadImgNormalSuccess:locateUrlStrings];
    } failure:^(NSError *error) {
        TCLog(@"普通上传图片--上传失败");
        [self uploadImgNormalFailure:error];
    }];
}

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
        TCLog(@"callBackJS:%@",callBackJS);
        [self.webView stringByEvaluatingJavaScriptFromString:callBackJS];
    }
    self.callBackJS = nil;
    [TCProgressHUD dismissSVP];
}

- (void)uploadImgNormalFailure:(NSError *)error {
    NSString *errStr = error.userInfo[@"data"];
    NSString *errMsg = [errStr isNotNull]?errStr:@"照片上传失败，请重新提交";
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}

#pragma mark - 选取图片完毕：for评论

- (void)finishPickImgComment:(NSArray *)array {
    
    [self.keyboardAdhesiveView setUploadImages:array];
}

- (NSArray *)makeMWPhotoFromImageArray:(NSArray<UIImage *> *)array {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [[MWPhoto alloc] initWithImage:obj];
        if (photo) {
            [temp addObject:photo];
        }
    }];
    return [NSArray arrayWithArray:temp];
}

#pragma mark - AUIKeyboardAdhesiveViewDelegate

//点击评论相机按钮
- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedExtensionFunctionButtonWithType:(AUIKeyboardAdhesiveViewExtensionFunctionType)type{
    if (type == AUIKeyboardAdhesiveViewExtensionFunctionTypeImageUpload) {
        [self.keyboardAdhesiveView hide];
        [self pickImg:WebViewUploadImgTypeComment];
    }
}
//点击发送评论按钮
- (void)didClickedSendButtonOnKeyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view{
    if (self.commentParam.count<=0) {
        [[iToast makeText:@"参数为空"] show];
        return;
    }
    if (![self isValidateComment]) return;
    if (_selectedPhotos.count>0) {//评论-有照片-先上传照片
        [TCProgressHUD showSVP];
        [[KTCImageUploader sharedInstance] startUploadWithImagesArray:_selectedPhotos splitCount:2 withSucceed:^(NSArray *locateUrlStrings) {
            [self uploadImgCommentSuccess:locateUrlStrings];
        } failure:^(NSError *error) {
            [self uploadImgCommentFailure:error];
        }];
    } else {//评论-无照片
        [TCProgressHUD showSVP];
        [self submitCommentsWithUploadLocations:nil];
    }
}
//预览照片
- (void)keyboardAdhesiveView:(AUIKeyboardAdhesiveView *)view didClickedUploadImageAtIndex:(NSUInteger)index{
    NSArray *array = [self makeMWPhotoFromImageArray:_selectedPhotos];
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:array];
    [photoBrowser setCurrentPhotoIndex:index];
    [photoBrowser setShowDeleteButton:YES];
    photoBrowser.delegate = self;
    [self.keyboardAdhesiveView hide];
    [self presentViewController:photoBrowser animated:YES completion:nil];
}

#pragma mark AUIKeyboardAdhesiveViewDelegate helpers

- (void)uploadImgCommentSuccess:(NSArray *)urlStrings {
    [self submitCommentsWithUploadLocations:urlStrings];
}

- (void)uploadImgCommentFailure:(NSError *)error {
    NSString *errStr = error.userInfo[@"data"];
    NSString *errMsg = [errStr isNotNull]?errStr:@"照片上传失败，请重新提交";
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}

#pragma mark - 提交评论
- (void)submitCommentsWithUploadLocations:(NSArray *)locationUrls {
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
    object.content = self.keyboardAdhesiveView.text;
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
    [self.keyboardAdhesiveView shrink];
    if ([self.callBackJS length] > 0) {
        [self.webView stringByEvaluatingJavaScriptFromString:self.callBackJS];
    }
    self.callBackJS = nil;
    [TCProgressHUD dismissSVP];
}
//提交评论 请求失败
- (void)submitCommentFailed:(NSError *)error {
    NSString *errMsg = @"提交评论失败，请重新提交。";
    NSString *remoteErrMsg = [error.userInfo objectForKey:@"data"];
    if ([remoteErrMsg isKindOfClass:[NSString class]] && [remoteErrMsg length] > 0) {
        errMsg = remoteErrMsg;
    }
    [[iToast makeText:errMsg] show];
    [TCProgressHUD dismissSVP];
}
//检验评论内容合法性
- (BOOL)isValidateComment {
    NSString *commentText = self.keyboardAdhesiveView.text;
    commentText = [commentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([commentText length] < 1) {
        [[iToast makeText:@"请至少输入1个字"] show];
        return NO;
    }
    return YES;
}

#pragma mark - MWPhotoBrowserDelegate

- (void)photoBrowserDidDismissed:(MWPhotoBrowser *)photoBrowser {
    [self.keyboardAdhesiveView show];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didClickedDeleteButtonAtIndex:(NSUInteger)index {
    [self deletePhotoAtIndex:index];
    [self.keyboardAdhesiveView setUploadImages:_selectedPhotos];
}

#pragma mark MWPhotoBrowserDelegate helpers

- (void)deletePhotoAtIndex :(NSInteger)index
{
    if (_selectedPhotos.count>index) {
        [_selectedPhotos removeObjectAtIndex:index];
    }
    if (_selectedAssets.count>index) {
        [_selectedAssets removeObjectAtIndex:index];
    }
}

@end
