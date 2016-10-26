//
//  ProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailView.h"
#import "ProductDetailToolBar.h"

@interface ProductDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductDetailToolBarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) ProductDetailToolBar *toolBar;
@end

@implementation ProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
        
        [self setupToolBar];
        
    }
    return self;
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    ProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - kProductDetailToolBarHeight, SCREEN_WIDTH, kProductDetailToolBarHeight);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark ProductDetailToolBarDelegate

- (void)productDetailToolBar:(ProductDetailToolBar *)toolBar btnType:(ProductDetailToolBarBtnType)type value:(id)value {
    
    switch (type) {
        case ProductDetailToolBarBtnTypeContact:
        {
            
        }
            break;
            
        case ProductDetailToolBarBtnTypeAttention:
        {
            
        }
            break;
            
        case ProductDetailToolBarBtnTypeBuy:
        {
            
        }
            break;
    }
    
}

@end
