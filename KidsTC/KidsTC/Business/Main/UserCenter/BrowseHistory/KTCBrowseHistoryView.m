//
//  KTCBrowseHistoryView.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCBrowseHistoryView.h"
#import "KTCBrowseHistoryViewServiceCell.h"
#import "KTCBrowseHistoryViewStoreCell.h"
#import "GHeader.h"
#import "UIButton+Category.h"
#import "KTCEmptyDataView.h"
#import "Colours.h"


static NSString *const kServiceCellIdentifier = @"kServiceCellIdentifier";
static NSString *const kStoreCellIdentifier = @"kStoreCellIdentifier";


static KTCBrowseHistoryView *_sharedInstance = nil;

@interface KTCBrowseHistoryView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableBGView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UINib *serviceCellNib;
@property (nonatomic, strong) UINib *storeCellNib;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableDictionary *noMoreDataDic;
@property (nonatomic, strong) NSMutableDictionary *hideFooterDic;

@property (nonatomic, assign) BOOL animationBlock;

- (IBAction)didClickedButton:(id)sender;

- (void)selectViewTag:(KTCBrowseHistoryViewTag)tag;

- (void)pullToLoadMoreData;

@end

@implementation KTCBrowseHistoryView

#pragma mark Initialization

+ (instancetype)historyView {
    static dispatch_once_t token = 0;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[[NSBundle mainBundle] loadNibNamed:@"KTCBrowseHistoryView" owner:nil options:nil] firstObject];
        [_sharedInstance buildSubviews];
    });
    
    return _sharedInstance;
}

- (void)buildSubviews {
    [self.tableBGView setBackgroundColor:COLOR_BG_CEll];
    
    self.tableView.backgroundView = nil;
    [self.tableView setBackgroundColor:COLOR_BG_CEll];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 0.01)];
    if (!self.serviceCellNib) {
        self.serviceCellNib = [UINib nibWithNibName:NSStringFromClass([KTCBrowseHistoryViewServiceCell class]) bundle:nil];
        [self.tableView registerNib:self.serviceCellNib forCellReuseIdentifier:kServiceCellIdentifier];
    }
    if (!self.storeCellNib) {
        self.storeCellNib = [UINib nibWithNibName:NSStringFromClass([KTCBrowseHistoryViewStoreCell class]) bundle:nil];
        [self.tableView registerNib:self.storeCellNib forCellReuseIdentifier:kStoreCellIdentifier];
    }

    WeakSelf(self)
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self pullToLoadMoreData];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    [mj_footer setTitle:@"上拉" forState:MJRefreshStateIdle];
    [mj_footer setTitle:@"松开" forState:MJRefreshStatePulling];
    [mj_footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = mj_footer;

    [self hideLoadMoreFooter:YES forTag:KTCBrowseHistoryViewTagService];
    [self hideLoadMoreFooter:YES forTag:KTCBrowseHistoryViewTagStore];
    //data
    self.noMoreDataDic = [[NSMutableDictionary alloc] init];
    self.hideFooterDic = [[NSMutableDictionary alloc] init];
    
    [self.activityIndicator setColor:COLOR_PINK];
    
    self.serviceButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.serviceButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.serviceButton setBackgroundColor:[UIColor colorFromHexString:@"EDEDED"] forState:UIControlStateNormal];
    [self.serviceButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.serviceButton setImage:[UIImage imageNamed:@"productDetail_history_product_unsel"] forState:UIControlStateNormal];
    [self.serviceButton setImage:[UIImage imageNamed:@"productDetail_history_product_sel"] forState:UIControlStateSelected];
    
    self.storeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.storeButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.storeButton setBackgroundColor:[UIColor colorFromHexString:@"EDEDED"] forState:UIControlStateNormal];
    [self.storeButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.storeButton setImage:[UIImage imageNamed:@"productDetail_history_store_unsel"] forState:UIControlStateNormal];
    [self.storeButton setImage:[UIImage imageNamed:@"productDetail_history_store_sel"] forState:UIControlStateSelected];
    
    [self selectViewTag:KTCBrowseHistoryViewTagService];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.tapView addGestureRecognizer:tap];
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.currentTag) {
        case KTCBrowseHistoryViewTagService:
        {
            KTCBrowseHistoryViewServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCellIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell =  [[[NSBundle mainBundle] loadNibNamed:@"KTCBrowseHistoryViewServiceCell" owner:nil options:nil] objectAtIndex:0];
            }
            [cell configWithModel:[self.dataArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case KTCBrowseHistoryViewTagStore:
        {
            KTCBrowseHistoryViewStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoreCellIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell =  [[[NSBundle mainBundle] loadNibNamed:@"KTCBrowseHistoryViewStoreCell" owner:nil options:nil] objectAtIndex:0];
            }
            [cell configWithModel:[self.dataArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(browseHistoryView:didSelectedItemAtIndex:)]) {
        [self.delegate browseHistoryView:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark Private methods

- (IBAction)didClickedButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == self.currentTag) {
        return;
    }
    [self selectViewTag:(KTCBrowseHistoryViewTag)button.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(browseHistoryView:didChangedTag:)]) {
        [self.delegate browseHistoryView:self didChangedTag:(KTCBrowseHistoryViewTag)button.tag];
    }
}

- (void)selectViewTag:(KTCBrowseHistoryViewTag)tag {
    switch (tag) {
        case KTCBrowseHistoryViewTagService:
        {
            [self.serviceButton setSelected:YES];
            [self.storeButton setSelected:NO];
        }
            break;
        case KTCBrowseHistoryViewTagStore:
        {
            [self.serviceButton setSelected:NO];
            [self.storeButton setSelected:YES];
        }
            break;
        default:
            break;
    }
    _currentTag = tag;
}

- (void)pullToLoadMoreData {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(browseHistoryView:didPulledUpToloadMoreForTag:)]) {
        [self.delegate browseHistoryView:self didPulledUpToloadMoreForTag:self.currentTag];
    }
}

