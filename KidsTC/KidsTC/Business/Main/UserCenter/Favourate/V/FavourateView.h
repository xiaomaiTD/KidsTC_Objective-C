//
//  FavourateView.h
//  KidsTC
//
//  Created by 钱烨 on 7/18/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "ArticleCell.h"
typedef enum {
    FavourateViewSegmentTagService,
    FavourateViewSegmentTagStore,
    FavourateViewSegmentTagStrategy,
    FavourateViewSegmentTagNews
}FavourateViewSegmentTag;

@class FavourateView;

@protocol FavourateViewDataSource <NSObject>

- (NSArray *)favourateView:(FavourateView *)favourateView itemModelsForSegmentTag:(FavourateViewSegmentTag)tag;

@end

@protocol FavourateViewDelegate <NSObject>

- (void)favourateView:(FavourateView *)favourateView didChangedSegmentSelectedIndexWithTag:(FavourateViewSegmentTag)tag;

- (void)favourateView:(FavourateView *)favourateView didSelectedAtIndex:(NSUInteger)index ofTag:(FavourateViewSegmentTag)tag;

- (void)favourateView:(FavourateView *)favourateView needUpdateDataForTag:(FavourateViewSegmentTag)tag;

- (void)favourateView:(FavourateView *)favourateView needLoadMoreDataForTag:(FavourateViewSegmentTag)tag;

- (void)favourateView:(FavourateView *)favourateView didDeleteIndex:(NSUInteger)index ofTag:(FavourateViewSegmentTag)tag;


/**
 *  点击了头部标题按钮
 *
 *  @param cell    self
 *  @param tagItem 标题按钮对应的最小item
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnHeadColumnTitleTagBtn:(ACTagsItem *)targetItem;
/**
 *  点击了banner
 *
 *  @param cell    self
 *  @param tagItem
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnBannerItem:(AHBannersItem *)targetItem;

/**
 *  点击了头部带普通图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnAlbumEntrysItem:(AHAlbumEntrysItem *)targetItem;

/**
 *  点击了图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnAlbum:(ALstItem *)album index:(NSUInteger)index;
/**
 *  点击了ProductsItem
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnProductsItem:(AIProductsItem *)targetItem;

/**
 *  zpTag
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)favourateView:(FavourateView *)favourateView articleCell:(ArticleCell *)cell didClickOnTagsItem:(AITagsItem *)targetItem;


@end

@interface FavourateView : UIView

@property (nonatomic, assign) id<FavourateViewDataSource> dataSource;
@property (nonatomic, assign) id<FavourateViewDelegate> delegate;

@property (nonatomic, readonly) NSUInteger serviceListPageSize;
@property (nonatomic, readonly) NSUInteger storeListPageSize;
@property (nonatomic, readonly) NSUInteger strategyListPageSize;
@property (nonatomic, readonly) NSUInteger newsListPageSize;

@property (nonatomic, readonly) FavourateViewSegmentTag currentTag;

- (void)reloadDataForTag:(FavourateViewSegmentTag)tag;

- (void)startRefreshWithTag:(FavourateViewSegmentTag)tag;

- (void)endRefresh;

- (void)loadMoreWithTag:(FavourateViewSegmentTag)tag;

- (void)endLoadMore;

- (void)noMoreData:(BOOL)noMore forTag:(FavourateViewSegmentTag)tag;

- (void)hideLoadMoreFooter:(BOOL)hidden ForTag:(FavourateViewSegmentTag)tag;

@end
