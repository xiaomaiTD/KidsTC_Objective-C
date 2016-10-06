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

NSString *const kHomeGuideViewControllerFinishShow = @"HomeGuideViewControllerFinishShow";
NSString *const kArticleGuideViewControllerFinishShow = @"ArticleGuideViewControllerFinishShow";
NSString *const kOrderDetailGuideViewControllerFinishShow = @"OrderDetailGuideViewControllerFinishShow";

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
    }
    return model;
}

- (GuideModel *)homeGuideModel{
    CGFloat btn_w = 90, btn_h = 42.3;
    CGRect btn_0_frame = CGRectMake(SCREEN_WIDTH*0.22, SCREEN_HEIGHT*0.25, btn_w, btn_h);
    GuideDataItem *item_0 = [GuideDataItem itemWithImageName:@"homeGuid-0"
                                                  btnCanShow:YES
                                                btnImageName:@"homeGuidAtt-0"
                                                    btnFrame:btn_0_frame];
    
    BOOL countFour = ([TabBarController shareTabBarController].viewControllers.count) == 4;
    
    NSString *imageName_1 = countFour?@"homeGuid-1":@"homeGuid-2";
    CGFloat btn_1_frame_x = SCREEN_WIDTH * (countFour?0.45:0.5);
    
    CGRect btn_1_frame = CGRectMake(btn_1_frame_x, SCREEN_HEIGHT*0.62, btn_w, btn_h);
    GuideDataItem *item_1 = [GuideDataItem itemWithImageName:imageName_1
                                                  btnCanShow:YES
                                                btnImageName:@"homeGuidAtt-1"
                                                    btnFrame:btn_1_frame];
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
    }
    [USERDEFAULTS synchronize];
}

@end
