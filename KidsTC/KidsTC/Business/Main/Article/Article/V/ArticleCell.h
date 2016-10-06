//
//  ArticleCell.h
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArticleLayout.h"

@interface ACProductView : UIView
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, strong) AIProductsItem *productsItem;
@end


@protocol ArticleCellDelegate;
@interface ArticleCell : UITableViewCell
@property (nonatomic, weak) id<ArticleCellDelegate> delegate;
@property (nonatomic, weak) ArticleLayout *layout;
@property (nonatomic, weak) UILabel *brifContentLabel;
@property (nonatomic, weak) UIView *line;
@end


@protocol ArticleCellDelegate <NSObject>
/**
 *  点击了头部标题按钮
 *
 *  @param cell    self
 *  @param tagItem 标题按钮对应的最小item
 */
- (void)articleCell:(ArticleCell *)cell didClickOnHeadColumnTitleTagBtn:(ACTagsItem *)targetItem;
/**
 *  点击了banner
 *
 *  @param cell    self
 *  @param tagItem 
 */
- (void)articleCell:(ArticleCell *)cell didClickOnBannerItem:(AHBannersItem *)targetItem;

/**
 *  点击了头部带普通图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbumEntrysItem:(AHAlbumEntrysItem *)targetItem;

/**
 *  点击了图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbum:(ALstItem *)album index:(NSUInteger)index;
/**
 *  点击了ProductsItem
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnProductsItem:(AIProductsItem *)targetItem;

/**
 *  zpTag
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnTagsItem:(AITagsItem *)targetItem;

@end