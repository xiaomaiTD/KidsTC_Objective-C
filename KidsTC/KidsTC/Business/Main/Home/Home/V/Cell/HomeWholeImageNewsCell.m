//
//  HomeWholeImageNewsCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeWholeImageNewsCell.h"
#import "BannerScrollView.h"
#import "UILabel+Additions.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "Masonry.h"
#import "HomeDataManager.h"
#import "SegueMaster.h"

@interface HomeWholeImageNewsCell ()<BannerScrollViewDelegate,BannerScrollViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) BannerScrollView *scrollView;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UILabel *lb_index;
@property (nonatomic, strong) UILabel *lb_title;

@end
@implementation HomeWholeImageNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;
    [self.contentView addSubview:self.bgView];
    [self setConstraint];
}

-(void)setConstraint{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.alphaView);
        make.leading.equalTo(self).offset(10);
    }];
    [self.lb_index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lb_title);
        make.width.height.equalTo(@40);
        make.leading.equalTo(self.lb_title.mas_trailing).offset(10);
        make.trailing.equalTo(self);
    }];
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@50);
        make.centerY.equalTo(self.lb_title);
    }];

}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [super setFloorsItem:floorItem1];
    [self.scrollView reloadData];
    
    NSInteger contentCount = floorsItem.contents.count;
    if (contentCount > 0) {
        HomeItemContentItem *content = floorsItem.contents.firstObject;
        _lb_title.text = content.title;
    }else{
        _lb_title.text = @"";
    }
    if (contentCount) {

        [_lb_index setHidden:NO];
        [_lb_index setText:[NSString stringWithFormat:@"1/%lu", (unsigned long)contentCount]];
    } else {
        [_lb_index setHidden:YES];
        [_lb_index setText:@""];
    }

}

#pragma mark BannerScrollViewDataSource & BannerScrollViewDelegate
- (NSUInteger)numberOfBannersOnScrollView:(BannerScrollView *)scrollView {
    return [self.floorsItem.contents count];
}

- (UIImageView *)bannerImageViewOnScrollView:(BannerScrollView *)scrollView withViewFrame:(CGRect)frame atIndex:(NSUInteger)index {
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.clipsToBounds = YES;

    HomeItemContentItem *model = self.floorsItem.contents[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    return imageView;
}

- (NSURL *)bannerImageUrlForScrollView:(BannerScrollView *)scrollView atIndex:(NSUInteger)index {
    HomeItemContentItem *model = self.floorsItem.contents[index];
    return [NSURL URLWithString:model.imageUrl];
}

- (CGFloat)heightForBannerScrollView:(BannerScrollView *)scrollView {
    return self.floorsItem.ratio.floatValue * SCREEN_WIDTH;
}

- (void)BannerScrollView:(BannerScrollView *)scrollView didScrolledToIndex:(NSUInteger)index {
    HomeItemContentItem *model = self.floorsItem.contents[index];
    [self.lb_title setText:model.title];
    [self.lb_index setText:[NSString stringWithFormat:@"%lu/%lu", (unsigned long)(index + 1), (unsigned long)[self.floorsItem.contents count]]];
}

- (void)BannerScrollView:(BannerScrollView *)scrollView didClickedAtIndex:(NSUInteger)index {
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[index];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}

#pragma mark-
#pragma mark lzy
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        [_bgView addSubview:self.scrollView];
        [_bgView addSubview:self.lb_title];
        [_bgView addSubview:self.lb_index];
        [_bgView addSubview:self.alphaView];
    }
    return _bgView;
}

-(BannerScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[BannerScrollView alloc] init];
        [_scrollView setEnableClicking:YES];
        [_scrollView setRecyclable:YES];
        [_scrollView setAutoPlayDuration:5];
        [_scrollView setShowPageIndex:NO];
    }
    return _scrollView;
}
-(UIView *)alphaView{
    if (!_alphaView) {
        _alphaView = [[UIView alloc] init];
        _alphaView.userInteractionEnabled = YES;
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
    }
    return _alphaView;
}
-(UILabel *)lb_title{
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] initWithTitle:@"标题" FontSize:17 FontColor:[UIColor whiteColor]];
    }
    return _lb_title;
}
-(UILabel *)lb_index{
    if (!_lb_index) {
        _lb_index = [[UILabel alloc] initWithTitle:@"1" FontSize:15 FontColor:[UIColor whiteColor]];
    }
    return _lb_index;
}
@end
