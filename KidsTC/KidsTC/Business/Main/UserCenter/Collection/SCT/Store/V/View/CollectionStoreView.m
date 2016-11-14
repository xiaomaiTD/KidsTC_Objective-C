//
//  CollectionStoreView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreView.h"
#import "CollectionStoreHeader.h"
#import "CollectionStoreCell.h"
#import "CollectionStoreFooter.h"

static NSString *const CellID = @"CollectionStoreCell";
static NSString *const HeadID = @"CollectionStoreHeader";
static NSString *const FootID = @"CollectionStoreFooter";

@implementation CollectionStoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreCell" bundle:nil] forCellReuseIdentifier:CellID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionStoreFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CollectionStoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CollectionStoreFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
    
    return footer;
}



@end
