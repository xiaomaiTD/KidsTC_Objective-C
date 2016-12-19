//
//  ProductDetailAddressSelStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressSelStoreViewController.h"
#import "ProductDetailAddressSelStoreCell.h"
#import "ProductDetailAddressSelPlaceCell.h"

static NSString *const StoreCellID = @"ProductDetailAddressSelStoreCell";
static NSString *const PlaceCellID = @"ProductDetailAddressSelPlaceCell";

static CGFloat const kAnimateDuration =  0.2;

@interface ProductDetailAddressSelStoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ProductDetailAddressSelStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT * 0.7, SCREEN_WIDTH, SCREEN_HEIGHT * 0.7)
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"ProductDetailAddressSelStoreCell" bundle:nil] forCellReuseIdentifier:StoreCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductDetailAddressSelPlaceCell" bundle:nil] forCellReuseIdentifier:PlaceCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (void)show {
    CGRect frame = self.tableView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.tableView.frame = frame;
    frame.origin.y = SCREEN_HEIGHT - CGRectGetHeight(frame);
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.tableView.frame = frame;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
}

- (void)hide {
    CGRect frame = self.tableView.frame;
    frame.origin.y = SCREEN_HEIGHT - CGRectGetHeight(frame);
    self.tableView.frame = frame;
    frame.origin.y = SCREEN_HEIGHT;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.tableView.frame = frame;
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_placeType) {
        case PlaceTypeStore:
        {
            ProductDetailAddressSelStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:StoreCellID];
            NSInteger row = indexPath.row;
            if (row<self.places.count) {
                cell.place = self.places[indexPath.row];
            }
            return cell;
        }
            break;
        case PlaceTypePlace:
        {
            ProductDetailAddressSelPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceCellID];
            NSInteger row = indexPath.row;
            if (row<self.places.count) {
                cell.place = self.places[indexPath.row];
            }
            return cell;
        }
            break;
        default:
        {
            return [UITableViewCell new];
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(productDetailAddressSelStoreViewController:didSelectIndex:)]) {
        [self.delegate productDetailAddressSelStoreViewController:self didSelectIndex:indexPath.row];
    }
    [self hide];
}

@end
