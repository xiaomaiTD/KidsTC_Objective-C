//
//  ProductDetailTicketSelectSeatViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatViewController.h"
#import "GHeader.h"

#import "ProductDetailTicketSelectSeatModel.h"

#import "ProductDetailTicketSelectSeatCollectionViewCell.h"
#import "ProductDetailTicketSelectSeatCollectionViewHeader.h"
#import "ProductDetailTicketSelectSeatCollectionViewFooter.h"
#import "ProductDetailTicketSelectSeatCollectionViewNumFooter.h"

#import "SettlementResultNewViewController.h"

static NSString *const ID = @"ProductDetailTicketSelectSeatCollectionViewCell";
static NSString *const HeaderId = @"ProductDetailTicketSelectSeatCollectionViewHeader";
static NSString *const FooterId = @"ProductDetailTicketSelectSeatCollectionViewFooter";
static NSString *const NumFooterId = @"ProductDetailTicketSelectSeatCollectionViewNumFooter";

static CGFloat kSelectSeatMargin = 15;

@interface ProductDetailTicketSelectSeatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *selectDoneBtn;
@property (nonatomic, strong) ProductDetailTicketSelectSeatData *data;
@property (nonatomic, assign) NSInteger selectIndex;;
@end

@implementation ProductDetailTicketSelectSeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择场次";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.naviTheme = NaviThemeWihte;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderId ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterId ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewNumFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NumFooterId ];
    self.selectDoneBtn.backgroundColor = COLOR_PINK;
    
    [self loadData];
}

- (void)loadData {
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId};
    [Request startWithName:@"GET_TICKET_PRODUCT_SELECT_SEAT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailTicketSelectSeatData *data = [ProductDetailTicketSelectSeatModel modelWithDictionary:dic].data;
        if (data.seatTimes.count>0) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(ProductDetailTicketSelectSeatData *)data {
    self.data = data;
    [self.collectionView reloadData];
}

- (void)loadDataFailure:(NSError *)error {
    
}

- (IBAction)selectDone:(UIButton *)sender {
    SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc] initWithNibName:@"SettlementResultNewViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kSelectSeatMargin, 0, kSelectSeatMargin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (SCREEN_WIDTH - kSelectSeatMargin * 4) / 3;
    CGFloat h = w * 0.65;
    return CGSizeMake(w, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSelectSeatMargin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSelectSeatMargin;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 49);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 25);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 84);
    }
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return self.data.seatTimes.count;
    }else{
        return self.data.seatTimes[self.selectIndex].seats.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailTicketSelectSeatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        ProductDetailTicketSelectSeatCollectionViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.title = @"选择时间";
        }else {
            headerView.title = @"选择套餐";
        }
        return  headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            ProductDetailTicketSelectSeatCollectionViewFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterId forIndexPath:indexPath];
            return  footerView;
        }else{
            ProductDetailTicketSelectSeatCollectionViewNumFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NumFooterId forIndexPath:indexPath];
            return  footerView;
        }
    }
    return nil;
}

@end
