//
//  MyCommentListViewController.m
//  KidsTC
//
//  Created by Altair on 12/1/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "MyCommentListViewController.h"
#import "MyCommentListViewModel.h"
#import "MWPhotoBrowser.h"
#import "ProductDetailViewController.h"
#import "TCStoreDetailViewController.h"
#import "WebViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "CommentEditViewController.h"
#import "TCProgressHUD.h"
#import "iToast.h"
@interface MyCommentListViewController () <MyCommentListViewDelegate, CommentEditViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MyCommentListView *listView;

@property (nonatomic, strong) MyCommentListViewModel *viewModel;

@property (nonatomic, strong) MWPhotoBrowser *photoBrowser;

@property (nonatomic, strong) KTCCommentManager *commentManager;

@end

@implementation MyCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的评价";
    // Do any additional setup after loading the view from its nib.
    self.listView.delegate = self;
    
    self.viewModel = [[MyCommentListViewModel alloc] initWithView:self.listView];
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

#pragma mark MyCommentListViewDelegate

- (void)didPullDownToRefreshForCommentListView:(MyCommentListView *)view {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)didPullUpToLoadMoreForCommentListView:(MyCommentListView *)view {
    [self.viewModel getMoreDataWithSucceed:nil failure:nil];
}

- (void)commentListView:(MyCommentListView *)view didClickedAtIndex:(NSUInteger)index {
    MyCommentListItemModel *model = [[self.viewModel resultArray] objectAtIndex:index];
    switch (model.relationType) {
        case CommentRelationTypeNews:
        {
            if ([model.linkUrl length] > 0) {
                WebViewController *controller = [[WebViewController alloc] init];
                controller.urlString = model.linkUrl;
                [self.navigationController pushViewController:controller animated:YES];
            }
            return;
        }
            break;
        case CommentRelationTypeStore:
        {
            if ([model.relationIdentifier length] > 0) {
                TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
                controller.storeId = model.relationIdentifier;
                
                [self.navigationController pushViewController:controller animated:YES];
            }
            return;
        }
            break;
        case CommentRelationTypeStrategy:
        {
            if ([model.relationIdentifier length] > 0) {
                ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.relationIdentifier];
                [self.navigationController pushViewController:controller animated:YES];
            }
            return;
        }
            break;
        case CommentRelationTypeStrategyDetail:
        {
            if ([model.strategyIdentifier length] > 0) {
                ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.strategyIdentifier];
                [self.navigationController pushViewController:controller animated:YES];
            }
            return;
        }
            break;
        default:
        {
            if ([model.relationIdentifier length] > 0) {
                ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:model.relationIdentifier channelId:@"0"];
                controller.type = model.productRedirect;
                [self.navigationController pushViewController:controller animated:YES];
            }
            return;
        }
            break;
    }
}

- (void)commentListView:(MyCommentListView *)listView didClickedImageAtCellIndex:(NSUInteger)cellIndex andImageIndex:(NSUInteger)imageIndex {
    MyCommentListItemModel *model = [[self.viewModel resultArray] objectAtIndex:cellIndex];
    self.photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:model.photosArray];
    [self.photoBrowser setCurrentPhotoIndex:imageIndex];
    [self presentViewController:self.photoBrowser animated:YES completion:nil];
}

- (void)commentListView:(MyCommentListView *)view didClickedEditAtIndex:(NSUInteger)index {
    MyCommentListItemModel *model = [[self.viewModel resultArray] objectAtIndex:index];
    CommentEditViewController *controller = [[CommentEditViewController alloc] initWithMyCommentItem:model];
    controller.delegate = self;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)commentListView:(MyCommentListView *)view didClickedDeleteAtIndex:(NSUInteger)index {
    MyCommentListItemModel *model = [[self.viewModel resultArray] objectAtIndex:index];
    if (!self.commentManager) {
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要删除这条评论么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TCProgressHUD showSVP];
        [self.commentManager deleteUserCommentWithRelationIdentifier:model.relationIdentifier commentIdentifier:model.commentIdentifier relationType:model.relationType succeed:^(NSDictionary *data) {
            [TCProgressHUD dismissSVP];
            [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"";
            if (error.userInfo) {
                errMsg = [error.userInfo objectForKey:@"data"];
            }
            if ([errMsg length] == 0) {
                errMsg = @"删除失败";
            }
            [[iToast makeText:errMsg] show];
        }];
    }];
    [controller addAction:cancelAction];
    [controller addAction:confirmAction];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark CommentEditViewControllerDelegate

- (void)commentEditViewControllerDidFinishSubmitComment:(CommentEditViewController *)vc {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
