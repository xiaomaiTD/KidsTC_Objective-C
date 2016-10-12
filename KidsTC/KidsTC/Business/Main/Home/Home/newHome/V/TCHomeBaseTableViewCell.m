 //
//  TCHomeBaseTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeBaseTableViewCell.h"
#import "TCHomeCollectionViewCell.h"
#import "TCHomeCollectionViewThreeLayout.h"

static NSString *const kTCHomeCollectionViewCellID = @"TCHomeCollectionViewCell";

@interface TCHomeBaseTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TCHomeBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewLayout *layout = [UICollectionViewLayout new];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:collectionView];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor blueColor];
        [collectionView registerClass:[TCHomeCollectionViewCell class] forCellWithReuseIdentifier:kTCHomeCollectionViewCellID];
        self.collectionView = collectionView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setFloor:(TCHomeFloor *)floor {
    _floor = floor;
    [self.collectionView reloadData];
    self.collectionView.collectionViewLayout = floor.collectionViewLayout;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.floor.contents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTCHomeCollectionViewCellID forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    if (row<self.floor.contents.count) {
        cell.content = self.floor.contents[indexPath.row];
    }
    
    return cell;
}

@end
