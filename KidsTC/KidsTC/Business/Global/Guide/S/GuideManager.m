//
//  GuideManager.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "GuideManager.h"
#import "TabBarController.h"

static NSString *const kGideTypeHome = @"GideTypeHome";
static NSString *const kGideTypeArticle = @"GideTypeArticle";
static NSString *const kGideTypeOrderDetail = @"GideTypeOrderDetail";
static NSString *const kGideTypeProductDetail = @"GideTypeProductDetail";

NSString *const kHomeGuideViewControllerFinishShow = @"HomeGuideViewControllerFinishShow";
NSString *const kArticleGuideViewControllerFinishShow = @"ArticleGuideViewControllerFinishShow";
NSString *const kOrderDetailGuideViewControllerFinishShow = @"OrderDetailGuideViewControllerFinishShow";
NSString *const kProductDetailGuideViewControllerFinishShow = @"ProductDetailGuideViewControllerFinishShow";
@implementation GuideManager
singleM(GuideManager)

- (GuideModel *)modelWithType:(GuideType)type{
    GuideModel *model = nil;
    switch (type) {
        case GuideTypeHome:
        {
            model = [self homeGuideModel];
        }
            break;
        case GuideTypeArticle:
        {
            model = [self articleGuideModel];
        }
            break;
        case GuideTypeOrderDetail:
        {
            model = [self orderDetailGuideModel];
        }
            break;
        case GuideTypeProductDetail:
        {
            model = [self productDtailGuideModel];
        }
            break;
    }
    return model;
}

- (GuideModel *)homeGuideModel{
    GuideDataItem *item_0 = [GuideDataItem itemWithImageName:@"home_guid_01"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    GuideDataItem *item_1 = [GuideDataItem itemWithImageName:@"home_guid_02"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    return [GuideModel modelWithDatas:@[item_0,item_1]];
}

- (GuideModel *)articleGuideModel {
    GuideDataItem *item_0 = [GuideDataItem itemWithImageName:@"article-0"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    return [GuideModel modelWithDatas:@[item_0]];
}

- (GuideModel *)orderDetailGuideModel {
    GuideDataItem *item_0 = [GuideDataItem itemWithImageName:@"orderDetail-0"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    return [GuideModel modelWithDatas:@[item_0]];
}

- (GuideModel *)productDtailGuideModel {
    GuideDataItem *item_0 = [GuideDataItem itemWithImageName:@"productDetail_guid_01"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    GuideDataItem *item_1 = [GuideDataItem itemWithImageName:@"productDetail_guid_02"
                                                  btnCanShow:NO
                                                btnImageName:nil
                                                    btnFrame:CGRectZero];
    return [GuideModel modelWithDatas:@[item_0,item_1]];
}

- (void)checkGuideWithTarget:(UIViewController *)target
                        type:(GuideType)type
                 resultBlock:(void(^)())resultBlock
{
    BOOL hasShow = [self hasShowWithType:type];
    if (!hasShow) {
        GuideViewController *controller = [[GuideViewController alloc]init];
        controller.datas = [self modelWithType:type].datas;
        controller.resultBlock = ^void(){
            if (resultBlock) resultBlock();
            [self finishShowWithType:type];
        };
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [target presentViewController:controller animated:YES completion:nil];
    }else{
        if (resultBlock) resultBlock();
        [self finishShowWithType:type];
    }
}

- (BOOL)hasShowWithType:(GuideType)type{
    BOOL hasShow = NO;
    switch (type) {
        case GuideTypeHome:
        {
            hasShow = [USERDEFAULTS boolForKey:kGideTypeHome];
        }
            break;
        case GuideTypeArticle:
        {
            hasShow = [USERDEFAULTS boolForKey:kGideTypeArticle];
        }
            break;
        case GuideTypeOrderDetail:
        {
            hasShow = [USERDEFAULTS boolForKey:kGideTypeOrderDetail];
        }
            break;
        case GuideTypeProductDetail:
        {
            hasShow = [USERDEFAULTS boolForKey:kGideTypeProductDetail];
        }
            break;
    }
    return hasShow;
}

- (void)finishShowWithType:(GuideType)type{
    switch (type) {
        case GuideTypeHome:
        {
            [USERDEFAULTS setBool:YES forKey:kGideTypeHome];
            [NotificationCenter postNotificationName:kHomeGuideViewControllerFinishShow object:nil];
        }
            break;
        case GuideTypeArticle:
        {
            [USERDEFAULTS setBool:YES forKey:kGideTypeArticle];
            [NotificationCenter postNotificationName:kArticleGuideViewControllerFinishShow object:nil];
        }
            break;
        case GuideTypeOrderDetail:
        {
            [USERDEFAULTS setBool:YES forKey:kGideTypeOrderDetail];
            [NotificationCenter postNotificationName:kOrderDetailGuideViewControllerFinishShow object:nil];
        }
            break;
        case GuideTypeProductDetail:
        {
            [USERDEFAULTS setBool:YES forKey:kGideTypeProductDetail];
            [NotificationCenter postNotificationName:kProductDetailGuideViewControllerFinishShow object:nil];
        }
            break;
    }
    [USERDEFAULTS synchronize];
}

@end
