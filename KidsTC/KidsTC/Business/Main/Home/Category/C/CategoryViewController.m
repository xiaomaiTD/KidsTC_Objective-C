//
//  CategoryViewController.m
//  KidsTC
//
//  Created by zhanping on 3/17/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryItemCell.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "CategoryDataManager.h"
#import "SearchResultViewController.h"
#import "YYKit.h"


#define Left_Right_Spacing 5.0
#define Top_Bottom_Spacing 0.0

@interface CategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) CategoryModel *model;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation CategoryViewController

NSString * const cellId = @"cellId";
NSString * const headId = @"headId";
NSString * const footId = @"footId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"分类";
    
    self.model = [CategoryDataManager shareCategoryDataManager].model;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    UINib *cellNib = [UINib nibWithNibName:@"CategoryItemCell" bundle:nil];
    UINib *headNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    UINib *footNib = [UINib nibWithNibName:@"FooterView" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:cellId];
    [collectionView registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId];
    [collectionView registerNib:footNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footId];
}

- (UICollectionViewFlowLayout *)layout {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = Left_Right_Spacing;
    layout.minimumLineSpacing = Top_Bottom_Spacing;
    
    CGFloat item_size = (SCREEN_WIDTH - 5*Left_Right_Spacing)/4.0;
    layout.itemSize = CGSizeMake(item_size, item_size+30);
    layout.sectionInset  = UIEdgeInsetsMake(0, Left_Right_Spacing, Top_Bottom_Spacing, Left_Right_Spacing);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置header遇到遮挡弹起
    if (kiOS9Later) layout.sectionHeadersPinToVisibleBounds = YES;
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
    layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 10);
    
    return layout;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.model.data.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    CategoryListItem *item = self.model.data[section];
    
    return item.ScondCategory.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    CategoryListItem *item = self.model.data[indexPath.section];
    NSArray *ScondCategory = item.ScondCategory;
    CategoryListItem *ScondCategory_item = ScondCategory[indexPath.row];
    cell.item = ScondCategory_item;
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headId forIndexPath:indexPath];
        CategoryListItem *item = self.self.model.data[indexPath.section];
        headerView.textLabel.text = item.Name;
        return  headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        FooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footId forIndexPath:indexPath];
        return footerView;
    }
    
    return nil;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    CategoryListItem *item = self.model.data[indexPath.section];
    NSArray<CategoryListItem *> *ScondCategory = item.ScondCategory;
    CategoryListItem *scondCategory_item = ScondCategory[indexPath.row];
#warning TODO...
    SearchResultViewController *controller = [[SearchResultViewController alloc]init];
    //[controller setSearchType:SearchTypeProduct params:scondCategory_item.search_parms];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
