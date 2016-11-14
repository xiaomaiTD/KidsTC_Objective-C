//
//  CollectionContentViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionContentViewController.h"

#import "CollectionContentView.h"

@interface CollectionContentViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionContentView *contentView;
@end

@implementation CollectionContentViewController

- (void)loadView {
    
    CollectionContentView *contentView = [[CollectionContentView alloc] init];
    contentView.delegate = self;
    self.view  = contentView;
    self.contentView = contentView;
}


#pragma mark - CollectionSCTBaseViewDelegate

- (void)collectionSCTBaseView:(CollectionSCTBaseView *)view actionType:(CollectionSCTBaseViewActionType)type value:(id)value {
    switch (type) {
        case CollectionSCTBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentView endRefresh:NO];
        });
    });
}

@end
