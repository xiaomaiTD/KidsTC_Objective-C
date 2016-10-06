//
//  HomeNoticeCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeNoticeCell.h"
#import "NoticeScrollView.h"
#import "Macro.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "HomeDataManager.h"
#import "SegueMaster.h"
@interface HomeNoticeCell ()<NoticeViewDelegate,NoticeViewDataSource>

@property (nonatomic, strong) NoticeScrollView *noticeView;
@property (nonatomic, strong) UIImageView *iv_notice;

@end

@implementation HomeNoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.noticeView];
    [self.contentView addSubview:self.iv_notice];
    self.noticeView.dataSource = self;
    self.noticeView.delegate = self;
    
    [self setConstraint];

}

-(void)setConstraint{
    [self.iv_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(10);
    }];
}

-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [super setFloorsItem:floorItem1];
    [self.iv_notice sd_setImageWithURL:[NSURL URLWithString:floorsItem.contents.firstObject.imageUrl]];
    [self.noticeView reloadData];
}
#pragma mark NoticeViewDataSource & NoticeViewDelegate

- (NSUInteger)numberOfStringsForNoticeView:(NoticeScrollView *)noticeView {
    
    return self.floorsItem.contents.count;
}

- (NSString *)noticeStringForNoticeView:(NoticeScrollView *)noticeView atIndex:(NSUInteger)index {
    HomeItemContentItem *item = self.floorsItem.contents[index];
    return item.title;
}

- (CGSize)sizeForNoticeView:(NoticeScrollView *)noticeView {
    return CGSizeMake(SCREEN_WIDTH - 70, self.floorsItem.rowHeight);
}

- (void)NoticeView:(NoticeScrollView *)noticeView didScrolledToIndex:(NSUInteger)index {
    
}

- (void)NoticeView:(NoticeScrollView *)noticeView didClickedAtIndex:(NSUInteger)index {
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[index];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}

#pragma mark-
#pragma mark lzy
-(NoticeScrollView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeScrollView alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH - 70, 50)];
        [_noticeView setEnableClicking:YES];
        [_noticeView setMaxLine:2];
        [_noticeView setPlayDirection:AUINoticeViewPlayDirectionTopToBottom];
    }
    return _noticeView;
}
-(UIImageView *)iv_notice{
    if (!_iv_notice) {
        _iv_notice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_notice"]];
    }
    return _iv_notice;
}
@end
