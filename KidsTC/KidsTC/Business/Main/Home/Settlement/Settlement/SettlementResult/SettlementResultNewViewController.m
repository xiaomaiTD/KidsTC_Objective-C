//
//  SettlementResultNewViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewViewController.h"
#import "UIBarButtonItem+Category.h"

#import "SettlementResultNewCollectionHeader.h"
#import "SettlementResultNewCollectionViewCell.h"

static NSString *const cellId = @"SettlementResultNewCollectionViewCell";
static NSString *const headId = @"SettlementResultNewCollectionHeader";

static CGFloat const headH = 270;
static CGFloat const margin = 12;

@interface SettlementResultNewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SettlementResultNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报名成功";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(back) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateHighlighted];
        btn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 0);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SettlementResultNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SettlementResultNewCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, margin, margin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - margin * 3) / 2;
    CGFloat h = w * 1.47;
    return CGSizeMake(w, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, headH);
}



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SettlementResultNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        SettlementResultNewCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headId forIndexPath:indexPath];
        
        return  headerView;
    }
    return nil;
}

@end
