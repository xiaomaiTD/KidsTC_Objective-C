//
//  ScoreRecordViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreRecordViewController.h"
#import "GHeader.h"

#import "ScoreRecordModel.h"
#import "ScoreRecordView.h"

@interface ScoreRecordViewController ()<ScoreRecordViewDelegate>
@property (strong, nonatomic) IBOutlet ScoreRecordView *recordView;
@property (nonatomic,strong) NSArray<ScoreRecordItem *> *records;
@property (nonatomic,assign) NSUInteger page;
@end

@implementation ScoreRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分明细";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recordView.delegate = self;

}



#pragma mark ScoreRecordViewDelegate

- (void)scoreRecordView:(ScoreRecordView *)view actionType:(ScoreRecordViewActionType)type value:(id)value {
    switch (type) {
        case ScoreRecordViewActionTypeLoadData:
        {
            [self loadScoreRecord:value];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadScoreRecord:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) {
        return;
    }
    BOOL refresh = [value boolValue];
    
    self.page = refresh?1:++self.page;
    
    NSDictionary *param = @{@"page":@(self.page),
                            @"pagecount":@(TCPAGECOUNT)};
    [Request startWithName:@"SCORE_FLOW_QUERY" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ScoreRecordItem *> *data = [ScoreRecordModel modelWithDictionary:dic].data;
        if (refresh) {
            self.records = [NSArray arrayWithArray:data];
        }else{
            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.records];
            [ary addObjectsFromArray:data];
            self.records = [NSArray arrayWithArray:ary];
        }
        self.recordView.records = self.records;
        [self.recordView dealWithUI:data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.recordView dealWithUI:0];
    }];
}

@end
