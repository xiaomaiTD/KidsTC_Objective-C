//
//  ScoreCenterView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterView.h"

#import "ScoreCenterBaseCell.h"
#import "ScoreCenterCenterCell.h"
#import "ScoreCenterItemsCell.h"
#import "ScoreCenterDetailCell.h"
#import "ScoreCenterDetailTopCell.h"

static NSString *const BaseCellID = @"ScoreCenterBaseCell";
static NSString *const CenterCellID = @"ScoreCenterCenterCell";
static NSString *const ItemsCellID = @"ScoreCenterItemsCell";
static NSString *const DetailCellID = @"ScoreCenterDetailCell";
static NSString *const DetailTopCellID = @"ScoreCenterDetailTopCell";

@interface ScoreCenterView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ScoreCenterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 80;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterCenterCell" bundle:nil] forCellReuseIdentifier:CenterCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterItemsCell" bundle:nil] forCellReuseIdentifier:ItemsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterDetailCell" bundle:nil] forCellReuseIdentifier:DetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterDetailTopCell" bundle:nil] forCellReuseIdentifier:DetailTopCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreCenterBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:BaseCellID];
    return cell;
}

@end
