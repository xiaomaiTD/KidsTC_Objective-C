//
//  CommentDetailViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 10/29/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentDetailViewModel.h"
#import "GHeader.h"

@interface CommentDetailViewModel () <CommentDetailViewDataSource>

@property (nonatomic, weak) CommentDetailView *view;

@property (nonatomic, strong) NSMutableArray *itemModelsArray;

@property (nonatomic, assign) NSUInteger currentPage;

- (NSDictionary *)requestParamWithPageIndex:(NSUInteger)index;;

- (void)loadReplyListSucceed:(NSDictionary *)data;
- (void)loadReplyListFailed:(NSError *)error;
- (void)loadMoreReplyListSucceed:(NSDictionary *)data;
- (void)loadMoreReplyListFailed:(NSError *)error;

- (void)reloadListViewWithData:(NSDictionary *)data;

@end

@implementation CommentDetailViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (CommentDetailView *)view;
        self.view.dataSource = self;
        self.itemModelsArray = [[NSMutableArray alloc] init];
        self.detailModel = [[CommentDetailModel alloc] init];
    }
    return self;
}

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    
    self.currentPage = 1;
    NSDictionary *param = [self requestParamWithPageIndex:self.currentPage];
    if (self.detailModel.modelSource == CommentDetailViewSourceStrategy || self.detailModel.modelSource == CommentDetailViewSourceStrategyDetail) {
        [Request startWithName:@"COMMENT_GET_NEWS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [self loadReplyListSucceed:dic];
            if (succeed) succeed(dic);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self loadReplyListFailed:error];
            if (failure) failure(error);
        }];
    } else {
        [Request startWithName:@"COMMENT_GET_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [self loadReplyListSucceed:dic];
            if (succeed) succeed(dic);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self loadReplyListFailed:error];
            if (failure) failure(error);
        }];
    }
}


- (void)stopUpdateData {
    [self.view endLoadMore];
}


#pragma mark CommentDetailViewDataSource

- (CommentDetailModel *)detailModelForCommentDetailView:(CommentDetailView *)detailView {
    return self.detailModel;
}


#pragma mark Private methods

- (NSDictionary *)requestParamWithPageIndex:(NSUInteger)index {
    if (!self.detailModel.identifier) {
        self.detailModel.identifier = @"";
    }
    NSDictionary *param = nil;
    if (self.detailModel.modelSource == CommentDetailViewSourceServiceOrStore) {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.detailModel.relationIdentifier, @"relationSysNo",
                 [NSNumber numberWithInteger:self.detailModel.relationType], @"relationType",
                 self.detailModel.identifier, @"commentSysNo",
                 [NSNumber numberWithInteger:index], @"page",
                 [NSNumber numberWithInteger:[self.view pageSize]], @"pageCount", nil];
    } else if (self.detailModel.modelSource == CommentDetailViewSourceStrategy || self.detailModel.modelSource == CommentDetailViewSourceStrategyDetail) {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.detailModel.relationIdentifier, @"relationSysNo",
                 [NSNumber numberWithInteger:self.detailModel.relationType], @"relationType",
                 [NSNumber numberWithInteger:KTCCommentTypeAll], @"commentType",
                 [NSNumber numberWithInteger:index], @"page",
                 [NSNumber numberWithInteger:[self.view pageSize]], @"pageCount", nil];
    }
    return param;
}

- (void)loadReplyListSucceed:(NSDictionary *)data {
    [self.itemModelsArray removeAllObjects];
    self.detailModel.replyModels = nil;
    [self reloadListViewWithData:data];
    [self.view endRefresh];
}

- (void)loadReplyListFailed:(NSError *)error {
    [self.itemModelsArray removeAllObjects];
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -2001:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self reloadListViewWithData:nil];
    [self.view endRefresh];
}

- (void)loadMoreReplyListSucceed:(NSDictionary *)data {
    self.currentPage ++;
    [self reloadListViewWithData:data];
    [self.view endLoadMore];
}

- (void)loadMoreReplyListFailed:(NSError *)error {
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -2001:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self.view endLoadMore];
}

- (void)reloadListViewWithData:(NSDictionary *)data {
    NSArray *dataArray = [data objectForKey:@"data"];
    if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
        [self.view hideLoadMoreFooter:NO];
        [self.detailModel fillWithReplyRawData:dataArray];
        if ([dataArray count] < [self.view pageSize]) {
            [self.view noMoreData:YES];
        }
    } else {
        [self.view noMoreData:YES];
        [self.view hideLoadMoreFooter:YES];
    }
    
    self.detailModel.totalReplyCount = [[data objectForKey:@"count"] integerValue];
    
    [self.view reloadData];
    [self stopUpdateData];
}

#pragma mark Public methods

- (NSArray *)resutlItemModels {
    return [NSArray arrayWithArray:self.itemModelsArray];
}

- (void)getMoreReplies {
    NSUInteger nextPage = self.currentPage + 1;
    NSDictionary *param = [self requestParamWithPageIndex:nextPage];
    [Request startWithName:@"COMMENT_GET_NEWS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadMoreReplyListSucceed:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadMoreReplyListFailed:error];
    }];
}

@end
