//
//  CollectProductReduceView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceView.h"
#import "CollectProductReduceCell.h"

static NSString *const ID = @"CollectProductReduceCell";

@interface CollectProductReduceView ()
@end

@implementation CollectProductReduceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectProductReduceCell" bundle:nil] forCellReuseIdentifier:ID];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectProductReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

@end
