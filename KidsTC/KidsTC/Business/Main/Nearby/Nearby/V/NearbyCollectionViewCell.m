//
//  NearbyCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCollectionViewCell.h"

#import "NearbyTableViewHeader.h"
#import "NearbyTableViewCell.h"


static NSString *const CellID = @"NearbyTableViewCell";

@interface NearbyCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,NearbyTableViewHeaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NearbyTableViewHeader *header;
@end

@implementation NearbyCollectionViewCell

- (NearbyTableViewHeader *)header {
    if (!_header) {
        _header = [[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewHeader" owner:self options:nil].firstObject;
        _header.delegate = self;
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, kNearbyTableViewHeaderH);
    }
    return _header;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 300;
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.tableHeaderView = self.header;
    });
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

#pragma mark - NearbyTableViewHeaderDelegate

- (void)nearbyTableViewHeader:(NearbyTableViewHeader *)header actionType:(NearbyTableViewHeaderActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyCollectionViewCell:actionType:value:)]) {
        [self.delegate nearbyCollectionViewCell:self actionType:(NearbyCollectionViewCellActionType)type value:value];
    }
}

@end
