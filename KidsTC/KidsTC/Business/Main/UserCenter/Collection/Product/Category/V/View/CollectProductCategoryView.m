//
//  CollectProductCategoryView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryView.h"
#import "CollectProductCategoryCell.h"

static NSString *const ID = @"CollectProductCategoryCell";

@interface CollectProductCategoryView ()
@end

@implementation CollectProductCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectProductCategoryCell" bundle:nil] forCellReuseIdentifier:ID];
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
    
    CollectProductCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

@end
