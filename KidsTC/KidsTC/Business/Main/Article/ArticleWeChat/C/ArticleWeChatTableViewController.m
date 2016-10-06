//
//  ArticleWeChatTableViewController.m
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleWeChatTableViewController.h"
#import "ArticleWeChatLargeCell.h"
#import "ArticleWeChatSmallCell.h"
#import "ArticleWeChatModel.h"
#import "ArticleWeChatTimeView.h"
#import "WebViewController.h"
#import "GHeader.h"

@interface ArticleWeChatTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *lastTime;
@property (nonatomic, strong) NSMutableArray<ArticleWeChatDataItem *> *ary;
@end

static NSString *const largeCellID = @"ArticleWeChatLargeCell";
static NSString *const smallCellID = @"ArticleWeChatSmallCell";
static NSString *const timeViewID = @"ArticleWeChatTimeView";

@implementation ArticleWeChatTableViewController


- (NSString *)lastTime{
    if (!_lastTime) {
        _lastTime = @"";
    }
    return _lastTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"有料头条";
    self.ary = [NSMutableArray array];
    
    [self initTableView];
}

- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"ArticleWeChatLargeCell" bundle:nil] forCellReuseIdentifier:largeCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ArticleWeChatSmallCell" bundle:nil] forCellReuseIdentifier:smallCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ArticleWeChatTimeView" bundle:nil] forHeaderFooterViewReuseIdentifier:timeViewID];
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
    [tableView.mj_header beginRefreshing];
}

- (void)getDataRefresh:(BOOL)refresh{
    NSDictionary *patameters = @{@"time":self.lastTime,
                                 @"population_type":[User shareUser].role.roleIdentifierString};
    [Request startWithName:@"ARTICLE_GET_RECOMMEND_LIST" param:patameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ArticleWeChatModel *model = [ArticleWeChatModel modelWithDictionary:dic];
        self.lastTime = model.time;
        [model.data enumerateObjectsUsingBlock:^(ArticleWeChatDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.ary insertObject:obj atIndex:0];
        }];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.ary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ArticleWeChatDataItem *dataItem = self.ary[section];
    return dataItem.item.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 200;
    }else{
        return 68;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.ary.count-1) {
        return 16;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ArticleWeChatTimeView *view = (ArticleWeChatTimeView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:timeViewID];
    view.timeLabel.text = [NSString stringWithFormat:@" %@ ",self.ary[section].lastTime];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    ArticleWeChatItem *item = nil;
    if (self.ary.count>section) {
        NSArray<ArticleWeChatItem *> *items = self.ary[section].item;
        if (items.count>row) {
             item = items[row];
        }
    }
    if (row==0) {
        ArticleWeChatLargeCell *cell = [tableView dequeueReusableCellWithIdentifier:largeCellID];
        cell.item = item;
        return cell;
    }else{
        ArticleWeChatSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:smallCellID];
        cell.item = item;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleWeChatItem *item = self.ary[indexPath.section].item[indexPath.row];
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = item.linkUrl;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 2.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 16, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            }
            else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            }
            else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            }
            else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                lineLayer.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;;
                [layer addSublayer:lineLayer];
            }
            layer.lineWidth = LINE_H;
            layer.strokeColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
            
            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
            [roundView.layer insertSublayer:layer atIndex:0];
            roundView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = roundView;
            
            CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init];
            backgroundLayer.path = layer.path;
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
            backgroundLayer.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
            [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
            selectedBackgroundView.backgroundColor = UIColor.clearColor;
            cell.selectedBackgroundView = selectedBackgroundView;
        }
    }
}


@end
