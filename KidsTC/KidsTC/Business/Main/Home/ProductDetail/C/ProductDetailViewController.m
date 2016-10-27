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

#import "SegueMaster.h"
#import "WebViewController.h"
#import "CommentDetailViewController.h"
#import "CommentListViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductDetailAddressViewController.h"

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
    switch (type) {
        case ProductDetailViewActionTypeSegue://通用跳转
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case ProductDetailViewActionTypeDate://显示日期
        {
            ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ProductDetailViewActionTypeAddress://显示位置
        {
            ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ProductDetailViewActionTypeReplyConsult://回复咨询
        {
            
        }
            break;
        case ProductDetailViewActionTypeMoreConsult://更多咨询
        {
            
        }
            break;
        case ProductDetailViewActionTypeStandard://套餐信息
        {
            ProductDetailStandard *standard = value;
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:standard.productId channelId:standard.channelId];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ProductDetailViewActionTypeBuyStandard://购买套餐
        {
            
        }
            break;
        case ProductDetailViewActionTypeCoupon://优惠券
        case ProductDetailViewActionTypeConsult://在线咨询
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = value;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ProductDetailViewActionTypeContact://联系商家
        {
            NSArray<ProductDetailStore *> *store = value;
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择门店" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            [store enumerateObjectsUsingBlock:^(ProductDetailStore *obj, NSUInteger idx, BOOL *stop) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:obj.storeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self makePhoneCallWithNumbers:obj.phones];
                }];
                [controller addAction:action];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:cancelAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case ProductDetailViewActionTypeComment://查看评论
        {
            ProductDetailView *view = (ProductDetailView *)self.view;
            ProductDetailData *data = view.data;
            NSUInteger index = [value integerValue];
            if (index<data.commentItemsArray.count) {
                CommentListItemModel *model = data.commentItemsArray[index];
                model.relationIdentifier = self.productId;
                CommentDetailViewController *controller =
                [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore
                                                       relationType:(CommentRelationType)(data.productType)
                                                        headerModel:model];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
            break;
        case ProductDetailViewActionTypeMoreComment://查看全部评论
        {
            ProductDetailData *data = value;
            ProductDetailComment *comment = value;
            NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                               CommentListTabNumberKeyGood:@(comment.good),
                                               CommentListTabNumberKeyNormal:@(comment.normal),
                                               CommentListTabNumberKeyBad:@(comment.bad),
                                               CommentListTabNumberKeyPicture:@(comment.pic)};
            CommentListViewController *controller =
            [[CommentListViewController alloc] initWithIdentifier:self.productId
                                                     relationType:(CommentRelationType)(data.productType)
                                                 commentNumberDic:commentNumberDic];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ProductDetailViewActionTypeRecommend://为您推荐
        {
            ProductDetailRecommendItem *item = value;
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:item.productNo channelId:item.channelId];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

- (void)makePhoneCallWithNumbers:(NSArray *)numbers {
    if (!numbers || ![numbers isKindOfClass:[NSArray class]]) {
        return;
    }
    if ([numbers count] == 0) {
        return;
    } else if ([numbers count] == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [numbers firstObject]]]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择联系电话" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phoneNumber in numbers) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]]];
            }];
            [controller addAction:action];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

@end
