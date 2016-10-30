//
//  ParentingStrategyDetailViewController.m
//  KidsTC
//
//  Created by 钱烨 on 10/9/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ParentingStrategyDetailViewController.h"
#import "ParentingStrategyDetailViewModel.h"
#import "CommentDetailViewController.h"
#import "CommonShareViewController.h"
#import "SegueMaster.h"
//#import "MapViewController.h"
#import "StrategyDetailMapViewController.h"
#import "ServiceDetailViewController.h"
#import "StrategyDetailRelatedServiceListViewController.h"
#import "StrategyDetailBottomView.h"
#import "TCProgressHUD.h"
#import "User.h"
#import "iToast.h"
#import "StoreDetialMapViewController.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"

@interface ParentingStrategyDetailViewController () <ParentingStrategyDetailViewDelegate, StrategyDetailBottomViewDelegate>

@property (weak, nonatomic) IBOutlet ParentingStrategyDetailView *detailView;
@property (weak, nonatomic) IBOutlet StrategyDetailBottomView *bottomView;

@property (nonatomic, strong) ParentingStrategyDetailViewModel *viewModel;

@property (nonatomic, copy) NSString *strategyId;

@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation ParentingStrategyDetailViewController

- (instancetype)initWithStrategyIdentifier:(NSString *)identifier {
    self = [super initWithNibName:@"ParentingStrategyDetailViewController" bundle:nil];
    if (self) {
        self.strategyId = identifier;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10803;

    [self buildRightBarItems];
    self.detailView.delegate = self;
    self.viewModel = [[ParentingStrategyDetailViewModel alloc] initWithView:self.detailView];
    [self reloadNetworkData];
    
    self.bottomView.delegate = self;
    [self.bottomView setHidden:YES];
}

#pragma mark ParentingStrategyDetailViewDelegate

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didSelectedItemAtIndex:(NSUInteger)index {
    ParentingStrategyDetailCellModel *model = [self.viewModel.detailModel.cellModels objectAtIndex:index];
    CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceStrategyDetail relationType:CommentRelationTypeStrategyDetail headerModel:model];
    [controller setRelationIdentifier:model.identifier];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didClickedLocationButtonAtIndex:(NSUInteger)index {
    ParentingStrategyDetailCellModel *model = [self.viewModel.detailModel.cellModels objectAtIndex:index];
    if (model.location) {
        StrategyDetailMapViewController *controller = [[StrategyDetailMapViewController alloc] init];
        controller.model = model;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didClickedCommentButtonAtIndex:(NSUInteger)index {
    ParentingStrategyDetailCellModel *model = [self.viewModel.detailModel.cellModels objectAtIndex:index];
    CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceStrategyDetail relationType:CommentRelationTypeStrategyDetail headerModel:model];
    [controller setRelationIdentifier:model.identifier];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didClickedRelatedInfoButtonAtIndex:(NSUInteger)index {
    ParentingStrategyDetailCellModel *model = [self.viewModel.detailModel.cellModels objectAtIndex:index];
    [SegueMaster makeSegueWithModel:model.relatedInfoModel fromController:self];
}

- (void)didClickedStoreOnParentingStrategyDetailView:(ParentingStrategyDetailView *)detailView {
    NSArray<StoreListItemModel *> *ary = self.viewModel.detailModel.relatedStoreItems;
    StoreDetialMapViewController *controller = [[StoreDetialMapViewController alloc] init];
    controller.models = ary;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedAllRelatedServiceOnParentingStrategyDetailView:(ParentingStrategyDetailView *)detailView {
    StrategyDetailRelatedServiceListViewController *controller = [[StrategyDetailRelatedServiceListViewController alloc] initWithListItemModels:self.viewModel.detailModel.relatedServices];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didClickedRelatedServiceAtIndex:(NSUInteger)index {
    StrategyDetailServiceItemModel *serviceModel = [self.viewModel.detailModel.relatedServices objectAtIndex:index];
    ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:serviceModel.serviceId channelId:serviceModel.channelId];
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)parentingStrategyDetailView:(ParentingStrategyDetailView *)detailView didSelectedLinkWithSegueModel:(SegueModel *)model {
    [SegueMaster makeSegueWithModel:model fromController:self];
}


#pragma mark StrategyDetailBottomViewDelegate


- (void)didClickedLeftButtonOnStrategyDetailBottomView:(StrategyDetailBottomView *)bottomView {
    [self didClickedCommentButton];
}

- (void)didClickedRightButtonOnStrategyDetailBottomView:(StrategyDetailBottomView *)bottomView {
    if ([self.viewModel.detailModel.relatedServices count] > 0) {
        [self.detailView scrollToRelatedServices];
    } else {
        [self didClickedShareButton];
    }
}


#pragma mark Private methods

- (void)buildRightBarItems {
    CGFloat buttonWidth = 28;
    CGFloat buttonHeight = 28;
    CGFloat buttonGap = 15;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth * 3 + buttonGap * 2, buttonHeight)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat xPosition = 0;
    //comment
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [commentButton setBackgroundColor:[UIColor clearColor]];
    [commentButton setImage:[UIImage imageNamed:@"comment_n"] forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(didClickedCommentButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:commentButton];
    //like
    xPosition += buttonWidth + buttonGap;
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [self.likeButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [self.likeButton setBackgroundColor:[UIColor clearColor]];
    [self.likeButton setImage:[UIImage imageNamed:@"icon_favor_white_border"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"like_n"] forState:UIControlStateSelected];
    [self.likeButton addTarget:self action:@selector(didClickedLikeButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.likeButton];
    //share
    xPosition += buttonWidth + buttonGap;
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [shareButton setBackgroundColor:[UIColor clearColor]];
    [shareButton setImage:[UIImage imageNamed:@"share_n"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(didClickedShareButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:shareButton];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rItem;
}

- (void)didClickedCommentButton {
    CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceStrategy relationType:CommentRelationTypeStrategy headerModel:nil];
    [controller setRelationIdentifier:self.viewModel.detailModel.identifier];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.strategyId isNotNull]) {
        [params setValue:self.strategyId forKey:@"id"];
    }
    NSString  *evaId = self.viewModel.detailModel.identifier;
    if ([evaId isNotNull]) {
        [params setValue:evaId forKey:@"evaId"];
    }
    [BuryPointManager trackEvent:@"event_result_stgy_eva" actionId:21404 params:params];
}

- (void)didClickedLikeButton {
    
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        __weak ParentingStrategyDetailViewController *weakSelf = self;
        [weakSelf.viewModel addOrRemoveFavouriteWithSucceed:^(NSDictionary *data) {
            [weakSelf.likeButton setSelected:weakSelf.viewModel.detailModel.isFavourite];
            if (weakSelf.changeLikeBtnStatusBlock) {
                weakSelf.changeLikeBtnStatusBlock();
            }
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([self.strategyId isNotNull]) {
                [params setValue:self.strategyId forKey:@"id"];
                NSInteger type = weakSelf.viewModel.detailModel.isFavourite?1:2;
                [params setValue:@(type) forKey:@"result"];
            }
            [BuryPointManager trackEvent:@"event_result_stgy_favor" actionId:21402 params:params];
        } failure:^(NSError *error) {
            if ([[error userInfo] count] > 0) {
                [[iToast makeText:[[error userInfo] objectForKey:@"data"]] show];
            }
        }];
    }];
    
}

- (void)didClickedShareButton {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.viewModel.detailModel.shareObject sourceType:KTCShareServiceTypeStrategy];
    [self presentViewController:controller animated:YES completion:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.strategyId isNotNull]) {
        [params setValue:self.strategyId forKey:@"id"];
    }
    [BuryPointManager trackEvent:@"event_result_stgy_share" actionId:21403 params:params];
}

- (void)resetBottomView {
    [self.bottomView setHidden:NO];
    if ([self.viewModel.detailModel.relatedServices count] > 0) {
        [self.bottomView.rightLabel setText:@"查看优惠服务"];
        [self.bottomView hideLeftTag:NO rightTag:NO];
    } else {
        [self.bottomView.rightLabel setText:@"分享给好友"];
        [self.bottomView hideLeftTag:NO rightTag:YES];
    }
}

#pragma mark Super method

- (void)reloadNetworkData {
    [TCProgressHUD showSVP];
    __weak ParentingStrategyDetailViewController *weakSelf = self;
    [weakSelf.viewModel startUpdateDataWithStrategyIdentifier:self.strategyId Succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        [weakSelf.likeButton setSelected:weakSelf.viewModel.detailModel.isFavourite];
        [weakSelf resetBottomView];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [weakSelf resetBottomView];
    }];
}

@end
