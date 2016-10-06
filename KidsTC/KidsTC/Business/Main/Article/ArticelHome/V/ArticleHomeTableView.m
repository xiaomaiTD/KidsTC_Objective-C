//
//  ArticleHomeTableView.m
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeTableView.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "SegueMaster.h"
#import "KTCEmptyDataView.h"

#import "ArticleHomeBaseCell.h"
#import "ArticleHomeIconCell.h"
#import "ArticleHomeNoIconCell.h"
#import "ArticleHomeBigImgCell.h"
#import "ArticleHomeTagImgCell.h"
#import "ArticleHomeBannerCell.h"
#import "ArticleHomeVideoCell.h"
#import "ArticleHomeAlbumCell.h"
#import "ArticleHomeUserArticleCell.h"
#import "ArticleHomeColumnTitleCell.h"
#import "ArticleHomeAlbumEntrysCell.h"

static NSString *const ArticleHomeBaseCellID        = @"ArticleHomeBaseCellID";
static NSString *const ArticleHomeIconCellID        = @"ArticleHomeIconCellID";
static NSString *const ArticleHomeNoIconCellID      = @"ArticleHomeNoIconCellID";
static NSString *const ArticleHomeBigImgCellID      = @"ArticleHomeBigImgCellID";
static NSString *const ArticleHomeTagImgCellID      = @"ArticleHomeTagImgCellID";
static NSString *const ArticleHomeBannerCellID      = @"ArticleHomeBannerCellID";
static NSString *const ArticleHomeVideoCellID       = @"ArticleHomeVideoCellID";
static NSString *const ArticleHomeAlbumCellID       = @"ArticleHomeAlbumCellID";
static NSString *const ArticleHomeUserArticleCellID = @"ArticleHomeUserArticleCellID";
static NSString *const ArticleHomeColumnTitleCellID = @"ArticleHomeColumnTitleCellID";
static NSString *const ArticleHomeAlbumEntrysCellID = @"ArticleHomeAlbumEntrysCellID";

@interface ArticleHomeTableView ()<UITableViewDelegate,UITableViewDataSource,ArticleHomeBaseCellDelegate>

@end

@implementation ArticleHomeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 44.0f;
        self.rowHeight = UITableViewAutomaticDimension;
        
        [self registerCells];
        
        [self setupMJ];
    }
    return self;
}

- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (self.sections.count==0) {
        self.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
    }else self.backgroundView = nil;
}

- (void)noMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)registerCells {
    [self registerClass:[ArticleHomeBaseCell class]                                   forCellReuseIdentifier:ArticleHomeBaseCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeIconCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeIconCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeNoIconCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeNoIconCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeBigImgCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeBigImgCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeTagImgCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeTagImgCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeBannerCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeBannerCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeVideoCell" bundle:nil]       forCellReuseIdentifier:ArticleHomeVideoCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumCell" bundle:nil]       forCellReuseIdentifier:ArticleHomeAlbumCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeUserArticleCell" bundle:nil] forCellReuseIdentifier:ArticleHomeUserArticleCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeColumnTitleCell" bundle:nil] forCellReuseIdentifier:ArticleHomeColumnTitleCellID];
    [self registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumEntrysCell" bundle:nil] forCellReuseIdentifier:ArticleHomeAlbumEntrysCellID];
}

- (void)setupMJ {
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.mj_footer = mj_footer;
}

- (void)loadDataRefresh:(BOOL)refresh {
    if ([self.cDelegate respondsToSelector:@selector(articleHomeTableView:actionType:value:)]) {
        [self.cDelegate articleHomeTableView:self actionType:ArticleHomeTableViewActionTypeLoadData value:@(refresh)];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.cDelegate respondsToSelector:@selector(articleHomeTableView:actionType:value:)]) {
        [self.cDelegate articleHomeTableView:self actionType:ArticleHomeTableViewActionTypeDidScroll value:@(self.contentOffset.y)];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeItem *item = self.sections[indexPath.section][indexPath.row];
    NSString *ID = [self cellIdWtith:item.listTemplate];
    ArticleHomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ArticleHomeItem *item = self.sections[indexPath.section][indexPath.row];
    if ([self.cDelegate respondsToSelector:@selector(articleHomeTableView:actionType:value:)]) {
        [self.cDelegate articleHomeTableView:self actionType:ArticleHomeTableViewActionTypeMakeSegue value:item.segueModel];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource helper


- (NSString *)cellIdWtith:(ArticleHomeListTemplate)type {
    NSString *ID = ArticleHomeBaseCellID;
    switch (type) {
        case ArticleHomeListTemplateIcon:
        {
            ID = ArticleHomeIconCellID;
        }
            break;
        case ArticleHomeListTemplateNoIcon:
        {
            ID = ArticleHomeNoIconCellID;
        }
            break;
        case ArticleHomeListTemplateBigImg:
        {
            ID = ArticleHomeBigImgCellID;
        }
            break;
        case ArticleHomeListTemplateTagImg:
        {
            ID = ArticleHomeTagImgCellID;
        }
            break;
        case ArticleHomeListTemplateBanner:
        case ArticleHomeListTemplateHeadBanner:
        {
            ID = ArticleHomeBannerCellID;
        }
            break;
        case ArticleHomeListTemplateVideo:
        {
            ID = ArticleHomeVideoCellID;
        }
            break;
        case ArticleHomeListTemplateAlbum:
        case ArticleHomeListTemplateUserAlbum:
        {
            ID = ArticleHomeAlbumCellID;
        }
            break;
        case ArticleHomeListTemplateUserArticle:
        {
            ID = ArticleHomeUserArticleCellID;
        }
            break;
        case ArticleHomeListTemplateColumnTitle:
        {
            ID = ArticleHomeColumnTitleCellID;
        }
            break;
        case ArticleHomeListTemplateAlbumEntrys:
        {
            ID = ArticleHomeAlbumEntrysCellID;
        }
            break;
        default:
        {
            ID = ArticleHomeBaseCellID;
        }
            break;
    }
    return ID;
}

#pragma mark - ArticleHomeBaseCellDelegate

- (void)articleHomeBaseCell:(ArticleHomeBaseCell *)cell actionType:(ArticleHomeBaseCellActionType)type value:(id)value {
    switch (type) {
        case ArticleHomeBaseCellActionTypeSegue:
        {
            if ([self.cDelegate respondsToSelector:@selector(articleHomeTableView:actionType:value:)]) {
                [self.cDelegate articleHomeTableView:self actionType:ArticleHomeTableViewActionTypeMakeSegue value:value];
            }
        }
            break;
        default:break;
    }
}

@end
