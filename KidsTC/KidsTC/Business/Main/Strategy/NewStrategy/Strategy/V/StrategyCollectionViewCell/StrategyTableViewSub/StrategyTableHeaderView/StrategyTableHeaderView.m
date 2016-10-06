//
//  StrategyTableHeaderView.m
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyTableHeaderView.h"
#import "StrategyAutoRollView.h"
#import "StrategyTagPicCollectionViewCell.h"
#import "Macro.h"
#define StrategyTableHeaderMargin 8

@interface StrategyTableHeaderView ()<StrategyAutoRollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@end

static NSString *ID = @"StrategyTagPicCollectionViewCellID";

@implementation StrategyTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setHeader:(StrategyShowHeader *)header{
    _header = header;
    
    CGFloat totalH = 0;
    
    NSArray<StrategyTypeListBannerItem *> *banner = header.banner;
    if (banner.count>0) {
        totalH += StrategyTableHeaderMargin;
        CGFloat w = SCREEN_WIDTH-StrategyTableHeaderMargin*2;
        CGFloat ratio = [banner firstObject].ratio;
        ratio = ratio<=0?0.4:ratio;
        CGFloat h = w * ratio;
        CGRect frame = CGRectMake(StrategyTableHeaderMargin, totalH, w, h);
        StrategyAutoRollView *autoRollView = [[StrategyAutoRollView alloc]initWithFrame:frame items:banner delegate:self];
        [self addSubview:autoRollView];
        totalH += h+StrategyTableHeaderMargin;
    }

    if (header.tagPic.count>0) {
        totalH += StrategyTableHeaderMargin;
        CGFloat itemSize = (SCREEN_WIDTH - 7*StrategyTableHeaderMargin)/3.5;
        UICollectionView *tagPicCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, totalH, SCREEN_WIDTH, itemSize) collectionViewLayout:[self tagPicCollectionViewFlowLayout]];
        tagPicCollectionView.backgroundColor = [UIColor whiteColor];
        tagPicCollectionView.contentInset = UIEdgeInsetsMake(0, StrategyTableHeaderMargin, 0, StrategyTableHeaderMargin);
        tagPicCollectionView.delegate = self;
        tagPicCollectionView.dataSource = self;
        tagPicCollectionView.showsHorizontalScrollIndicator = NO;
        tagPicCollectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:tagPicCollectionView];
        [tagPicCollectionView registerNib:[UINib nibWithNibName:@"StrategyTagPicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
        totalH += itemSize+StrategyTableHeaderMargin;
    }
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, totalH);
}


- (UICollectionViewFlowLayout *)tagPicCollectionViewFlowLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemSize = (SCREEN_WIDTH - 7*StrategyTableHeaderMargin)/3.5;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = StrategyTableHeaderMargin*2;
    
    return layout;
}


#pragma mark <StrategyAutoRollViewDelegate>

-(void)didSelectPageAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(strategyTableHeaderView:didClickBannerAtIndex:)]) {
        [self.delegate strategyTableHeaderView:self didClickBannerAtIndex:index];
    }
}

#pragma mark <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.header.tagPic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StrategyTagPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.header.tagPic[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(strategyTableHeaderView:didClickTagPicAtIndex:)]) {
        [self.delegate strategyTableHeaderView:self didClickTagPicAtIndex:indexPath.item];
    }
}

@end
