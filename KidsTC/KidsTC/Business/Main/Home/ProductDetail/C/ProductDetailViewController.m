//
//  ProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailView.h"

@interface ProductDetailViewController ()<ProductDetailViewDelegate>
@property (nonatomic, strong) NSString *serviceId;
@property (nonatomic, strong) NSString *channelId;
@end

@implementation ProductDetailViewController

- (instancetype)initWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId {
    self = [super init];
    if (self) {
        _serviceId = serviceId;
        _channelId = channelId;
    }
    return self;
}

- (void)loadView {
    ProductDetailView *view = [[ProductDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.naviColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务详情";
    
}

#pragma mark - ProductDetailViewDelegate

- (void)productDetailView:(ProductDetailView *)view
               actionType:(ProductDetailViewActionType)type
                    value:(id)value
{
    
}



@end
