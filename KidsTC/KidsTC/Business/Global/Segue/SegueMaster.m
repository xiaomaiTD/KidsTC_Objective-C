//
//  SegueMaster.m
//  KidsTC
//
//  Created by Altair on 12/5/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "SegueMaster.h"
#import "User.h"
#import "WebViewController.h"
#import "ActivityViewController.h"
#import "NurseryViewController.h"
#import "ParentingStrategyViewController.h"
#import "ProductDetailViewController.h"
#import "StoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "CouponListViewController.h"
#import "ProductOrderListViewController.h"
#import "NotificationCenterViewController.h"
#import "ArticleColumnViewController.h"
#import "ZPPhotoBrowserViewController.h"
#import "ColumnViewController.h"
#import "FlashDetailViewController.h"
#import "StrategyTagColumnTableViewController.h"
#import "SearchResultViewController.h"
#import "ArticleWeChatTableViewController.h"
#import "ArticleCommentViewController.h"
#import "NSString+Category.h"
#import "ProductOrderNormalDetailViewController.h"
#import "ProductOrderTicketDetailViewController.h"
#import "ProductOrderFreeDetailViewController.h"
#import "WholesaleOrderDetailViewController.h"
#import "WolesaleProductDetailViewController.h"
#import "RadishOrderDetailViewController.h"
#import "RadishProductDetailViewController.h"
#import "ActivityProductViewController.h"
#import "SeckillViewController.h"
#import "TabBarController.h"

@implementation SegueMaster

+ (UIViewController *)makeSegueWithModel:(SegueModel *)model
                          fromController:(UIViewController *)fromVC
{
    if (!model || ![model isKindOfClass:[SegueModel class]]) return nil;
    if (!fromVC || ![fromVC isKindOfClass:[UIViewController class]] || !fromVC.navigationController)return nil;
    
    __block UIViewController *toController = nil;
    [self checkLoginDestination:model.destination fromController:fromVC resultBlock:^{
        toController = [self makeSegueAfterCheckLoginWithModel:model fromController:fromVC];
    }];
    return toController;
}

+ (void)checkLoginDestination:(SegueDestination)destination
               fromController:(UIViewController *)fromVC
                  resultBlock:(void(^)())resultBlock
{
    switch (destination) {
        case SegueDestinationNone:
        case SegueDestinationH5:
        case SegueDestinationNewsRecommend:
        case SegueDestinationNewsList:
        case SegueDestinationActivity:
        case SegueDestinationLoveHouse:
        case SegueDestinationHospital:
        case SegueDestinationStrategyList:
        case SegueDestinationServiceList:
        case SegueDestinationStoreList:
        case SegueDestinationServiceDetail:
        case SegueDestinationStoreDetail:
        case SegueDestinationStrategyDetail:
        case SegueDestinationProductTicketDetail:
        case SegueDestinationProductFreeDetail:
        case SegueDestinationOrderWholesaleDetail:
        case SegueDestinationProductRadishDetail:
        case SegueDestinationActivityProduct:
        case SegueDestinationActivitySeckill:
        case SegueDestinationHome:
        {
            if (resultBlock) resultBlock();
        }
            break;
        
        case SegueDestinationCouponList:
        case SegueDestinationOrderDetail:
        case SegueDestinationOrderList:
        case SegueDestinationOrderTicketDetail:
        case SegueDestinationOrderFreeDetail:
        case SegueDestinationOrderRadishDetail:
        {
            [[User shareUser] checkLoginWithTarget:fromVC resultBlock:^(NSString *uid, NSError *error) {
                if (resultBlock) resultBlock();
            }];
        }
            break;
        case SegueDestinationFlashDetail:
        case SegueDestinationColumnList:
        case SegueDestinationColumnDetail:
        case SegueDestinationArticleAlbumn:
        case SegueDestinationStrategyTag:
        case SegueDestinationArticalComment:
        {
            if (resultBlock) resultBlock();
        }
            break;
    }
}

