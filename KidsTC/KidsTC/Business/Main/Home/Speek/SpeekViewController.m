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
            NSString *text = value;
            [self addSearchHistoryKeywords:text searchType:SearchType_Product];
            SearchResultViewController *controller = [[SearchResultViewController alloc]init];
            controller.searchParmsModel = [self searchParmsModelWithItem:nil searchType:SearchType_Product text:text];
            controller.searchType = SearchType_Product;
            [self.navigationController pushViewController:controller animated:YES];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([text isNotNull]) {
                [params setValue:text forKey:@"key"];
            }
            [BuryPointManager trackEvent:@"event_skip_voice_serve" actionId:20302 params:params];
        }
            break;
    }
}

/**
 *  添加历史搜索关键词
 */
- (void)addSearchHistoryKeywords:(NSString *)text searchType:(SearchType)searchType {
    [[SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager] addSearchHistoryKeywords:text
                                                                                    searchType:searchType];
}

- (SearchParmsModel *)searchParmsModelWithItem:(SearchHotKeywordsListItem *)item
                                    searchType:(SearchType)searchType
                                          text:(NSString *)text
{
    SearchParmsModel *searchParmsModel = nil;
    switch (searchType) {
        case SearchType_Product:
        case SearchType_Store:
        {
            SearchParmsProductOrStoreModel *searchParmsProductOrStoreModel = nil;
            if (item) {
                SearchHotKeywordsListProductOrStoreItem *productOrStoreItem = (SearchHotKeywordsListProductOrStoreItem *)item;
                searchParmsProductOrStoreModel = productOrStoreItem.search_parms;
            }else{
                searchParmsProductOrStoreModel = [[SearchParmsProductOrStoreModel alloc]init];
                searchParmsProductOrStoreModel.k = text;
            }
            searchParmsModel = searchParmsProductOrStoreModel;
        }
            break;
        case SearchType_Article:
        {
            SearchParmsArticleModel *searchParmsArticleModel = nil;
            if (item) {
                SearchHotKeywordsListArticleItem *articleItem = (SearchHotKeywordsListArticleItem *)item;
                searchParmsArticleModel = articleItem.search_parms;
            }else{
                searchParmsArticleModel = [[SearchParmsArticleModel alloc]init];
                searchParmsArticleModel.k = text;
            }
            searchParmsModel = searchParmsArticleModel;
        }
            break;
    }
    return searchParmsModel;
}

@end
