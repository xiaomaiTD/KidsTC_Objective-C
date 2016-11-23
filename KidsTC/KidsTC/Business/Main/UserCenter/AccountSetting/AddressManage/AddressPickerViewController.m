//
//  AddressPickerViewController.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddressPickerViewController.h"
#import "AddressPickerViewCell.h"
#import "AddressDataManager.h"
#import "GHeader.h"
#import "AddressPickerRecordButton.h"

#define ADDRESSPICKER_HEADERTIP_HEIGHT 88
#define ADDRESSPICKER_TABLEVIEW_HEIGHT SCREEN_HEIGHT*0.5
#define ADDRESSPICKER_TIPBUTTON_MARGIN 16

@interface AddressPickerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headerTipView;
@property (weak, nonatomic) IBOutlet UIView *tipTitleView;
@property (weak, nonatomic) IBOutlet UIView *tipBtnsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipTitleHLineConstrantHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipBtnsHLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contrantViewConstraintBottom;

@property (nonatomic, strong) NSArray<AddressDataItem *> *data;
@property (nonatomic, strong) NSArray<AddressDataItem *> *currentData;


@property (nonatomic, strong) NSMutableArray<AddressPickerRecordButton *> *btns;
@property (nonatomic, strong) AddressPickerRecordButton *currentRecordBtn;
@end

static NSString *const ID = @"AddressPickerViewCellID";
@implementation AddressPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tipTitleHLineConstrantHeight.constant = LINE_H;
    self.tipBtnsHLineConstraintHeight.constant = LINE_H;
    self.contentViewConstraintHeight.constant = SCREEN_HEIGHT*0.5+88;
    self.contrantViewConstraintBottom.constant = -self.contentViewConstraintHeight.constant;
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressPickerViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.btns = [NSMutableArray<AddressPickerRecordButton *> array];
    
    self.data = [AddressDataManager shareAddressDataManager].model.data;
    
    if (self.recordData.count==0) {
        self.recordData = [NSMutableArray array];
    }
    
    NSMutableArray<AddressDataItem *> *recordData = [NSMutableArray arrayWithArray:self.recordData];
    AddressDataItem *tipItem = [[AddressDataItem alloc]init];
    tipItem.level = 0;
    tipItem.hasNextLevelAddress = YES;
    tipItem.address = @"全部";
    tipItem.subAddress = self.data;
    [recordData insertObject:tipItem atIndex:0];
    self.recordData = recordData;
    
    NSInteger count = self.recordData.count;
    NSInteger index = 1;
    if (count-index>=0) {
        AddressDataItem *item = self.recordData[count-index];
        while (!item.hasNextLevelAddress && (count-index)>=0) {
            index++;
            item = self.recordData[count-index];
        }
        [self reloadData:item];
        [self updataBtns:item];
    }
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)show{
    self.contrantViewConstraintBottom.constant = -self.contentViewConstraintHeight.constant;
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.contrantViewConstraintBottom.constant = 0;
        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.contrantViewConstraintBottom.constant = -self.contentViewConstraintHeight.constant;
        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];
        self.view.backgroundColor = [UIColor clearColor];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

- (IBAction)closePage:(UIButton *)sender {
    [self hide];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressPickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    AddressDataItem *item = self.currentData[indexPath.row];
    cell.titleLabel.text = item.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressDataItem *item = self.currentData[indexPath.row];
    [self reloadData:item];
    [self updateRecordData:item];
    [self updataBtns:item];
    
    if (!item.hasNextLevelAddress) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hide];
            if (self.resultBlock) {
                NSMutableArray<AddressDataItem *> *recordData = [NSMutableArray arrayWithArray:self.recordData];
                [recordData removeObjectAtIndex:0];
                self.resultBlock(recordData);
            }
        });
    }
}

- (void)updateRecordData:(AddressDataItem *)item{
    NSUInteger index = item.level;
    NSMutableArray<AddressDataItem *> *recordData = [NSMutableArray arrayWithArray:self.recordData];
    if (index<recordData.count) {
        [recordData replaceObjectAtIndex:index withObject:item];
        self.recordData = [recordData subarrayWithRange:NSMakeRange(0, index+1)];
    }else{
        [recordData addObject:item];
        self.recordData = recordData;
    }
}

- (void)updataBtns:(AddressDataItem *)item{
    
    NSMutableArray<AddressDataItem *> *recordData = [NSMutableArray arrayWithArray:self.recordData];
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btns removeAllObjects];
    NSUInteger count = recordData.count;
    __block UIButton *lastBtn = nil;
    CGFloat btnH = CGRectGetHeight(self.tipBtnsView.frame);
    [recordData enumerateObjectsUsingBlock:^(AddressDataItem *item, NSUInteger idx, BOOL *stop) {
        AddressPickerRecordButton *btn = [self recordBtn:item.address tag:idx];
        [self.tipBtnsView addSubview:btn];
        CGFloat btnX = CGRectGetMaxX(lastBtn.frame)+ADDRESSPICKER_TIPBUTTON_MARGIN;
        CGFloat btnW = [item.address sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        btn.selected = (idx==count-1);
        lastBtn = btn;
        [self.btns addObject:btn];
    }];
}

- (AddressPickerRecordButton *)recordBtn:(NSString *)title tag:(NSUInteger)tag{
    AddressPickerRecordButton *btn = [[AddressPickerRecordButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(recordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

- (void)recordBtnClick:(AddressPickerRecordButton *)btn{
    self.currentRecordBtn.selected = NO;
    btn.selected = YES;
    self.currentRecordBtn = btn;
    AddressDataItem *item = self.recordData[btn.tag];
    
    [self reloadData:item];
    [self updateRecordData:item];
    [self updataBtns:item];
}

- (void)reloadData:(AddressDataItem *)item{
    
    if (item.hasNextLevelAddress) {
        [self getCurrentData:item successBlock:^(NSArray<AddressDataItem *> *subAddress) {
            self.currentData = subAddress;
            [self.tableView reloadData];
        } failureBlock:^{
            [self hide];
        }];
    }
}

- (void)getCurrentData:(AddressDataItem *)item
          successBlock:(void(^)(NSArray<AddressDataItem *> *subAddress))successBlock
          failureBlock:(void(^)())failureBlock
{
    if (item.subAddress.count>0) {//本地有
        if (successBlock) successBlock(item.subAddress);
    }else{//从网络抓取
        [self loadData:item successBlock:^(NSArray<AddressDataItem *> *subAddress) {
            if (successBlock) successBlock(subAddress);
        } failureBlock:^{
            if (failureBlock) failureBlock();
        }];
    }
}

- (void)loadData:(AddressDataItem *)item
    successBlock:(void(^)(NSArray<AddressDataItem *> *subAddress))successBlock
    failureBlock:(void(^)())failureBlock
{
    NSDictionary *param = @{@"level":@(item.level+1),
                            @"fid":item.ID};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADDRESS_GET_LEVEL_NEW" param:param progress:nil
                   success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        AddressModel *model = [AddressModel modelWithDictionary:dic];
        if (model.data.count>0) if (successBlock) successBlock(model.data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        if (failureBlock) failureBlock();
    }];
}


@end
