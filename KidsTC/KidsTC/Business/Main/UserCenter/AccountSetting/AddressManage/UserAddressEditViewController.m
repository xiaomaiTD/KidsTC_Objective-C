//
//  UserAddressEditViewController.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressEditViewController.h"
#import "UserAddressEditViewCell.h"
#import "ContactsManager.h"
#import "iToast.h"
#import "GHeader.h"
#import "AddressPickerViewController.h"
#import "NSString+Category.h"


@interface UserAddressEditViewController ()<UITableViewDelegate,UITableViewDataSource,UserAddressEditViewCellDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UserAddressEditViewCell *cell;
@end

@implementation UserAddressEditViewController

- (UserAddressEditModel *)model{
    if (!_model) {
        _model = [[UserAddressEditModel alloc]init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10910;
    
    if (self.editType == UserAddressEditTypeAdd) {
        self.navigationItem.title = @"新增收货地址";
    }else if (self.editType == UserAddressEditTypeModify){
        self.navigationItem.title = @"修改收货地址";
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"UserAddressEditViewCell" owner:self options:nil]firstObject];
    self.cell.delegate = self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight(self.cell.frame);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell.model = self.model;
    return self.cell;
}

#pragma mark - UserAddressEditViewCellDelegate

- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell actionType:(UserAddressEditViewCellActionType)type{
    switch (type) {
        case UserAddressEditViewCellActionTypeSelect:
        {
             [ContactsManager selectContactsWithTarget:self successBlock:^(Contacts *contacts) {
                 self.model.name = contacts.name;
                 self.model.phone = contacts.phone;
                 [self.tableView reloadData];
             } failureBlock:^(NSError *error) {
                 if (error.domain.length>0) [[iToast makeText:error.domain] show];
             }];
        }
            break;
        case UserAddressEditViewCellActionTypeSave:
        {
            if ([self isModelValidate]) {
                if (self.model.area.count<4) return;
                UserAddressManageDataItem *item = [UserAddressManageDataItem itemWith:self.model];
                NSString *ID = (self.editType == UserAddressEditTypeModify)?item.ID:@"";
                NSDictionary *param = @{@"provinceId": item.provinceId,  //省ID(必传)
                                        @"cityId"    : item.cityId,      //市ID(必传)
                                        @"districtId": item.districtId,  //区ID(必传)
                                        @"streetId"  : item.streetId,    //街道ID(必传)
                                        @"address"   : item.address,     //详细地址(必传)
                                        @"peopleName": item.peopleName,  //收货人姓名(必传)
                                        @"mobile"    : item.mobile,      //收货人手机号(必传)
                                        @"id"        : ID,               //如果是修改的话传修改记录的编号(可传)
                                        @"isDefault" : @(item.isDefault),/**是否默认 1：是，2：否(可传)*/};
                [TCProgressHUD showSVP];
                [Request startWithName:@"ADDRESS_EDIT_USER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                    [TCProgressHUD dismissSVP];
                    [[iToast makeText:@"操作成功"] show];
                    [self back];
                    if (self.resultBlock) self.resultBlock(item);
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [TCProgressHUD dismissSVP];
                    [[iToast makeText:@"操作失败"] show];
                }];
            }
        }
            break;
        case UserAddressEditViewCellActionTypeTapArea:
        {
            [self showAreaPicker];
        }
            break;
    }
}

- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell endEditing:(NSString *)value type:(UserAddressEditViewCellEditType)type{
    switch (type) {
        case UserAddressEditViewCellEditTypeName:
        {
            self.model.name = value;
        }
            break;
        case UserAddressEditViewCellEditTypePhone:
        {
            self.model.phone = value;
        }
            break;
        case UserAddressEditViewCellEditTypeAddress:
        {
            self.model.address = value;
        }
            break;
    }
    [self.tableView reloadData];
}

- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell switchOn:(BOOL)switchOn{
    self.model.isDefaultAddressRecorde = switchOn;
    [self.tableView reloadData];
}

#pragma mark - private

- (BOOL)isModelValidate{
    if (self.model.name.length==0) {
        [[iToast makeText:@"请填写收货人"] show];
        return NO;
    }
    if (self.model.phone.length==0) {
        [[iToast makeText:@"请填写手机号码"] show];
        return NO;
    }
    if (self.model.area.count==0) {
        [[iToast makeText:@"请选择所在区域"] show];
        return NO;
    }
    if (self.model.address.length==0) {
        [[iToast makeText:@"请填写详细地址"] show];
        return NO;
    }
    return YES;
}

- (BOOL)validate:(NSString *)str{
    NSString * regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

- (void)showAreaPicker{
    AddressPickerViewController *controller = [[AddressPickerViewController alloc]initWithNibName:@"AddressPickerViewController" bundle:nil];
    controller.recordData = self.model.area;
    controller.resultBlock = ^void (NSArray<AddressDataItem *> *result){
        self.model.area = result;
        [self.tableView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:^{
        [controller show];
    }];
}

@end
