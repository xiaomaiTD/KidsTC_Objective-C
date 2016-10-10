//
//  SegueMaster.m
//  KidsTC
//
//  Created by Altair on 12/5/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "SegueMaster.h"
#import "HomeViewController.h"
#import "WebViewController.h"
#import "ActivityViewController.h"
#import "WelfareStoreViewController.h"
#import "ParentingStrategyViewController.h"
#import "ServiceDetailViewController.h"
#import "StoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "CouponListViewController.h"
#import "ServiceOrderDetailViewController.h"
#import "OrderListViewController.h"
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
        {
            if (resultBlock) resultBlock();
        }
            break;
        
        case SegueDestinationCouponList:
        case SegueDestinationOrderDetail:
        case SegueDestinationOrderList:
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
            SearchResultViewController *controller = [[SearchResultViewController alloc]init];
            controller.searchType = SearchType_Article;
            controller.searchParmsModel = [SearchParmsArticleModel modelWithDic :model.segueParam];
            toController = controller;
        }
            break;
        case SegueDestinationActivity:
        {
            toController = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
        }
            break;
        case SegueDestinationLoveHouse:
        {
            WelfareStoreViewController *controller = [[WelfareStoreViewController alloc]init];
            controller.type = WelfareTypeLoveHouse;
            toController = controller;
        }
            break;
        case SegueDestinationHospital:
        {
            WelfareStoreViewController *controller = [[WelfareStoreViewController alloc]init];
            controller.type = WelfareTypeHospital;
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
            controller.searchType = SearchType_Product;
            controller.searchParmsModel = [SearchParmsProductOrStoreModel modelWithDic :model.segueParam];
            toController = controller;
        }
            break;
        case SegueDestinationStoreList:
        {
            SearchResultViewController *controller = [[SearchResultViewController alloc]init];
            controller.searchType = SearchType_Store;
            controller.searchParmsModel = [SearchParmsProductOrStoreModel modelWithDic:model.segueParam];
            toController = controller;
        }
            break;
        case SegueDestinationServiceDetail:
        {
            NSString *serviceId = [NSString stringWithFormat:@"%@", model.segueParam[@"pid"]];
            NSString *channelId = [NSString stringWithFormat:@"%@", model.segueParam[@"cid"]];
            channelId = [channelId isNotNull]?channelId:@"0";
            ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:serviceId channelId:channelId];
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
            CouponStatus status = (CouponStatus)[[NSString stringWithFormat:@"%@",model.segueParam[@"type"]] integerValue];
            CouponListViewTag tag = CouponListViewTagUnused;
            switch (status) {
                case CouponStatusUnused:
                {
                    tag = CouponListViewTagUnused;
                }
                    break;
                case CouponStatusHasUsed:
                {
                    tag = CouponListViewTagHasUsed;
                }
                    break;
                case CouponStatusHasOverTime:
                {
                    tag = CouponListViewTagHasOverTime;
                }
                    break;
                default:
                {
                    tag = CouponListViewTagUnused;
                }
                    break;
            }
            toController = [[CouponListViewController alloc] initWithCouponListViewTag:tag];
        }
            break;
        case SegueDestinationOrderDetail:
        {
            ServiceOrderDetailViewController *controller = [[ServiceOrderDetailViewController alloc]init];
            controller.orderId = [NSString stringWithFormat:@"%@",model.segueParam[@"sid"]];
            toController = controller;
        }
            break;
        case SegueDestinationOrderList:
        {
            OrderListType type = (OrderListType)[[NSString stringWithFormat:@"%@",model.segueParam[@"type"]] integerValue];
            toController = [[OrderListViewController alloc] initWithOrderListType:type];
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
        default:
            break;
    }
    if (toController && fromVC.navigationController) [fromVC.navigationController pushViewController:toController animated:YES];
    
    [self mtaJudgerWithFromVc:fromVC sugueModel:model];
    return toController;
}


+ (void)mtaJudgerWithFromVc:(UIViewController *)fromVC sugueModel:(SegueModel *)model{
    
    
}
@end
