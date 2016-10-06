//
//  HomeHorizontalListCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeHorizontalListCell.h"
#import "HomeHorizontalView.h"
#import "HorizontalCollectionCell.h"
#import "Masonry.h"
#import "SegueMaster.h"
#import "HomeDataManager.h"
static NSString *const kCellIdentifier = @"kCellIdentifier";

@interface HomeHorizontalListCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) HomeHorizontalView *listView;

@end
@implementation HomeHorizontalListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.listView];
    [self setConstraint];
}

-(void)setConstraint{
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [super setFloorsItem:floorItem1];
    [self.listView reloadData];
}

#pragma mark-
#pragma mark delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!self.floorsItem.contents.count) {
        return 0;
    }
    return [self.floorsItem.contents count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    HomeItemContentItem *content = self.floorsItem.contents[indexPath.item];
    cell.contentItem = content;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[indexPath.item];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}

#pragma mark-
#pragma mark lzy
-(HomeHorizontalView *)listView{
    if (!_listView) {
        
        //layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _listView = [[HomeHorizontalView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(120, 120);
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.scrollsToTop = NO;
        _listView.dataSource = self;
        _listView.delegate = self;
        [_listView registerClass:[HorizontalCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
    }
    return _listView;
}
@end
