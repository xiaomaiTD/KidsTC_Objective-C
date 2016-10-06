//
//  StoreDetailAppointmentViewController.m
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetailAppointmentViewController.h"
#import "GHeader.h"

#import "StoreDetailAppointmentBaseCell.h"
#import "StoreDetailAppointmentPreferenceTipCell.h"
#import "StoreDetailAppointmentPreferenceInfoCell.h"
#import "StoreDetailAppointmentContactCell.h"

#import "MTA.h"
#import "UMMobClick/MobClick.h"

@interface StoreDetailAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource,StoreDetailAppointmentBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomMargin;

@property (nonatomic, strong) NSArray<NSArray<StoreDetailAppointmentBaseCell *> *> *sections;

@end

@implementation StoreDetailAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *section00 = [NSMutableArray array];
    
    __block CGFloat height = 0;
    NSArray<ActivityLogoItem *> *activeModelsArray = self.detailModel.activeModelsArray;
    if (activeModelsArray.count>0) {
        StoreDetailAppointmentPreferenceTipCell *preferenceTipCell = [self viewWithNib:@"StoreDetailAppointmentPreferenceTipCell"];
        [section00 addObject:preferenceTipCell];
        height += 38;
        [activeModelsArray enumerateObjectsUsingBlock:^(ActivityLogoItem *obj, NSUInteger idx, BOOL *stop) {
            StoreDetailAppointmentPreferenceInfoCell *preferenceInfoCell = [self viewWithNib:@"StoreDetailAppointmentPreferenceInfoCell"];
            preferenceInfoCell.tag = idx;
            [section00 addObject:preferenceInfoCell];
            height += 38;
        }];
    }
    StoreDetailAppointmentContactCell *contactCell = [self viewWithNib:@"StoreDetailAppointmentContactCell"];
    [section00 addObject:contactCell];
    height += 128;
    [sections addObject:section00];
    
    self.sections = sections;
    
    [self.tableView reloadData];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableViewHight.constant = height;
    self.tableViewBottomMargin.constant = - self.tableViewHight.constant;
    [self updateTableViewLayout];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self show];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sections[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailAppointmentBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.detailModel = self.detailModel;
    cell.delegate = self;
    return cell;
}

#pragma mark - StoreDetailAppointmentBaseCellDelegate

- (void)storeDetailAppointmentBaseCell:(StoreDetailAppointmentBaseCell *)cell actionType:(StoreDetailAppointmentBaseCellActionType)type value:(id)value{
    NSString *text = value;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.detailModel.storeId, @"storeno", text, @"mobile", nil];
    [TCProgressHUD showSVP];
    [Request startWithName:@"ORDER_CREATE_APPOINTMENTORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self submitOrderSucceed:dic];
        NSDictionary *trackParam = [NSDictionary dictionaryWithObjectsAndKeys:@"true", @"result", nil];
        [MTA trackCustomKeyValueEvent:@"event_result_appoint_result" props:trackParam];
        [MobClick event:@"event_result_appoint_result" attributes:trackParam];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self submitOrderFailed:error];
        NSDictionary *trackParam = [NSDictionary dictionaryWithObjectsAndKeys:@"false", @"result", nil];
        [MTA trackCustomKeyValueEvent:@"event_result_appoint_result" props:trackParam];
        [MobClick event:@"event_result_appoint_result" attributes:trackParam];
    }];
}

- (void)submitOrderSucceed:(NSDictionary *)data {
    NSString *resp = [data objectForKey:@"data"];
    if (resp && [resp isKindOfClass:[NSString class]]) {
        [[iToast makeText:resp] show];
    } else {
        [[iToast makeText:@"恭喜您，预约成功！"] show];
    }
    [self back];
}

- (void)submitOrderFailed:(NSError *)error {
    if ([[error userInfo] count] > 0) {
        NSString *errMsg = [[error userInfo] objectForKey:@"data"];
        [[iToast makeText:errMsg] show];
    } else {
        [[iToast makeText:@"预约失败"] show];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self close];
}

- (void)show {
    self.view.backgroundColor = [UIColor clearColor];
    self.tableViewBottomMargin.constant = - self.tableViewHight.constant;
    [self updateTableViewLayout];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.tableViewBottomMargin.constant = 0;
        [self updateTableViewLayout];
    }];
}

- (void)close {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.tableViewBottomMargin.constant = - self.tableViewHight.constant;
        [self updateTableViewLayout];
    } completion:^(BOOL finished) {
        [self back];
    }];
}

- (void)updateTableViewLayout {
    [self.tableView setNeedsUpdateConstraints];
    [self.tableView updateConstraintsIfNeeded];
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
}


/**
 @property (nonatomic, assign) CGFloat keyboardHeight;
 */
#pragma mark Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification{
    [super keyboardWillShow:notification];
    self.tableViewBottomMargin.constant = self.keyboardHeight;
    [self updateTableViewLayout];
}
- (void)keyboardWillDisappear:(NSNotification *)notification{
    [super keyboardWillDisappear:notification];
    self.tableViewBottomMargin.constant = 0;
    [self updateTableViewLayout];
}


@end
