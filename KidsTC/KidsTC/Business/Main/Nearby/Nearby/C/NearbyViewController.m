//
//  NearbyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyViewController.h"

#import "NearbyCollectionViewCell.h"

#import "NavigationController.h"
#import "NearbyFilterViewController.h"

static NSString *CellID = @"NearbyCollectionViewCell";

@interface NearbyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NearbyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
}

- (IBAction)gotoCategoryAction:(UIButton *)sender {
    NearbyFilterViewController *controller = [[NearbyFilterViewController alloc] initWithNibName:@"NearbyFilterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NearbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    return cell;
}

@end
