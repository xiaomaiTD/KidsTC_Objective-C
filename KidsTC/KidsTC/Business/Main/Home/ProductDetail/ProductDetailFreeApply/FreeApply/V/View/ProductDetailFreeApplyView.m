//
//  ProductDetailFreeApplyView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyView.h"
#import "Colours.h"
#import "NSString+Category.h"

#import "ProductDetailFreeApplyBaseCell.h"
#import "ProductDetailFreeApplyUserPhoneCell.h"
#import "ProductDetailFreeApplyUserAddressTipCell.h"
#import "ProductDetailFreeApplyUserAddressCell.h"
#import "ProductDetailFreeApplyActivityDateCell.h"
#import "ProductDetailFreeApplyActivityStoreCell.h"
#import "ProductDetailFreeApplyBabyNameCell.h"
#import "ProductDetailFreeApplyBabyBirthCell.h"
#import "ProductDetailFreeApplyBabyAgeCell.h"
#import "ProductDetailFreeApplyBabySexCell.h"
#import "ProductDetailFreeApplyParentNameCell.h"
#import "ProductDetailFreeApplyUserRemarkCell.h"

#import "ProductDetailFreeApplyFooterView.h"

static NSString *const ID = @"UITableViewCell";

@interface ProductDetailFreeApplyView ()<UITableViewDelegate,UITableViewDataSource,ProductDetailFreeApplyBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductDetailFreeApplyBaseCell *> *> *sections;
@property (nonatomic, strong) ProductDetailFreeApplyFooterView *footerView;
@end

@implementation ProductDetailFreeApplyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableView];
        
        [self setupFooter];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.tableFooterView = self.footerView;
    self.tableView.frame = self.bounds;
}

- (void)reloadData {
    
    [self.tableView reloadData];
}

- (void)reloadSections {
    [self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60.0f;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)setupFooter {
    ProductDetailFreeApplyFooterView *footerView = self.footerView;
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    footerView.sureBlock = ^{
        if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyView:actionType:value:)]) {
            [self.delegate productDetailFreeApplyView:self actionType:ProductDetailFreeApplyViewActionTypeSure value:nil];
        }
    };
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)setupSections {
    
    ProductDetailEnrollInfo *enrollInfo = self.data.enrollInfo;
    
    ProductDetailTime *time = self.data.time;
    NSArray<ProductDetailStore *> *store = self.data.store;
    
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    if (enrollInfo.isUserPhone) {
        [section00 addObject:self.userPhoneCell];
    }
    if (enrollInfo.isUserAddress) {
        if (self.showModel.userAddress) {
            [section00 addObject:self.userAddress];
        }else{
            [section00 addObject:self.userAddressTipCell];
        }
    }
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (time.times.count>0) {
        [section01 addObject:self.activityDateCell];
    }
    switch (self.data.placeType) {
        case PlaceTypeStore:
        {
            if (store.count>0) [section01 addObject:self.activityStoreCell];
        }
            break;
        case PlaceTypePlace:
        {
            if (self.data.place.count>0) [section01 addObject:self.activityStoreCell];
        }
            break;
        case PlaceTypeNone:
        {
            
        }
            break;
        default:
        {
            if (store.count>0) [section01 addObject:self.activityStoreCell];
        }
            break;
    }
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if (enrollInfo.isBabyName) {
        [section02 addObject:self.babyNameCell];
    }
    if (enrollInfo.isBabyBirthday) {
        [section02 addObject:self.babyBirthCell];
    }
    if (enrollInfo.isBabyAge) {
        [section02 addObject:self.babyAgeCell];
    }
    if (enrollInfo.isBabySex) {
        [section02 addObject:self.babySexCell];
    }
    if (enrollInfo.isHouseholdName) {
        [section02 addObject:self.parentNameCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    NSMutableArray *section03 = [NSMutableArray array];
    [section03 addObject:self.userRemarkCell];
    if (section03.count>0) [sections addObject:section03];
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark - viewWithNib

//user

- (ProductDetailFreeApplyUserPhoneCell *)userPhoneCell {
    return [self viewWithNib:@"ProductDetailFreeApplyUserPhoneCell"];
}

- (ProductDetailFreeApplyUserAddressTipCell *)userAddressTipCell {
    return [self viewWithNib:@"ProductDetailFreeApplyUserAddressTipCell"];
}

- (ProductDetailFreeApplyUserAddressCell *)userAddress {
    return [self viewWithNib:@"ProductDetailFreeApplyUserAddressCell"];
}

//activity

- (ProductDetailFreeApplyActivityDateCell *)activityDateCell {
    return [self viewWithNib:@"ProductDetailFreeApplyActivityDateCell"];
}

- (ProductDetailFreeApplyActivityStoreCell *)activityStoreCell {
    return [self viewWithNib:@"ProductDetailFreeApplyActivityStoreCell"];
}

//baby

- (ProductDetailFreeApplyBabyNameCell *)babyNameCell {
    return [self viewWithNib:@"ProductDetailFreeApplyBabyNameCell"];
}

- (ProductDetailFreeApplyBabyBirthCell *)babyBirthCell {
    return [self viewWithNib:@"ProductDetailFreeApplyBabyBirthCell"];
}

- (ProductDetailFreeApplyBabyAgeCell *)babyAgeCell {
    return [self viewWithNib:@"ProductDetailFreeApplyBabyAgeCell"];
}

- (ProductDetailFreeApplyBabySexCell *)babySexCell {
    return [self viewWithNib:@"ProductDetailFreeApplyBabySexCell"];
}

- (ProductDetailFreeApplyParentNameCell *)parentNameCell {
    return [self viewWithNib:@"ProductDetailFreeApplyParentNameCell"];
}

- (ProductDetailFreeApplyUserRemarkCell *)userRemarkCell {
    return [self viewWithNib:@"ProductDetailFreeApplyUserRemarkCell"];
}

//footer

- (ProductDetailFreeApplyFooterView *)footerView {
    if (!_footerView) {
        _footerView = [self viewWithNib:@"ProductDetailFreeApplyFooterView"];
    }
    return _footerView;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<ProductDetailFreeApplyBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductDetailFreeApplyBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.showModel = self.showModel;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 4.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 16, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            }
            else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            }
            else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            }
            else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorFromHexString:@"FFFFFF"].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = LINE_H;
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                lineLayer.backgroundColor = [UIColor colorFromHexString:@"eeeeee"].CGColor;;
                [layer addSublayer:lineLayer];
            }
            layer.lineWidth = LINE_H;
            layer.strokeColor = [UIColor colorFromHexString:@"eeeeee"].CGColor;
            
            UIView *roundView = [[UIView alloc] initWithFrame:bounds];
            [roundView.layer insertSublayer:layer atIndex:0];
            roundView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = roundView;
            
//            CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init];
//            backgroundLayer.path = layer.path;
//            backgroundLayer.fillColor = [UIColor colorFromHexString:@"eeeeee"].CGColor;
//            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//            [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//            selectedBackgroundView.backgroundColor = UIColor.clearColor;
//            cell.selectedBackgroundView = selectedBackgroundView;
        }
    }
}

#pragma mark - ProductDetailFreeApplyBaseCellDelegate

- (void)productDetailFreeApplyBaseCell:(ProductDetailFreeApplyBaseCell *)cell
                            actionType:(ProductDetailFreeApplyBaseCellActionType)type
                                 value:(id)value
{
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyView:actionType:value:)]) {
        [self.delegate productDetailFreeApplyView:self actionType:(ProductDetailFreeApplyViewActionType)type value:value];
    }
}

@end
