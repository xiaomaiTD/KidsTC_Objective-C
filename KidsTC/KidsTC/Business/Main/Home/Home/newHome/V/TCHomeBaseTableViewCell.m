 //
//  TCHomeBaseTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeBaseTableViewCell.h"
#import "TCHomeCollectionViewCell.h"

static NSString *const kTCHomeCollectionViewCellID = @"TCHomeCollectionViewCell";

@interface TCHomeBaseTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation TCHomeBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        //collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[TCHomeCollectionViewCell class] forCellWithReuseIdentifier:kTCHomeCollectionViewCellID];
        [self addSubview:collectionView];
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
    if ([self.collectionView respondsToSelector:@selector(setCollectionViewLayout:)]) {
        [self.collectionView setCollectionViewLayout:floor.collectionViewLayout];
    }
    //[self.collectionView reloadData];
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
