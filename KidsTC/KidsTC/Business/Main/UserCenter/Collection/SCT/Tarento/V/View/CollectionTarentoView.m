//
//  CollectionTarentoView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoView.h"
#import "CollectionTarentoCell.h"
#import "CollectionTarentoHeader.h"

static NSString *const CellID = @"CollectionTarentoCell";
static NSString *const HeadID = @"CollectionTarentoHeader";

@implementation CollectionTarentoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTarentoCell" bundle:nil] forCellReuseIdentifier:CellID];
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
    
    CollectionTarentoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

@end
