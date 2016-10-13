 //
//  TCHomeBaseTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeBaseTableViewCell.h"
#import "TCHomeCollectionViewCell.h"
#import "NSString+Category.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

static NSString *const kTCHomeCollectionViewCellID = @"TCHomeCollectionViewCell";

@interface TCHomeBaseTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *bgImageView;
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
        //collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[TCHomeCollectionViewCell class] forCellWithReuseIdentifier:kTCHomeCollectionViewCellID];
        self.collectionView = collectionView;
        
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.clipsToBounds = YES;
        collectionView.backgroundView = bgImageView;
        self.bgImageView = bgImageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.bgImageView.frame = self.collectionView.bounds;
}

- (void)setFloor:(TCHomeFloor *)floor {
    _floor = floor;
    
    switch (floor.contentType) {
        case TCHomeFloorContentTypeTwinklingElf:
        {
            self.bgImageView.hidden = NO;
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:floor.bgImgUrl]];
        }
            break;
        default:
        {
            self.bgImageView.hidden = YES;
        }
            break;
    }
    
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
        cell.content = self.floor.contents[row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TCLog(@"");
    NSUInteger row = indexPath.row;
    if (row<self.floor.contents.count) {
        TCHomeFloorContent *content = self.floor.contents[row];
        if ([self.delegate respondsToSelector:@selector(tcHomeBaseTableViewCell:actionType:value:)]) {
            //[self.delegate tcHomeBaseTableViewCell:self actionType:TCHomeBaseTableViewCellActionTypeSegue value:content.segueModel];
        }
    }
}

@end
