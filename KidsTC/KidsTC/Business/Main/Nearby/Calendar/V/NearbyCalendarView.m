//
//  NearbyCalendarView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarView.h"
#import "NearbyCalendarToolBar.h"
#import "NearbyCalendarToolBarDateView.h"
#import "NearbyCalendarToolBarCategoryView.h"
#import "NearbyCalendarCell.h"

static NSString *const CellID = @"NearbyCalendarCell";


@interface NearbyCalendarView ()<NearbyCalendarToolBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NearbyCalendarToolBar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NearbyCalendarView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NearbyCalendarToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"NearbyCalendarToolBar" owner:self options:nil].firstObject;
    toolBar.delegate = self;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.toolBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, kNearbyCalendarToolBarH);
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

#pragma mark - NearbyCalendarToolBarDelegate

- (void)nearbyCalendarToolBar:(NearbyCalendarToolBar *)toolBar actionType:(NearbyCalendarToolBarActionType)type value:(id)value {
    
}


@end
