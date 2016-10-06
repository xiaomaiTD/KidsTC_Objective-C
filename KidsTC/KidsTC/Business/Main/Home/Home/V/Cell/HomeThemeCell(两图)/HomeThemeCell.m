//
//  HomeThemeCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeThemeCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ActivityCollectionCell.h"
#import "HotActivityLayout.h"
#import "SegueMaster.h"
#import "HomeDataManager.h"
#import "Macro.h"

#define SectionNumber (2)
@interface HomeThemeCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HotActivityLayout *layout;


@end
@implementation HomeThemeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    [self.contentView addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark Public Methods

- (void)reloadData {
    //[self.collectionView.collectionViewLayout invalidateLayout];
//    [self.collectionView reloadData];
    //[self sizeToFit];
}
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    [super setFloorsItem:floorItem1];
    _layout.ratio = floorsItem.ratio.floatValue;
    _layout.centerSeparation = floorsItem.centerSeparation;
    _layout.bottomSeparation = floorsItem.bottomSeparation;
    [self reloadData];
}


#pragma mark UICollectionViewDataSource & UICollectionViewDelegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return SectionNumber;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *dataArr = self.floorsItem.contents;
    NSUInteger number = 0;
    NSUInteger totalNumber = [dataArr count];
    NSUInteger leftNumber = totalNumber % SectionNumber;
    BOOL hasLeft = NO;
    if (leftNumber > section) {
        hasLeft = YES;
        leftNumber = 1;
    } else {
        leftNumber = 0;
    }
    number = (totalNumber / SectionNumber) + leftNumber;
    return number;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = indexPath.section * SectionNumber + indexPath.item;
    HomeItemContentItem *content = self.floorsItem.contents[index];
    ActivityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"activity" forIndexPath:indexPath];
    [cell.iv_activity sd_setImageWithURL:[NSURL URLWithString:content.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.section * SectionNumber + indexPath.item;
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[index];
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
}


#pragma mark-
#pragma mark lzy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        self.layout = [[HotActivityLayout alloc] init];
        //self.layout.estimatedItemSize = CGSizeMake(100, 100);
       _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:_layout];
        [_collectionView registerClass:[ActivityCollectionCell class] forCellWithReuseIdentifier:@"activity"];
        _collectionView.backgroundColor = COLOR_BG;
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
    }
    return _collectionView;
}

@end
