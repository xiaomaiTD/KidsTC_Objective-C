//
//  ArticleHomeViewController.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeViewController.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "UIBarButtonItem+Category.h"
#import "UIButton+WebCache.h"
#import "NSString+Category.h"
#import "GuideManager.h"

#import "ArticleHomeModel.h"
#import "ArticleHomeUserInfoModel.h"

#import "ArticleHomeClassView.h"
#import "ArticleHomeTableView.h"

#import "NavigationController.h"
#import "ArticleWriteViewController.h"
#import "ArticleUserCenterViewController.h"
#import "MessageCenterViewController.h"
#import "ArticleLikeViewController.h"

#import "BuryPointManager.h"

#define PAGE_COUNT 10
#define CLASSVIEW_HEIGHT 96

@interface ArticleHomeViewController ()<ArticleHomeTableViewDelegate,ArticleHomeClassViewDelegate>
@property (nonatomic, strong) ArticleHomeTableView *tableView;
@property (nonatomic, assign) NSUInteger     page;

@property (nonatomic, weak) UIButton *headBtn;
@property (nonatomic, weak) ArticleHomeClassView *classView;
@property (nonatomic, strong) ArticleHomeClassItem *currentClassItem;

@property (nonatomic, strong) UIButton *writeItemBtn;
@end

@implementation ArticleHomeViewController

@synthesize currentClassItem = _currentClassItem;

- (void)setCurrentClassItem:(ArticleHomeClassItem *)currentClassItem {
    _currentClassItem = currentClassItem;
    if (_currentClassItem.sections.count==0) {
        [_tableView beginRefreshing];
    } else {
        _tableView.sections = _currentClassItem.sections;
        [_tableView reloadData];
    }
}

- (ArticleHomeClassItem *)currentClassItem {
    if (!_currentClassItem) {
        _currentClassItem = [ArticleHomeClassItem new];
    }
    return _currentClassItem;
}

- (ArticleHomeClassView *)classView {
    if (!_classView) {
        ArticleHomeClassView *classView = [[NSBundle mainBundle] loadNibNamed:@"ArticleHomeClassView" owner:self options:nil].firstObject;
        classView.delegate = self;
        classView.frame = CGRectMake(0, 64, SCREEN_WIDTH, CLASSVIEW_HEIGHT);
        [self.view addSubview:classView];
        _classView = classView;
    }
    return _classView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10701;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNaviItems];
    
    [self setupTableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadUserInfo];
    [NotificationCenter postNotificationName:kZPTagViewWillAppearNotification object:nil];
}

- (void)loadUserInfo {
    [Request startWithName:@"GET_USER_BASE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ArticleHomeUserInfoModel *model = [ArticleHomeUserInfoModel modelWithDictionary:dic];
        [self.headBtn sd_setImageWithURL:[NSURL URLWithString:model.data.headUrl] forState:UIControlStateNormal placeholderImage:self.headBtnPlaceHolder];
    } failure:nil];
}

- (void)setupNaviItems {
    UIBarButtonItem *headItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(headItemAction) andGetButton:^(UIButton *btn) {
        btn.bounds = CGRectMake(0, 0, 30, 30);
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [btn setImage:self.headBtnPlaceHolder forState:UIControlStateNormal];
        btn.layer.cornerRadius = CGRectGetWidth(btn.frame)*0.5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = LINE_H;
        self.headBtn = btn;
    }];
    UIBarButtonItem *writeItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(writeItemAction) andGetButton:^(UIButton *btn) {
        _writeItemBtn = btn;
        btn.hidden = YES;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"article_write"] forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 80, 20);
    }];
    self.navigationItem.leftBarButtonItems = @[headItem,writeItem];
    
    UIBarButtonItem *likeItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(likeItemAction) andGetButton:^(UIButton *btn) {
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"article_like"] forState:UIControlStateNormal];
    }];
    UIBarButtonItem *messageItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(messageItemAction) andGetButton:^(UIButton *btn) {
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"article_message"] forState:UIControlStateNormal];
    }];
    self.navigationItem.rightBarButtonItems = @[messageItem,likeItem];
}

- (UIImage *)headBtnPlaceHolder {
    NSString *placeHolderName = ([User shareUser].role.sex==RoleSexFemale)?@"userCenter_header_boy":@"userCenter_header_girl";
    return [UIImage imageNamed:placeHolderName];
}

