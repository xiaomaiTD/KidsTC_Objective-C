//
//  HomeTwinklingCell.m
//  KidsTC
//
//  Created by ling on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeTwinklingCell.h"
#import "HomeCollectionCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SegueMaster.h"
#import "HomeDataManager.h"
@interface HomeTwinklingCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *iv_bg;
@end

@implementation HomeTwinklingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self.contentView addSubview:self.iv_bg];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self setConstraints];
}

-(void)setConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.iv_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [_iv_bg sd_setImageWithURL:[NSURL URLWithString:floorsItem.bgImgUrl]];
    [super setFloorsItem:floorItem1];
    [self.collectionView reloadData];
}

#pragma mark-
#pragma mark delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.floorsItem.contents.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeItemContentItem *content = self.floorsItem.contents[indexPath.item];

    HomeCollectionCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twinkle" forIndexPath:indexPath];
    cell.contentItem = content;
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[indexPath.item];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}

#pragma mark-
#pragma mark lzy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 4, SCREEN_WIDTH / 4 + 15);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        _collectionView.scrollEnabled = NO;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:@"twinkle"];
    }
    return _collectionView;
}
-(UIImageView *)iv_bg{
    if (!_iv_bg) {
        _iv_bg = [[UIImageView alloc] init];
        _iv_bg.userInteractionEnabled = YES;
    }
    return _iv_bg;
}
@end