#pragma mark Public methods

- (void)showInViewController:(UIViewController *)viewController {
    if (self.animationBlock || [self isShowing]) {
        return;
    }
    
    
    
    CGFloat viewWidth = SCREEN_WIDTH / 4;
    self.frame = CGRectMake(SCREEN_WIDTH + viewWidth, 0, viewController.view.frame.size.width, viewController.view.frame.size.height);
    [self setAlpha:0];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([window isKeyWindow] == NO)
    {
        [window makeKeyAndVisible];
    }
    if (window && self) {
        [window addSubview:self];
        [window layoutIfNeeded];
    }
    
    _isShowing = YES;
    
    self.animationBlock = YES;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        self.animationBlock = NO;
    }];
}

- (void)hide {
    if (self.animationBlock || ![self isShowing]) {
        return;
    }
    CGFloat viewWidth = SCREEN_WIDTH / 4;
    self.animationBlock = YES;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH + viewWidth, 0, self.frame.size.width, self.frame.size.height) ;
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _isShowing = NO;
        self.animationBlock = NO;
    }];
}

- (void)startLoadingAnimation:(BOOL)start {
    if (start) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

- (void)reloadDataForTag:(KTCBrowseHistoryViewTag)tag {
    [self selectViewTag:tag];
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(itemModelsForBrowseHistoryView:withTag:)]) {
            self.dataArray = [self.dataSource itemModelsForBrowseHistoryView:self withTag:tag];
        }
        if ([self.dataSource respondsToSelector:@selector(titleForBrowseHistoryView:withTag:)]) {
            NSString *title = [self.dataSource titleForBrowseHistoryView:self withTag:tag];
            if ([title length] == 0) {
                title = @"浏览足迹";
            }
            [self.titleLabel setText:title];
        }
    }
    [self.tableView reloadData];
    if ([self.dataArray count] == 0) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···"];
    } else {
        self.tableView.backgroundView = nil;
    }
}

- (void)endLoadMore {
    [self.tableView.mj_footer endRefreshing];
}

- (void)noMoreData:(BOOL)noMore forTag:(KTCBrowseHistoryViewTag)tag {
    [self.noMoreDataDic setObject:[NSNumber numberWithBool:noMore] forKey:[NSString stringWithFormat:@"%zd", tag]];
}

- (void)hideLoadMoreFooter:(BOOL)hidden forTag:(KTCBrowseHistoryViewTag)tag {
    [self.hideFooterDic setObject:[NSNumber numberWithBool:hidden] forKey:[NSString stringWithFormat:@"%zd", tag]];
}

+ (KTCBrowseHistoryType)typeOfViewTag:(KTCBrowseHistoryViewTag)tag {
    KTCBrowseHistoryType type = KTCBrowseHistoryTypeNone;
    switch (tag) {
        case KTCBrowseHistoryViewTagService:
        {
            type = KTCBrowseHistoryTypeService;
        }
            break;
        case KTCBrowseHistoryViewTagStore:
        {
            type = KTCBrowseHistoryTypeStore;
        }
            break;
        default:
            break;
    }
    return type;
}
@end