+ (UIViewController *)makeSegueAfterCheckLoginWithModel:(SegueModel *)model
                                         fromController:(UIViewController *)fromVC
{
    UIViewController *toController = nil;
    switch (model.destination) {
        case SegueDestinationNone:
        {
            
        }
            break;
        case SegueDestinationH5:
        {
            WebViewController *controller = [[WebViewController alloc] init];
            controller.urlString = [model.segueParam objectForKey:kSegueParameterKeyLinkUrl];
            toController = controller;
        }
            break;
        case SegueDestinationNewsRecommend:
        {
            toController = [[ArticleWeChatTableViewController alloc]init];
        }
            break;
        case SegueDestinationNewsList:
        {
            
        }
            break;
        case SegueDestinationActivity:
        {
            toController = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
        }
            break;
        case SegueDestinationLoveHouse:
        {
            NurseryViewController *controller = [[NurseryViewController alloc]initWithNibName:@"NurseryViewController" bundle:nil];
            controller.type = NurseryTypeNursery;
            toController = controller;
        }
            break;
        case SegueDestinationHospital:
        {
            NurseryViewController *controller = [[NurseryViewController alloc]initWithNibName:@"NurseryViewController" bundle:nil];
            controller.type = NurseryTypeExhibitionHall;
            toController = controller;
        }
            break;
        case SegueDestinationStrategyList:
        {
            ParentingStrategyViewController *controller = [[ParentingStrategyViewController alloc] initWithNibName:@"ParentingStrategyViewController" bundle:nil];
            toController = controller;
        }
            break;
        case SegueDestinationServiceList:
        {
            SearchResultViewController *controller = [[SearchResultViewController alloc]init];
            [controller setSearchType:SearchTypeProduct params:model.segueParam];
            toController = controller;
        }
            break;
        case SegueDestinationStoreList:
        {
            SearchResultViewController *controller = [[SearchResultViewController alloc]init];
            [controller setSearchType:SearchTypeStore params:model.segueParam];
            toController = controller;
        }
            break;
        case SegueDestinationServiceDetail:
        {
            NSString *serviceId = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            NSString *channelId = [NSString stringWithFormat:@"%@", model.segueParam[@"cid"]];
            channelId = [channelId isNotNull]?channelId:@"0";
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:serviceId channelId:channelId];
            controller.type = ProductDetailTypeNormal;
            toController = controller;
        }
            break;
        case SegueDestinationStoreDetail:
        {
            NSString *storeId = [NSString stringWithFormat:@"%@", model.segueParam[@"sid"]];
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:storeId];
            toController = controller;
        }
            break;
        case SegueDestinationStrategyDetail:
        {
            NSString *strategyId = [NSString stringWithFormat:@"%@", model.segueParam[@"sid"]];
            ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:strategyId];
            toController = controller;
        }
            break;
        case SegueDestinationCouponList:
        {
            toController = [[CouponListViewController alloc] init];
        }
            break;
        case SegueDestinationOrderDetail:
        {
            ProductOrderNormalDetailViewController *controller = [[ProductOrderNormalDetailViewController alloc] init];
            controller.orderId = [NSString stringWithFormat:@"%@",model.segueParam[@"sid"]];
            toController = controller;
        }
            break;
        case SegueDestinationOrderList:
        {
            ProductOrderListType type = (ProductOrderListType)[[NSString stringWithFormat:@"%@",model.segueParam[@"type"]] integerValue];
            toController = [[ProductOrderListViewController alloc] initWithType:type];
        }
            break;
        case SegueDestinationFlashDetail:
        {
            FlashDetailViewController *controller = [[FlashDetailViewController alloc] init];
            controller.pid = [NSString stringWithFormat:@"%@",model.segueParam[@"pid"]];
            toController = controller;
        }
            break;
        case SegueDestinationColumnList:
        {
            toController = [[ColumnViewController alloc]init];
        }
            break;
        case SegueDestinationColumnDetail:
        {
            ArticleColumnViewController *controller = [[ArticleColumnViewController alloc]init];
            controller.columnSysNo = [NSString stringWithFormat:@"%@",model.segueParam[@"cid"]];
            toController = controller;
        }
            break;
        case SegueDestinationArticleAlbumn:
        {
            ZPPhotoBrowserViewController *controller = [[ZPPhotoBrowserViewController alloc] init];
            controller.articleId = [NSString stringWithFormat:@"%@", [model.segueParam objectForKey:@"pid"]];
            toController = controller;
        }
            break;
            
        case SegueDestinationStrategyTag:
        {
            StrategyTagColumnTableViewController *controller = [[StrategyTagColumnTableViewController alloc]init];
            controller.tagId = [[NSString stringWithFormat:@"%@",model.segueParam[@"s"]] integerValue];
            toController = controller;
        }
            break;
        case SegueDestinationArticalComment:
        {
            ArticleCommentViewController *controller = [[ArticleCommentViewController alloc] init];
            controller.relationId = [NSString stringWithFormat:@"%@",model.segueParam[@"sysNo"]];
            toController = controller;
        }
            break;
        case SegueDestinationProductTicketDetail:
        {
            NSString *serviceId = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            NSString *channelId = [NSString stringWithFormat:@"%@", model.segueParam[@"cid"]];
            channelId = [channelId isNotNull]?channelId:@"0";
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:serviceId channelId:channelId];
            controller.type = ProductDetailTypeTicket;
            toController = controller;
        }
            break;
        case SegueDestinationProductFreeDetail:
        {
            NSString *serviceId = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            NSString *channelId = [NSString stringWithFormat:@"%@", model.segueParam[@"cid"]];
            channelId = [channelId isNotNull]?channelId:@"0";
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:serviceId channelId:channelId];
            controller.type = ProductDetailTypeFree;
            toController = controller;
        }
            break;
        case SegueDestinationOrderTicketDetail:
        {
            ProductOrderTicketDetailViewController *controller = [[ProductOrderTicketDetailViewController alloc] init];
            controller.orderId = [NSString stringWithFormat:@"%@",model.segueParam[@"sid"]];
            toController = controller;
        }
            break;
        case SegueDestinationOrderFreeDetail:
        {
            ProductOrderFreeDetailViewController *controller = [[ProductOrderFreeDetailViewController alloc] init];
            controller.orderId = [NSString stringWithFormat:@"%@",model.segueParam[@"sid"]];
            toController = controller;
        }
            break;
        case SegueDestinationOrderWholesaleDetail:
        {
            NSString *pid = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            id gidID = model.segueParam[@"gid"];
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
            
        }
            break;
        case SegueDestinationProductRadishDetail:
        {
            NSString *serviceId = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            NSString *channelId = [NSString stringWithFormat:@"%@", model.segueParam[@"cid"]];
            channelId = [channelId isNotNull]?channelId:@"0";
            RadishProductDetailViewController *controller = [[RadishProductDetailViewController alloc] init];
            controller.productId = serviceId;
            controller.channelId = channelId;
            toController = controller;
        }
            break;
        case SegueDestinationOrderRadishDetail:
        {
            RadishOrderDetailViewController *controller = [[RadishOrderDetailViewController alloc] init];
            controller.orderId = [NSString stringWithFormat:@"%@",model.segueParam[@"sid"]];
            toController = controller;
        }
            break;
        case SegueDestinationActivityProduct:
        {
            NSString *ID = [NSString stringWithFormat:@"%@", model.segueParam[@"sid"]];
            ActivityProductViewController *controller = [[ActivityProductViewController alloc] init];
            controller.ID = ID;
            toController = controller;
        }
            break;
        case SegueDestinationActivitySeckill:
        {
            toController = [[SeckillViewController alloc] init];
        }
            break;
        case SegueDestinationHome:
        {
            [[TabBarController shareTabBarController] selectIndex:0];
        }
            break;
            
    }
    if (toController && fromVC.navigationController) [fromVC.navigationController pushViewController:toController animated:YES];
    
    [self mtaJudgerWithFromVc:fromVC sugueModel:model];
    return toController;
}


+ (void)mtaJudgerWithFromVc:(UIViewController *)fromVC sugueModel:(SegueModel *)model{
    
    
}
@end