- (void)headItemAction {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ArticleUserCenterViewController *controller = [[ArticleUserCenterViewController alloc]init];
        controller.userId = [User shareUser].uid;
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [BuryPointManager trackEvent:@"event_skip_news_usrcenter" actionId:20904 params:nil];
}

- (void)writeItemAction {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        NSMutableArray<ArticleHomeClassItem *> *ary = [NSMutableArray array];
        [_classView.clazz.classes enumerateObjectsUsingBlock:^(ArticleHomeClassItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.ID isNotNull] && ![@"0" isEqualToString:obj.ID]) {
                ArticleHomeClassItem *item = obj.copy;
                [ary addObject:item];
                item.selected = ary.count==1;
            }
        }];
        if (ary.count>0) {
            ArticleWriteViewController *controller = [[ArticleWriteViewController alloc] init];
            controller.classes = ary;
            NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:YES completion:nil];
        }else{
            [[iToast makeText:@"暂时不支持投稿哟~"] show];
        }
    }];
    
    [BuryPointManager trackEvent:@"event_skip_share_mood" actionId:20901 params:nil];
}

- (void)likeItemAction {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ArticleLikeViewController *controller = [[ArticleLikeViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [BuryPointManager trackEvent:@"event_skip_news_favor" actionId:20906 params:nil];
}

- (void)messageItemAction {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        MessageCenterViewController *controller = [[MessageCenterViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [BuryPointManager trackEvent:@"event_skip_news_message" actionId:20907 params:nil];
}

#pragma mark - ArticleHomeClassViewDelegate

- (void)articleHomeClassView:(ArticleHomeClassView *)view didSelectItem:(ArticleHomeClassItem *)item {
    self.currentClassItem = item;
}

- (void)setupTableView {
    ArticleHomeTableView *tableView = [[ArticleHomeTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-(64+49))];
    tableView.cDelegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView beginRefreshing];
}

#pragma mark - ArticleHomeTableViewDelegate

- (void)articleHomeTableView:(ArticleHomeTableView *)tableView actionType:(ArticleHomeTableViewActionType)type value:(id)value {
    switch (type) {
        case ArticleHomeTableViewActionTypeLoadData:
        {
            [self loadDataRefresh:[value boolValue]];
        }
            break;
        case ArticleHomeTableViewActionTypeMakeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        default:break;
    }
}

#pragma mark ArticleHomeTableViewDelegate helper

- (void)loadDataRefresh:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSString *classId = [_currentClassItem.ID isNotNull]?_currentClassItem.ID:@"";
    NSDictionary *param = @{@"page":@(self.page),@"pageCount":@(PAGE_COUNT),@"articleClass":classId};
    [Request startWithName:@"GET_ARTICLE_HOME_PAGE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccessRefresh:refresh model:[ArticleHomeModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(ArticleHomeModel *)model{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray<NSArray<ArticleHomeItem *> *> *sections = model.data.sections;
        if (refresh) {
            self.currentClassItem.sections = [NSArray arrayWithArray:sections];
        }else{
            NSMutableArray *mutableSections = [NSMutableArray arrayWithArray:self.currentClassItem.sections];
            [mutableSections addObjectsFromArray:sections];
            self.currentClassItem.sections = [NSArray arrayWithArray:mutableSections];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh && (![_currentClassItem.ID isNotNull])) {
                self.classView.clazz = model.data.clazz;
            }
            [self dealWithLoadResult];
            if (sections.count<PAGE_COUNT) [self.tableView noMoreData];
        });
    });
}

- (void)loadDataFailure{
    [self dealWithLoadResult];
    [self.tableView noMoreData];
}

- (void)dealWithLoadResult{
    
    BOOL hasClass = self.classView.clazz.classes.count>0;
    
    _writeItemBtn.hidden = !hasClass;
    
    _classView.hidden = !hasClass;
    
    if (hasClass) {
        [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeArticle resultBlock:nil];
    }
    
    CGFloat effectHeight = self.classView.clazz.classes.count>0?CLASSVIEW_HEIGHT:0;
    _tableView.frame = CGRectMake(0, 64+effectHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(64+effectHeight+49));
    
    _tableView.sections = _currentClassItem.sections;
    [_tableView endRefresh];
    [_tableView reloadData];
}


@end
