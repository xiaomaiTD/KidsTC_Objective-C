//
//  RecommendTarentoCollectTarentoView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendTarentoCollectTarentoView.h"
#import "RecommendDataManager.h"

#import "RecommendTarentoCollectTarentoHeader.h"
#import "RecommendTarentoCollectTarentoFooter.h"
#import "RecommendTarentoCollectTarentoEmptyFooter.h"

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

static NSString *const HeadID = @"RecommendTarentoCollectTarentoHeader";
static NSString *const FootID = @"RecommendTarentoCollectTarentoFooter";
static NSString *const EmptyFootID = @"RecommendTarentoCollectTarentoEmptyFooter";

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

@interface RecommendTarentoCollectTarentoView ()<UITableViewDelegate,UITableViewDataSource,ArticleHomeBaseCellDelegate,RecommendTarentoCollectTarentoHeaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RecommendTarentoCollectTarentoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 60;
    self.tableView.estimatedSectionHeaderHeight = 80;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendTarentoCollectTarentoHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
    [self registerCells];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendTarentoCollectTarentoFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendTarentoCollectTarentoEmptyFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:EmptyFootID];
    [self layoutIfNeeded];
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

- (void)reloadData {
    self.tarentos = [[RecommendDataManager shareRecommendDataManager] recommendTarento];
    self.hidden = _tarentos.count<1;
    [self.tableView reloadData];
}
- (CGFloat)contentHeight {
    
    [self layoutIfNeeded];
    
    CGFloat height = CGRectGetMinY(self.tableView.frame) + self.tableView.contentSize.height;
    return self.tarentos.count>0?height:0.001;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tarentos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.tarentos.count) {
        RecommendTarento *tarento = self.tarentos[section];
        return tarento.articleLst.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RecommendTarentoCollectTarentoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    if (section<self.tarentos.count) {
        RecommendTarento *tarento = self.tarentos[section];
        header.tarento = tarento;
        header.delegate = self;
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.tarentos.count) {
        RecommendTarento *tarento = self.tarentos[section];
        NSArray<ArticleHomeItem *> *articleLst = tarento.articleLst;
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
    if (section<self.tarentos.count) {
        RecommendTarento *tarento = self.tarentos[section];
        if (tarento.newsCount>0) {
            RecommendTarentoCollectTarentoFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
            footer.tarento = tarento;
            footer.actionBlock = ^(RecommendTarento *tarento){
                if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoView:actionType:value:)]) {
                    [self.delegate recommendTarentoCollectTarentoView:self actionType:RecommendTarentoCollectTarentoViewActionTypeUserArticleCenter value:tarento];
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
    if (section<self.tarentos.count) {
        RecommendTarento *item = self.tarentos[section];
        NSArray<ArticleHomeItem *> *articleLst = item.articleLst;
        if (row<articleLst.count) {
            ArticleHomeItem *articleItem = articleLst[row];
            if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoView:actionType:value:)]) {
                [self.delegate recommendTarentoCollectTarentoView:self actionType:RecommendTarentoCollectTarentoViewActionTypeSegue value:articleItem.segueModel];
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

#pragma mark - RecommendTarentoCollectTarentoHeaderDelegate

- (void)recommendTarentoCollectTarentoHeader:(RecommendTarentoCollectTarentoHeader *)header
                                  actionType:(RecommendTarentoCollectTarentoHeaderActionType)type
                                       value:(id)value
{
    switch (type) {
        case RecommendTarentoCollectTarentoHeaderActionTypeUserArticleCenter:
        {
            if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoView:actionType:value:)]) {
                [self.delegate recommendTarentoCollectTarentoView:self actionType:RecommendTarentoCollectTarentoViewActionTypeUserArticleCenter value:value];
            }
        }
            break;
        case RecommendTarentoCollectTarentoHeaderActionTypeCollect:
        {
            if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoView:actionType:value:)]) {
                [self.delegate recommendTarentoCollectTarentoView:self actionType:RecommendTarentoCollectTarentoViewActionTypeCollect value:value];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - ArticleHomeBaseCellDelegate

- (void)articleHomeBaseCell:(ArticleHomeBaseCell *)cell actionType:(ArticleHomeBaseCellActionType)type value:(id)value {
    switch (type) {
        case ArticleHomeBaseCellActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(recommendTarentoCollectTarentoView:actionType:value:)]) {
                [self.delegate recommendTarentoCollectTarentoView:self actionType:RecommendTarentoCollectTarentoViewActionTypeSegue value:value];
            }
        }
            break;
        default:break;
    }
}

- (void)nilData {
    [[RecommendDataManager shareRecommendDataManager] nilRecommendTarento];
}

- (void)dealloc {
    [self nilData];
}
@end
