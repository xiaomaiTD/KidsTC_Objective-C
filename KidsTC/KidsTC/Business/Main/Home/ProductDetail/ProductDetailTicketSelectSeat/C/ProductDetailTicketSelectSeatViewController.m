//
//  ProductDetailTicketSelectSeatViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatViewController.h"
#import "GHeader.h"
#import "Colours.h"
#import "NSString+Category.h"
#import "NSString+ZP.h"
#import "UIButton+Category.h"

#import "ProductDetailTicketSelectSeatModel.h"

#import "ProductDetailTicketSelectSeatCollectionViewTimeCell.h"
#import "ProductDetailTicketSelectSeatCollectionViewSeatCell.h"
#import "ProductDetailTicketSelectSeatCollectionViewHeader.h"
#import "ProductDetailTicketSelectSeatCollectionViewFooter.h"
#import "ProductDetailTicketSelectSeatCollectionViewNumFooter.h"
#import "ProductDetailTicketSelectSeatNumView.h"

#import "SettlementResultNewViewController.h"
#import "ServiceSettlementViewController.h"

static NSString *const TimeCellID   = @"TimeCell";
static NSString *const SeatCellID   = @"SeatCell";
static NSString *const HeaderId     = @"Header";
static NSString *const FooterId     = @"Footer";
static NSString *const NumFooterId  = @"NumFooter";

static CGFloat kSelectSeatMargin = 15;

@interface ProductDetailTicketSelectSeatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ProductDetailTicketSelectSeatCollectionViewNumFooterDelegate,ProductDetailTicketSelectSeatNumViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *selectDoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceTipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (nonatomic, assign) NSInteger buyCount;
@property (weak, nonatomic) IBOutlet UIView *priceBGView;
@property (weak, nonatomic) IBOutlet ProductDetailTicketSelectSeatNumView *numView;


@property (nonatomic, strong) ProductDetailTicketSelectSeatData *data;

@property (nonatomic, strong) ProductDetailTicketSelectSeatTime *selectSeatTime;
@property (nonatomic, strong) ProductDetailTicketSelectSeatSeat *selectSeatSeat;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarH;
@end

@implementation ProductDetailTicketSelectSeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_productId isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        [self back];
        return;
    }
    if (![_channelId isNotNull])_channelId=@"0";
    
    self.navigationItem.title = @"选择场次";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.HLineH.constant = LINE_H;
    
    self.naviTheme = NaviThemeWihte;
    
    self.buyCount = 0;
    
    self.numView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewTimeCell" bundle:nil] forCellWithReuseIdentifier:TimeCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewSeatCell" bundle:nil] forCellWithReuseIdentifier:SeatCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderId ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterId ];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailTicketSelectSeatCollectionViewNumFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NumFooterId ];
    
    self.priceTipL.textColor = [UIColor colorFromHexString:@"323333"];
    self.priceL.textColor = COLOR_PINK;
    self.selectDoneBtn.backgroundColor = COLOR_PINK;
    
    self.selectSeatSeat = nil;
    
    [self loadData];
}

- (void)loadData {
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_TICKET_PRODUCT_SELECT_SEAT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductDetailTicketSelectSeatData *data = [ProductDetailTicketSelectSeatModel modelWithDictionary:dic].data;
        if (data.seatTimes.count>0) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(ProductDetailTicketSelectSeatData *)data {
    self.data = data;
    [self.data.seatTimes enumerateObjectsUsingBlock:^(ProductDetailTicketSelectSeatTime *time, NSUInteger idx, BOOL *stopTime) {
        if (time.selected) {
            self.selectSeatTime = time;
            [time.seats enumerateObjectsUsingBlock:^(ProductDetailTicketSelectSeatSeat *seat, NSUInteger idx, BOOL *stopSeat) {
                if (seat.selected) {
                    self.selectSeatSeat = seat;
                    *stopSeat = YES;
                }
            }];
            *stopTime = YES;
        }
    }];
    [self.collectionView reloadData];
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"查询票务座位信息失败"] show];
    [self back];
}

- (IBAction)selectDone:(UIButton *)sender {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self addToShoppingCart];
    }];
}

