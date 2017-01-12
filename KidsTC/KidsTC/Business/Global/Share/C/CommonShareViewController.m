//
//  CommonShareViewController.m
//  KidsTC
//
//  Created by Altair on 11/20/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommonShareViewController.h"

#import "iToast.h"

@interface CommonShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *displayBGView;

@property (weak, nonatomic) IBOutlet UIButton *wechatSessionButton;
@property (weak, nonatomic) IBOutlet UIButton *wechatTimeLineButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboButton;
@property (weak, nonatomic) IBOutlet UIButton *qqButton;
@property (weak, nonatomic) IBOutlet UIButton *qzoneButton;
@property (weak, nonatomic) IBOutlet UIButton *canceButton;

@property (weak, nonatomic) IBOutlet UILabel *wechatSessionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatTimeLineTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiboTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *qqTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *qzoneTitleLabel;

@end

@implementation CommonShareViewController

- (instancetype)initWithShareObject:(CommonShareObject *)object sourceType:(KTCShareServiceType)type {
    self = [super initWithNibName:@"CommonShareViewController" bundle:nil];
    if (self) {
        _shareObject = object;
        _sourceType = type;
    }
    return self;
}

+ (instancetype)instanceWithShareObject:(CommonShareObject *)object {
    CommonShareViewController *controller = [[CommonShareViewController alloc] initWithShareObject:object sourceType:KTCShareServiceTypeUnknow];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    return controller;
}

+ (instancetype)instanceWithShareObject:(CommonShareObject *)object sourceType:(KTCShareServiceType)type {
    CommonShareViewController *controller = [[CommonShareViewController alloc] initWithShareObject:object sourceType:type];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.displayBGView setBackgroundColor:[UIColor whiteColor]];
    [self.tapView setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedCancelButton:)];
    [self.tapView addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetShareButtonStatus];
    [self.view.superview setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tapView setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tapView setHidden:YES];
    _shareObject = nil;
}

#pragma mark Private methods

- (void)resetShareButtonStatus {
    NSDictionary *shareAvailableDic = [CommonShareService shareTypeAvailablities];
    
    BOOL canShare = [[shareAvailableDic objectForKey:kCommonShareTypeWechatSessionKey] boolValue];
    if (canShare) {
        [self.wechatSessionButton setEnabled:YES];
        [self.wechatSessionTitleLabel setAlpha:1];
    } else {
        [self.wechatSessionButton setEnabled:NO];
        [self.wechatSessionTitleLabel setAlpha:0.4];
    }
    canShare = [[shareAvailableDic objectForKey:kCommonShareTypeWechatTimeLineKey] boolValue];
    if (canShare) {
        [self.wechatTimeLineButton setEnabled:YES];
        [self.wechatTimeLineTitleLabel setAlpha:1];
    } else {
        [self.wechatTimeLineButton setEnabled:NO];
        [self.wechatTimeLineTitleLabel setAlpha:0.4];
    }
    canShare = [[shareAvailableDic objectForKey:kCommonShareTypeWeiboKey] boolValue];
    if (canShare) {
        [self.weiboButton setEnabled:YES];
        [self.weiboTitleLabel setAlpha:1];
    } else {
        [self.weiboButton setEnabled:NO];
        [self.weiboTitleLabel setAlpha:0.4];
    }
    canShare = [[shareAvailableDic objectForKey:kCommonShareTypeQQKey] boolValue];
    if (canShare) {
        [self.qqButton setEnabled:YES];
        [self.qqTitleLabel setAlpha:1];
    } else {
        [self.qqButton setEnabled:NO];
        [self.qqTitleLabel setAlpha:0.4];
    }
    canShare = [[shareAvailableDic objectForKey:kCommonShareTypeQZoneKey] boolValue];
    if (canShare) {
        [self.qzoneButton setEnabled:YES];
        [self.qzoneTitleLabel setAlpha:1];
    } else {
        [self.qzoneButton setEnabled:NO];
        [self.qzoneTitleLabel setAlpha:0.4];
    }
    
    if (self.shareObject.sourceType == CommonShareSourceTypePhoto) {
        [self.qzoneButton setEnabled:NO];
        [self.qzoneTitleLabel setAlpha:0.4];
    }
}

- (IBAction)didClickedShareButton:(UIButton *)sender {
    CommonShareType type = (CommonShareType)sender.tag;
    CommonShareObject *object = [self.shareObject copyObject];
    [self shareWithType:type object:object sourceType:self.sourceType];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareWithType:(CommonShareType)type object:(CommonShareObject *)object sourceType:(KTCShareServiceType)sourceType{
    switch (object.sourceType) {
        case CommonShareSourceTypeLink:
        {
            [self shareLink:type obj:object];
        }
            break;
        case CommonShareSourceTypePhoto:
        {
            [self shareImage:type obj:object];
        }
            break;
    }
    if (self.webViewShareCallBackType == WebViewShareCallBackTypeClickBtn) {
        KTCShareServiceChannel channel = type + 1;
        if (self.webViewCallBack) self.webViewCallBack(channel,YES);
    }
}

- (void)shareLink:(CommonShareType)type obj:(CommonShareObject *)object {
    KTCShareServiceChannel channel = type + 1;
    [[CommonShareService sharedService] startThirdPartyShareWithType:type object:object succeed:^{
        [[iToast makeText:@"分享成功"] show];
        NSString *name = @"";
        if (object.shareName) {
            name = object.shareName;
        }else{
            name = object.title;
        }
        if (self.webViewShareCallBackType == WebViewShareCallBackTypeDidHasResult) {
            if (self.webViewCallBack) self.webViewCallBack(channel,YES);
        }
        [[KTCShareService service] sendShareSucceedFeedbackToServerWithIdentifier:object.identifier channel:channel type:self.sourceType title:name];
    } failure:^(NSError *error) {
        NSString *errMsg = [error.userInfo objectForKey:kErrMsgKey];
        if ([errMsg length] == 0) {
            errMsg = @"分享失败";
        }
        [[iToast makeText:errMsg] show];
        if (self.webViewShareCallBackType == WebViewShareCallBackTypeDidHasResult) {
            if (self.webViewCallBack) self.webViewCallBack(channel,NO);
        }
    }];
}

- (void)shareImage:(CommonShareType)type obj:(CommonShareObject *)object {
    KTCShareServiceChannel channel = type + 1;
    [[CommonShareService sharedService] startThirdPartyShareImageWithType:type object:object succeed:^{
        [[iToast makeText:@"分享成功"] show];
        NSString *name = @"";
        if (object.shareName) {
            name = object.shareName;
        }else{
            name = object.title;
        }
        if (self.webViewShareCallBackType == WebViewShareCallBackTypeDidHasResult) {
            if (self.webViewCallBack) self.webViewCallBack(channel,YES);
        }
        [[KTCShareService service] sendShareSucceedFeedbackToServerWithIdentifier:object.identifier channel:channel type:self.sourceType title:name];
    } failure:^(NSError *error) {
        NSString *errMsg = [error.userInfo objectForKey:kErrMsgKey];
        if ([errMsg length] == 0) {
            errMsg = @"分享失败";
        }
        [[iToast makeText:errMsg] show];
        if (self.webViewShareCallBackType == WebViewShareCallBackTypeDidHasResult) {
            if (self.webViewCallBack) self.webViewCallBack(channel,NO);
        }
    }];
}


- (IBAction)didClickedCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
