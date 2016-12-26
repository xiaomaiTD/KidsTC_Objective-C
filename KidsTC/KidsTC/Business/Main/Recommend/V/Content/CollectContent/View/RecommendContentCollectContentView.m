//
//  RecommendContentCollectContentView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendContentCollectContentView.h"
#import "RecommendDataManager.h"

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

@interface RecommendContentCollectContentView ()<UITableViewDelegate,UITableViewDataSource,ArticleHomeBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RecommendContentCollectContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 100;
    
    [self registerCells];
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

- (void)setContents:(NSArray<id> *)contents {
    _contents = contents;
    self.hidden = _contents.count<1;
    [self.tableView reloadData];
}

- (void)reloadData {
    self.contents = [[RecommendDataManager shareRecommendDataManager] recommendContent];
}
- (CGFloat)contentHeight {
    CGFloat height = CGRectGetMinY(self.tableView.frame) + self.tableView.contentSize.height;
    return self.contents.count>0?height:0.001;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if (row<self.contents.count) {
        ArticleHomeItem *item = self.contents[row];
        NSString *ID = [self cellIdWtith:item.listTemplate];
        ArticleHomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.delegate = self;
        cell.item = item;
        return cell;
    }else{
        return [tableView dequeueReusableCellWithIdentifier:ArticleHomeBaseCellID];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.contents.count) {
        ArticleHomeItem *item = self.contents[row];
        if ([self.delegate respondsToSelector:@selector(recommendContentCollectContentView:actionType:value:)]) {
            [self.delegate recommendContentCollectContentView:self actionType:RecommendContentCollectContentViewActioTypeSegue value:item.segueModel];
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
            if ([self.delegate respondsToSelector:@selector(recommendContentCollectContentView:actionType:value:)]) {
                [self.delegate recommendContentCollectContentView:self actionType:RecommendContentCollectContentViewActioTypeSegue value:value];
            }
        }
            break;
        default:break;
    }
}

- (void)nilData {
    [[RecommendDataManager shareRecommendDataManager] nilRecommendContent];
}

- (void)dealloc {
    [self nilData];
}

@end