- (void)addToShoppingCart {
    
    if (self.buyCount<1) {
        [[iToast makeText:@"请填写购买数量"] show];
        return;
    }
    
    ProductDetailTicketSelectSeatSeat *seat = self.selectSeatSeat;
    if (!seat) {
        [[iToast makeText:@"请选则座位"] show];
        return;
    }
    
    NSString *SkuId = seat.sku;
    if (![SkuId isNotNull]) {
        [[iToast makeText:@"您选择的座位存在问题，请选择其他座位"] show];
        return;
    }
    
    NSString *ChId = seat.chId;
    if (![ChId isNotNull]) {
        [[iToast makeText:@"您选择的座位存在问题，请选择其他座位"] show];
        return;
    }
    
    NSDictionary *skuDic = @{@"SkuId":SkuId,
                             @"ChId":ChId,
                             @"BuyNum":@(self.buyCount)};
    
    NSArray *skuAry = @[skuDic];
    
    NSString *skuStr = [NSString zp_stringWithJsonObj:skuAry];
    
    if (![skuStr isNotNull]) {
        [[iToast makeText:@"App内部出错，请重试"] show];
        return;
    }
    
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"skus":skuStr};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADD_TICKET_PRODUCT_SHOPPING_CART" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc] init];
        controller.type = ProductDetailTypeTicket;
        [self.navigationController pushViewController:controller animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"加入购物车失败，请稍后再试！"] show];
    }];
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
        return CGSizeMake(SCREEN_WIDTH, 25);
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
        return self.selectSeatTime.seats.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProductDetailTicketSelectSeatCollectionViewTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TimeCellID forIndexPath:indexPath];
        if (indexPath.row<self.data.seatTimes.count) {
            cell.time = self.data.seatTimes[indexPath.row];
        }
        return cell;
    }else{
        ProductDetailTicketSelectSeatCollectionViewSeatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SeatCellID forIndexPath:indexPath];
        NSArray<ProductDetailTicketSelectSeatSeat *> *seats = self.selectSeatTime.seats;
        if (indexPath.row<seats.count) {
            cell.seat = seats[indexPath.row];
        }
        return cell;
    }
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
            /*
            ProductDetailTicketSelectSeatCollectionViewNumFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NumFooterId forIndexPath:indexPath];
            footerView.delegate = self;
            footerView.seat = self.selectSeatSeat;
            return  footerView;
             */
            ProductDetailTicketSelectSeatCollectionViewFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterId forIndexPath:indexPath];
            return  footerView;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row<self.data.seatTimes.count) {
            self.selectSeatTime.selected = NO;
            ProductDetailTicketSelectSeatTime *time = self.data.seatTimes[row];
            time.selected = YES;
            self.selectSeatTime = time;
            [time.seats enumerateObjectsUsingBlock:^(ProductDetailTicketSelectSeatSeat *seat, NSUInteger idx, BOOL *stop) {
                if (seat.selected) {
                    self.selectSeatSeat = seat;
                    *stop = YES;
                }
            }];
        }
        [self.collectionView reloadData];
    }else{
        if (row<self.selectSeatTime.seats.count) {
            self.selectSeatSeat.selected = NO;
            ProductDetailTicketSelectSeatSeat *seat = self.selectSeatTime.seats[row];
            seat.selected = YES;
            self.selectSeatSeat = seat;
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [self.collectionView reloadSections:set];
    }
    
}

#pragma mark - ProductDetailTicketSelectSeatCollectionViewNumFooterDelegate

- (void)ProductDetailTicketSelectSeatCollectionViewNumFooter:(ProductDetailTicketSelectSeatCollectionViewNumFooter *)footer actionType:(ProductDetailNumFooterActionType)type value:(id)value {
    switch (type) {
        case ProductDetailNumFooterActionTypeBuyCountDidChange:
        {
            self.buyCount = [value integerValue];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelectSeatSeat:(ProductDetailTicketSelectSeatSeat *)selectSeatSeat {
    _selectSeatSeat = selectSeatSeat;
    self.numView.seat = selectSeatSeat;
    self.buyCount = selectSeatSeat.count;
}

- (void)setBuyCount:(NSInteger)buyCount {
    _buyCount = buyCount;
    
    self.selectDoneBtn.enabled = buyCount>0;
    self.selectDoneBtn.backgroundColor = buyCount>0?COLOR_PINK:[UIColor lightGrayColor];
    self.priceL.hidden = buyCount<1;
    self.priceTipL.hidden = buyCount<1;
    [self resetPrice];
}

- (void)resetPrice {
    ProductDetailTicketSelectSeatSeat *seat = self.selectSeatSeat;
    CGFloat totalPrice = seat.price * self.buyCount;
    self.priceL.text = [NSString stringWithFormat:@"¥%0.2f",totalPrice];
}

#pragma mark - ProductDetailTicketSelectSeatNumViewDelegate

- (void)productDetailTicketSelectSeatNumView:(ProductDetailTicketSelectSeatNumView *)view actionType:(ProductDetailTicketSeatNumActionType)type value:(id)value {
    switch (type) {
        case ProductDetailTicketSeatNumActionTypeBuyCountDidChange:
        {
            self.buyCount = [value integerValue];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - noti

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    self.toolBarH.constant = self.keyboardHeight + 49;
    [self.view layoutIfNeeded];
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    self.toolBarH.constant = 98;
    [self.view layoutIfNeeded];
}




@end
