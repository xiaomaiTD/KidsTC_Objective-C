//
//  ProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailView.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "NSString+Category.h"
#import "ProductDetailModel.h"
#import "ProductDetailRecommendModel.h"

@interface ProductDetailViewController ()<ProductDetailViewDelegate>
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@end

@implementation ProductDetailViewController

- (instancetype)initWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId {
    self = [super init];
    if (self) {
        _productId = serviceId;
        _channelId = channelId;
    }
    return self;
}

- (void)loadView {
    ProductDetailView *view = [[ProductDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.naviColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务详情";
    
    [self loadData];
    
}

- (void)loadData {
    
    if (![_productId isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        return;
    }
    NSString *channelId = [_channelId isNotNull]?_channelId:@"0";
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":channelId,
                            @"mapaddr":location};
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCT_GETDETAIL_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductDetailModel *model = [ProductDetailModel modelWithDictionary:dic];
        if (model.data) {
            [self loadProductSuccess:model.data];
            [self loadRecommend];
        }else{
            [self loadProductFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadProductFailure:error];
    }];
}

- (void)loadProductSuccess:(ProductDetailData *)data{
    ProductDetailView *view = (ProductDetailView *)self.view;
    view.data = data;
}

- (void)loadProductFailure:(NSError *)error {
    [[iToast makeText:@"商品信息查询失败"] show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadRecommend {
    
    NSDictionary *param = @{@"pid":_productId};
    [Request startWithName:@"GET_PRODUCT_RECOMMENDS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailRecommendModel *model = [ProductDetailRecommendModel modelWithDictionary:dic];
        if (model.data.count>0) {
            ProductDetailView *view = (ProductDetailView *)self.view;
            ProductDetailData *data = view.data;
            data.recommends = model.data;
            view.data = data;
        }
    } failure:nil];
    
}

#pragma mark - ProductDetailViewDelegate

- (void)productDetailView:(ProductDetailView *)view
               actionType:(ProductDetailViewActionType)type
                    value:(id)value
{
    
}



@end
