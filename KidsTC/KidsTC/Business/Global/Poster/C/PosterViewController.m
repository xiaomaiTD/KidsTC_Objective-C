//
//  PosterViewController.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "PosterViewController.h"
#import "PosterManager.h"
#import "PosterViewCell.h"
#import "SegueMaster.h"
#import "TabBarController.h"
#import "NSDictionary+Category.h"

NSUInteger const onePageDuration = 5;

@interface PosterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL hasPassed;
@end

static NSString *const PosterViewCellID = @"PosterViewCellID";
@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
    
    [self turnPage];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)initui{
    
    self.naviTheme = NaviThemeWihte;
    
    [self initCollectionView];
    
    [self initBtn];
    
    [self initPageControl];
}

- (void)initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.scrollEnabled = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"PosterViewCell" bundle:nil] forCellWithReuseIdentifier:PosterViewCellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)initBtn{
    
    CGFloat btn_w = 60, btn_h = 30, btn_y = 20, btn_right_margin = 20;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-btn_right_margin-btn_w, btn_y, btn_w, btn_h)];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = CGRectGetHeight(btn.frame)*0.5;
    btn.layer.borderColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5].CGColor;
    btn.layer.borderWidth = LINE_H;
    [btn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    CALayer *layer = [CALayer layer];
    layer.frame = btn.frame;
    layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    layer.cornerRadius = CGRectGetHeight(layer.frame)*0.5;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 2;
    [self.view.layer insertSublayer:layer below:btn.layer];
}

- (void)initPageControl{
    CGFloat pageControl_h = 30, pageControl_bottom_margin = 8;
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-pageControl_bottom_margin-pageControl_h, SCREEN_WIDTH, pageControl_h)];
    pageControl.pageIndicatorTintColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
    pageControl.currentPageIndicatorTintColor = COLOR_PINK;
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = self.ads.count;
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)pass{
    if (!self.hasPassed) {
        [self back];
        self.hasPassed = YES;
        if (self.resultBlock) self.resultBlock();
    }
}

- (void)turnPage{
    WeakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(onePageDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        StrongSelf(self)
        if (!self.hasPassed) {
            NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].firstObject;
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item+1 inSection:currentIndexPath.section];
            if (nextIndexPath.item<self.ads.count) {
                [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                self.pageControl.currentPage = nextIndexPath.item;
                [self turnPage];
            }else{
                [self pass];
            }
        }
    });
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ads.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PosterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PosterViewCellID forIndexPath:indexPath];
    cell.item = self.ads[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    PosterAdsItem *item = self.ads[indexPath.item];
    [self pass];
    UINavigationController *navi = (UINavigationController *)[TabBarController shareTabBarController].selectedViewController;
    UIViewController *controller = navi.topViewController;
    SegueDestination segueDestination = (SegueDestination)item.linkType;
    NSDictionary *param = [NSDictionary dictionaryWithJson:item.params];
    TCLog(@"PosterViewController处理跳转：segueDestination：%zd , param:%@",segueDestination,param);
    SegueModel *segueModel = [SegueModel modelWithDestination:segueDestination paramRawData:param];
    [SegueMaster makeSegueWithModel:segueModel fromController:controller];
}


@end
