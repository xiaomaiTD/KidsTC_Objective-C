//
//  HomeMainCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "HomeMainCollectionCell.h"

#import "HomeTableBannerCell.h"
#import "HomeTableBaseCell.h"
#import "HomeTableBigImageTwoDescCell.h"
#import "HomeTableFiveCell.h"
#import "HomeTableHListCell.h"
#import "HomeTableIconsCell.h"
#import "HomeTableNewsLargeIconCell.h"
#import "HomeTableNewsNoIconCell.h"
#import "HomeTableNewsOneIconCell.h"
#import "HomeTableNewsThreeIconCell.h"
#import "HomeTableNoticeCell.h"
#import "HomeTableOneToFourCell.h"
#import "HomeTableRecommendCell.h"
#import "HomeTableThreeCell.h"
#import "HomeTableThreeScrollCell.h"
#import "HomeTableTwoColumnIconCell.h"
#import "HomeTableTwoColumnProductCell.h"

static NSString *const BannerCellID = @"HomeTableBannerCell";
static NSString *const BaseCellID = @"HomeTableBaseCell";
static NSString *const BigImageTwoDescCellID = @"HomeTableBigImageTwoDescCell";
static NSString *const FiveCellID = @"HomeTableFiveCell";
static NSString *const HListCellID = @"HomeTableHListCell";
static NSString *const IconsCellID = @"HomeTableIconsCell";
static NSString *const NewsLargeIconCellID = @"HomeTableNewsLargeIconCell.h";
static NSString *const NewsNoIconCellID = @"HomeTableNewsNoIconCell";
static NSString *const NewsOneIconCellID = @"HomeTableNewsOneIconCell";
static NSString *const NewsThreeIconCellID = @"HomeTableNewsThreeIconCell";
static NSString *const NoticeCellID = @"HomeTableNoticeCell";
static NSString *const OneToFourCellID = @"HomeTableOneToFourCell";
static NSString *const RecommendCellID = @"HomeTableRecommendCell";
static NSString *const ThreeCellID = @"HomeTableThreeCell";
static NSString *const ThreeScrollCellID = @"HomeTableThreeScrollCell";
static NSString *const TwoColumnIconCellID = @"HomeTableTwoColumnIconCell";
static NSString *const TwoColumnProductCellID = @"HomeTableTwoColumnProductCell";


@interface HomeMainCollectionCell ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeMainCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerCells];
}

- (void)registerCells {
    [self registerCell:@"HomeTableBannerCell" cellId:BannerCellID];
    [self registerCell:@"HomeTableBaseCell" cellId:BaseCellID];
    [self registerCell:@"HomeTableBigImageTwoDescCell" cellId:BigImageTwoDescCellID];
    [self registerCell:@"HomeTableFiveCell" cellId:FiveCellID];
    [self registerCell:@"HomeTableHListCell" cellId:HListCellID];
    [self registerCell:@"HomeTableIconsCell" cellId:IconsCellID];
    [self registerCell:@"HomeTableNewsLargeIconCell.h" cellId:NewsLargeIconCellID];
    [self registerCell:@"HomeTableNewsNoIconCell" cellId:NewsNoIconCellID];
    [self registerCell:@"HomeTableNewsOneIconCell" cellId:NewsOneIconCellID];
    [self registerCell:@"HomeTableNewsThreeIconCell" cellId:NewsThreeIconCellID];
    [self registerCell:@"HomeTableNoticeCell" cellId:NoticeCellID];
    [self registerCell:@"HomeTableOneToFourCell" cellId:OneToFourCellID];
    [self registerCell:@"HomeTableRecommendCell" cellId:RecommendCellID];
    [self registerCell:@"HomeTableThreeCell" cellId:ThreeCellID];
    [self registerCell:@"HomeTableThreeScrollCell" cellId:ThreeScrollCellID];
    [self registerCell:@"HomeTableTwoColumnIconCell" cellId:TwoColumnIconCellID];
    [self registerCell:@"HomeTableTwoColumnProductCell" cellId:TwoColumnProductCellID];
}

- (void)registerCell:(NSString *)nib cellId:(NSString *)cellId {
    [self.tableView registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:cellId];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
