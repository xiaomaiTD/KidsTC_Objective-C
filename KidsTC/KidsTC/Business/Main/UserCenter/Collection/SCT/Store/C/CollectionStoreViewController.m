//
//  CollectionStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreViewController.h"

#import "CollectionStoreView.h"

@interface CollectionStoreViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionStoreView *storeView;
@end

@implementation CollectionStoreViewController

- (void)loadView {
    
    CollectionStoreView *storeView = [[CollectionStoreView alloc] init];
    storeView.delegate = self;
    self.view  = storeView;
    self.storeView = storeView;
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
            [self.storeView endRefresh:NO];
        });
    });
}

@end
