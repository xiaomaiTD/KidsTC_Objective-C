//
//  ArticleHomeClassView.m
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeClassView.h"
#import "ArticleHomeClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"

static NSString *const ID = @"ArticleHomeClassCollectionViewCellID";

@interface ArticleHomeClassView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ArticleHomeClassView

- (void)awakeFromNib{
    [super awakeFromNib];
    _collectionView.scrollsToTop = NO;
    self.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"ArticleHomeClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)setClazz:(ArticleHomeClass *)clazz {
    _clazz = clazz;
    _collectionView.backgroundColor = clazz.bgColor;
    [_collectionView reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(SCREEN_WIDTH/4, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _clazz.classes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = _clazz.classes[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeClassItem *item = [self setImageAtIndexpath:indexPath select:YES];
    if ([self.delegate respondsToSelector:@selector(articleHomeClassView:didSelectItem:)]) {
        [self.delegate articleHomeClassView:self didSelectItem:item];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setImageAtIndexpath:indexPath select:NO];
    
}

- (ArticleHomeClassItem *)setImageAtIndexpath:(NSIndexPath *)indexPath select:(BOOL)select {
    ArticleHomeClassCollectionViewCell *cell = (ArticleHomeClassCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    ArticleHomeClassItem *item = _clazz.classes[indexPath.row];
    NSString *imageName = select?item.selectedIcon:item.icon;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    return item;
}


@end
