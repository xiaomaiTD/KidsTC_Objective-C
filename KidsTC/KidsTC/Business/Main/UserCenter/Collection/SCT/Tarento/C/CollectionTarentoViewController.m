//
//  CollectionTarentoViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoViewController.h"

#import "CollectionTarentoView.h"

@interface CollectionTarentoViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionTarentoView *tarentoView;
@end

@implementation CollectionTarentoViewController

- (void)loadView {
    
    CollectionTarentoView *tarentoView = [[CollectionTarentoView alloc] init];
    tarentoView.delegate = self;
    self.view  = tarentoView;
    self.tarentoView = tarentoView;
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
            [self.tarentoView endRefresh:NO];
        });
    });
}

@end
