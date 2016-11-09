//
//  CollectProductAllViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductAllViewController.h"
#import "CollectProductAllView.h"

@interface CollectProductAllViewController ()<CollectProductBaseViewActionTypeDelegate>
@property (nonatomic, strong) CollectProductAllView *allView;
@end

@implementation CollectProductAllViewController

- (void)loadView {
    CollectProductAllView *allView = [[CollectProductAllView alloc] init];
    allView.delegate = self;
    self.view =  allView;
    self.allView = allView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value {
    switch (type) {
        case CollectProductBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    
}

@end
