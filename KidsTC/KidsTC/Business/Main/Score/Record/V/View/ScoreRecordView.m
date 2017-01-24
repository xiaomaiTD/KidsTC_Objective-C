//
//  ScoreRecordView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreRecordView.h"

#import "ScoreRecordDetailCell.h"

static NSString *const DetailCellID = @"ScoreRecordDetailCell";

@interface ScoreRecordView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreRecordView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 80;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreRecordDetailCell" bundle:nil] forCellReuseIdentifier:DetailCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
    return cell;
}

@end
