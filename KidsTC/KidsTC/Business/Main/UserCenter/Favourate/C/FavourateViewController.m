//
//  FavourateViewController.m
//  KidsTC
//
//  Created by 钱烨 on 7/18/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "FavourateViewController.h"
#import "FavourateViewModel.h"
#import "ProductDetailViewController.h"
#import "StoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
//#import "WebViewController.h"  //原接入点在点击事件的 FavourateViewSegmentTagNews处现为segue跳转
#import "SegueMaster.h"
#import "ArticleColumnViewController.h"
#import "NSString+Category.h"

@interface FavourateViewController () <FavourateViewDelegate>
@property (weak, nonatomic) IBOutlet FavourateView *favourateView;
@property (nonatomic, strong) FavourateViewModel *viewModel;
@end

@implementation FavourateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    self.pageId = 10911;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.favourateView.delegate = self;
    
    self.viewModel = [[FavourateViewModel alloc] initWithView:self.favourateView];
    [self.favourateView startRefreshWithTag:FavourateViewSegmentTagService];
}

#pragma mark FavourateViewDelegate
- (void)favourateView:(FavourateView *)favourateView didChangedSegmentSelectedIndexWithTag:(FavourateViewSegmentTag)tag {
    [self.viewModel resetResultWithFavouratedTag:tag];
}

- (void)favourateView:(FavourateView *)favourateView didSelectedAtIndex:(NSUInteger)index ofTag:(FavourateViewSegmentTag)tag {
    NSArray *array = [self.viewModel resultWithFavouratedTag:tag];
    switch (tag) {
        case FavourateViewSegmentTagService:
        {
            FavouriteServiceItemModel *model = [array objectAtIndex:index];
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:model.identifier channelId:model.channelId];
            controller.type = model.productRedirect;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FavourateViewSegmentTagStore:
        {
            FavouriteStoreItemModel *model = [array objectAtIndex:index];
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:model.identifier];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FavourateViewSegmentTagStrategy:
        {
            FavouriteStrategyItemModel *model = [array objectAtIndex:index];
            ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.identifier];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FavourateViewSegmentTagNews:
        {
            ArticleLayout *layout = array[index];
            
            ALstItem *item = layout.item;
            if (item.linkType) {
                SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)item.linkType paramRawData:item.params];
                [SegueMaster makeSegueWithModel:segue fromController:self];
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)favourateView:(FavourateView *)favourateView needUpdateDataForTag:(FavourateViewSegmentTag)tag {
    [self.viewModel startUpdateDataWithFavouratedTag:tag];
}

- (void)favourateView:(FavourateView *)favourateView needLoadMoreDataForTag:(FavourateViewSegmentTag)tag {
    [self.viewModel getMoreDataWithFavouratedTag:tag];
}

- (void)favourateView:(FavourateView *)favourateView didDeleteIndex:(NSUInteger)index ofTag:(FavourateViewSegmentTag)tag {
    
    [self.viewModel deleteFavourateDataForTag:tag atInde:index];
}

- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnProductsItem:(AIProductsItem *)targetItem{}
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnBannerItem:(AHBannersItem *)targetItem{}
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnTagsItem:(AITagsItem *)targetItem{}
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnHeadColumnTitleTagBtn:(ACTagsItem *)targetItem{}
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnAlbum:(ALstItem *)album index:(NSUInteger)index{}
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnAlbumEntrysItem:(AHAlbumEntrysItem *)targetItem{}

#pragma mark - ArticleCellDelegate
/**
 *  点击了头部标题按钮
 *
 *  @param cell    self
 *  @param tagItem 标题按钮对应的最小item
 */
- (void)articleCell:(ArticleCell *)cell didClickOnHeadColumnTitleTagBtn:(ACTagsItem *)targetItem{
    NSString *ID = targetItem.ID;
    if ([@"0" isEqualToString:ID]) {
        SegueModel *segue = [SegueModel modelWithDestination:SegueDestinationColumnList];
        [SegueMaster makeSegueWithModel:segue fromController:self];
    }else{
        ArticleColumnViewController *cdVC = [[ArticleColumnViewController alloc]init];
        cdVC.columnSysNo = ID;
        cdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cdVC animated:YES];
    }
}
/**
 *  点击了banner
 *
 *  @param cell    self
 *  @param tagItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnBannerItem:(AHBannersItem *)targetItem{
    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)targetItem.linkType paramRawData:targetItem.params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}

/**
 *  点击了头部带普通图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbumEntrysItem:(AHAlbumEntrysItem *)targetItem{
    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)targetItem.linkType paramRawData:targetItem.params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}

/**
 *  点击了图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbum:(ALstItem *)album index:(NSUInteger)index{
    if (album.linkType) {
        SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)album.linkType paramRawData:album.params];
        [SegueMaster makeSegueWithModel:segue fromController:self];
    }
}
/**
 *  点击了ProductsItem
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnProductsItem:(AIProductsItem *)targetItem{
    NSString *pid = [targetItem.pid isNotNull]?targetItem.pid:@"";
    NSDictionary *params = @{@"pid":pid};
    SegueModel *segue = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}

/**
 *  zpTag
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnTagsItem:(AITagsItem *)targetItem{
    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)targetItem.linkType paramRawData:targetItem.params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}




@end
