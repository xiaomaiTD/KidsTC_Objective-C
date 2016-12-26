//
//  CollectionContentView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionContentView.h"
#import "ArticleHomeBaseCell.h"

#import "RecommendContentCollectContentView.h"

static NSString *const ID = @"CollectionContentCell";

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

@interface CollectionContentView ()<ArticleHomeBaseCellDelegate,RecommendContentCollectContentViewDelegate>
@property (nonatomic, strong) RecommendContentCollectContentView *footerView;
@end

@implementation CollectionContentView

- (RecommendContentCollectContentView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendContentCollectContentView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self registerCells];
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
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.footerView contentHeight]);
    self.tableView.tableFooterView = self.footerView;
}

- (void)nilRecommendData {
    [self.footerView nilData];
    [self resetFooterView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        ArticleHomeItem *item = self.items[row];
        NSString *ID = [self cellIdWtith:item.listTemplate];
        ArticleHomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.delegate = self;
        cell.item = item;
        cell.deleteBtn.hidden = !self.editing;
        cell.deleteNewsBlock = ^(ArticleHomeItem *item){
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeDelete value:item completion:^(id value) {
                    BOOL success = [value boolValue];
                    if (!success) return;
                    NSMutableArray *itemsAry = [NSMutableArray arrayWithArray:self.items];
                    if (row>=itemsAry.count) return;
                    [itemsAry removeObjectAtIndex:row];
                    self.items = [NSArray arrayWithArray:itemsAry];
                    [self.tableView reloadData];
                }];
            }
        };
        return cell;
    }else{
        return [tableView dequeueReusableCellWithIdentifier:ArticleHomeBaseCellID];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        ArticleHomeItem *item = self.items[row];
        if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
            [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:item.segueModel completion:nil];
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

#pragma mark - RecommendContentCollectContentViewDelegate

- (void)recommendContentCollectContentView:(RecommendContentCollectContentView *)view
                                actionType:(RecommendContentCollectContentViewActioType)type
                                     value:(id)value
{
    switch (type) {
        case RecommendContentCollectContentViewActioTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        case RecommendContentCollectContentViewActioTypeCollect:
        {
            if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
                [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeCollect value:value completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

@end
