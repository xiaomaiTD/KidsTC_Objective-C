//
//  CollectionTarentoView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoView.h"

#import "RecommendTarentoCollectTarentoView.h"

#import "CollectionTarentoHeader.h"
#import "CollectionTarentoCell.h"
#import "CollectionTarentoFooter.h"
#import "CollectionTarentoEmptyFooter.h"

static NSString *const HeadID = @"CollectionTarentoHeader";
static NSString *const FootID = @"CollectionTarentoFooter";
static NSString *const EmptyFootID = @"CollectionTarentoEmptyFooter";

#import "CollectionTarentoItem.h"

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

@interface CollectionTarentoView ()<ArticleHomeBaseCellDelegate,RecommendTarentoCollectTarentoViewDelegate>
@property (nonatomic, strong) RecommendTarentoCollectTarentoView *footerView;
@end

@implementation CollectionTarentoView

- (RecommendTarentoCollectTarentoView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendTarentoCollectTarentoView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTarentoHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
        [self registerCells];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTarentoFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTarentoEmptyFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:EmptyFootID];
        [self resetFooterView];
    }
    return self;
}

- (void)registerCells {
    [self.tableView registerClass:[ArticleHomeBaseCell class]                                   forCellReuseIdentifier:ArticleHomeBaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeIconCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeIconCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeNoIconCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeNoIconCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeBigImgCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeBigImgCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeTagImgCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeTagImgCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeBannerCell" bundle:nil]      forCellReuseIdentifier:ArticleHomeBannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeVideoCell" bundle:nil]       forCellReuseIdentifier:ArticleHomeVideoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumCell" bundle:nil]       forCellReuseIdentifier:ArticleHomeAlbumCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeUserArticleCell" bundle:nil] forCellReuseIdentifier:ArticleHomeUserArticleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeColumnTitleCell" bundle:nil] forCellReuseIdentifier:ArticleHomeColumnTitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumEntrysCell" bundle:nil] forCellReuseIdentifier:ArticleHomeAlbumEntrysCellID];
}

- (void)resetFooterView {
    [self.footerView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat height = [self.footerView contentHeight];
        TCLog(@"footerView---height1111:%f",height);
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        self.tableView.tableFooterView = self.footerView;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat height = [self.footerView contentHeight];
        TCLog(@"footerView---height2222:%f",height);
        self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        self.tableView.tableFooterView = self.footerView;
    });
}

- (void)nilRecommendData {
    [self.footerView nilData];
    [self resetFooterView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.items.count) {
        CollectionTarentoItem *item = self.items[section];
        return item.articleLst.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CollectionTarentoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    header.deleteBtn.hidden = !self.editing;
    if (section<self.items.count) {
        CollectionTarentoItem *item = self.items[section];
        header.item = item;
        header.actionBlock = ^(CollectionTarentoItem *item){
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeUserArticleCenter value:item.authorUid completion:nil];
            }
        };
        header.deleteBlock = ^(CollectionTarentoItem *item){
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeDelete value:item completion:^(id value) {
                    BOOL success = [value boolValue];
                    if (!success) return;
                    NSMutableArray *itemsAry = [NSMutableArray arrayWithArray:self.items];
                    if (section>=itemsAry.count) return;
                    [itemsAry removeObjectAtIndex:section];
                    self.items = [NSArray arrayWithArray:itemsAry];
                    [self.tableView reloadData];
                }];
            }
        };
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.items.count) {
        CollectionTarentoItem *item = self.items[section];
        NSArray<ArticleHomeItem *> *articleLst = item.articleLst;
        if (row<articleLst.count) {
            ArticleHomeItem *articleItem = articleLst[row];
            NSString *ID = [self cellIdWtith:articleItem.listTemplate];
            ArticleHomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            cell.delegate = self;
            cell.item = articleItem;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:ArticleHomeBaseCellID];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:EmptyFootID];
    if (section<self.items.count) {
        CollectionTarentoItem *item = self.items[section];
        if (item.newsCount>0) {
            CollectionTarentoFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
            footer.item = item;
            footer.actionBlock = ^(CollectionTarentoItem *item){
                if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                    [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeUserArticleCenter value:item.authorUid completion:nil];
                }
            };
            footerView = footer;
        }
    }
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.items.count) {
        CollectionTarentoItem *item = self.items[section];
        NSArray<ArticleHomeItem *> *articleLst = item.articleLst;
        if (row<articleLst.count) {
            ArticleHomeItem *articleItem = articleLst[row];
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:articleItem.segueModel completion:nil];
            }
        }
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
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        default:break;
    }
}

#pragma mark - RecommendTarentoCollectTarentoViewDelegate

- (void)recommendTarentoCollectTarentoView:(RecommendTarentoCollectTarentoView *)view actionType:(RecommendTarentoCollectTarentoViewActionType)type value:(id)value {
    switch (type) {
        case RecommendTarentoCollectTarentoViewActionTypeUserArticleCenter:
        {
            if (![value isKindOfClass:[RecommendTarento class]]) return;
            RecommendTarento *tarento = value;
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeUserArticleCenter value:tarento.authorUid completion:nil];
            }
        }
            break;
        case RecommendTarentoCollectTarentoViewActionTypeCollect:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeCollect value:value completion:nil];
            }
        }
            break;
        case RecommendTarentoCollectTarentoViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    self.footerView = nil;
}

@end
