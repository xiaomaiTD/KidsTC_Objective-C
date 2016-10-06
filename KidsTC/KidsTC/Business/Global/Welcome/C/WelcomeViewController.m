//
//  WelcomeViewController.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WelcomeViewCell.h"
#import "WelcomeManager.h"

@interface WelcomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

static NSString *const WelcomeViewCellID = @"WelcomeViewCellID";
@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
}

- (void)initui{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"WelcomeViewCell" bundle:nil] forCellWithReuseIdentifier:WelcomeViewCellID];
    [self.view addSubview:collectionView];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)back{
    [super back];
    if (self.resultBlock) self.resultBlock();
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WelcomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WelcomeViewCellID forIndexPath:indexPath];
    cell.iconImageView.image = self.images[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.item == self.images.count-1) [self back];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x - (CGRectGetWidth(scrollView.bounds)*(self.images.count-1))>40) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self back];
        });
    }
}

@end
