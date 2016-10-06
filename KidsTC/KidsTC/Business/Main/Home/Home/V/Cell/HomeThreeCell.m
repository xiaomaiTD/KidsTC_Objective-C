//
//  HomeThreeCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeThreeCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "HomeDataManager.h"
#import "SegueMaster.h"
@interface HomeThreeCell ()

@property (nonatomic, strong) UIImageView *iv_big;
@property (nonatomic, strong) UIImageView *iv_top;
@property (nonatomic, strong) UIImageView *iv_btm;

- (void)didClickedOnImage:(id)sender;
@end

@implementation HomeThreeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.iv_big];
    [self.contentView addSubview:self.iv_top];
    [self.contentView addSubview:self.iv_btm];
    [self setConstraint];
}

-(void)setConstraint{
    
    [self.iv_big mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self.iv_top.mas_left).offset(-10);
        make.width.equalTo(self.iv_top);
    }];
    [self.iv_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iv_big);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self.iv_big.mas_right).offset(10);
        make.height.equalTo(self.iv_btm);
        make.bottom.equalTo(self.iv_btm.mas_top).offset(-5);
    }];
    [self.iv_btm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.iv_top);
        make.bottom.equalTo(self.iv_big);
    }];
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    
    HomeFloorsItem *floorItem1 = floorsItem;
    [self.iv_big sd_setImageWithURL:[NSURL URLWithString:floorsItem.contents.firstObject.imageUrl]];
    [self.iv_top sd_setImageWithURL:[NSURL URLWithString:floorsItem.contents[1].imageUrl]];
    [self.iv_btm sd_setImageWithURL:[NSURL URLWithString:floorsItem.contents.lastObject.imageUrl]];
    [super setFloorsItem:floorItem1];
}
- (void)didClickedOnImage:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[tap.view.tag];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}
#pragma mark-
#pragma mark lzy
-(UIImageView *)iv_big{
    if (!_iv_big) {
        _iv_big = [[UIImageView alloc] init];
        _iv_big.userInteractionEnabled = YES;
        _iv_big.tag = 0;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedOnImage:)];
        [_iv_big addGestureRecognizer:tap1];
    }
    return _iv_big;
}
-(UIImageView *)iv_top{
    if (!_iv_top) {
        _iv_top = [[UIImageView alloc] init];
        _iv_top.userInteractionEnabled = YES;
        _iv_top.tag = 1;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedOnImage:)];
        [_iv_top addGestureRecognizer:tap2];
    }
    return _iv_top;
}
-(UIImageView *)iv_btm{
    if (!_iv_btm) {
        _iv_btm = [[UIImageView alloc] init];
        _iv_btm.userInteractionEnabled = YES;
        _iv_btm.tag = 2;
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedOnImage:)];
        [_iv_btm addGestureRecognizer:tap3];
    }
    return _iv_btm;
}
@end
