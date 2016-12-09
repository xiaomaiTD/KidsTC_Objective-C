//
//  SpeekViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SpeekViewController.h"
#import "SpeekView.h"
#import "SearchHotKeywordsModel.h"
#import "SearchResultViewController.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"
#import "TabBarController.h"
#import "SearchHistoryKeywordsManager.h"
#import "UIBarButtonItem+Category.h"

@interface SpeekViewController ()<SpeekViewDelegate>
@property (nonatomic, strong) SpeekView *speekView;
@end

@implementation SpeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"语音搜索";
    
    SpeekView *speekView = [[SpeekView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    speekView.delegate = self;
    [self.view addSubview:speekView];
    self.speekView = speekView;
    [speekView start];
    
    self.showFailurePage = YES;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(back) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateHighlighted];
        btn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 0);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backBtn = btn;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.speekView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.speekView viewWillDisappear];
}

#pragma mark - SpeekViewDelegate

- (void)speekView:(SpeekView *)view actionTyp:(SpeekViewActionType)type value:(id)value {
    switch (type) {
        case SpeekViewActionTypeRecognizeSuccess:
        {
            
            if (![value isKindOfClass:[NSString class]]) return;
            NSString *text = value;
            SearchHotKeywordsItem *item = [SearchHotKeywordsItem itemWithName:text];
            __block SearchResultViewController *controller;
            UINavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
            [navi.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[SearchResultViewController class]]) {
                    controller = (SearchResultViewController *)obj;
                    *stop = YES;
                }
            }];
            if (controller) {
                [controller setSearchType:item.searchType params:item.search_parms];
                [navi popToViewController:controller animated:YES];
            }else{
                controller = [[SearchResultViewController alloc] init];
                [controller setSearchType:item.searchType params:item.search_parms];
                [navi pushViewController:controller animated:YES];
            }
            
            [[SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager] addSearchHistoryItem:item];
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([text isNotNull]) {
                [params setValue:text forKey:@"key"];
            }
            [BuryPointManager trackEvent:@"event_skip_voice_serve" actionId:20302 params:params];
        }
            break;
    }
}


@end
