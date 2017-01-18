//
//  VideoPlayViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "VideoPlayViewController.h"

#import <PLPlayerKit/PLPlayerKit.h>

#import "ReachabilityManager.h"

#import "TabBarController.h"
#import "NSString+Category.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define enableBackgroundPlay    1
static NSString *status[] = {
    @"PLPlayerStatusUnknow",
    @"PLPlayerStatusPreparing",
    @"PLPlayerStatusReady",
    @"PLPlayerStatusCaching",
    @"PLPlayerStatusPlaying",
    @"PLPlayerStatusPaused",
    @"PLPlayerStatusStopped",
    @"PLPlayerStatusError"
};

@interface VideoPlayViewController ()<PLPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtnCenter;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarHeight;

@property (nonatomic, strong) PLPlayer  *player;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) int reconnectCount;
@property (nonatomic, assign) BOOL toolBarIsShow;

@end

@implementation VideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bgView.backgroundColor = [UIColor blackColor];
    [self.activityIndicatorView stopAnimating];
    
    //本地：http://192.168.91.251:8011/Images/xihuan.mp4
    //七牛：http://ojcnkhx1c.bkt.clouddn.com/testvideo201701061637
    //NSURL *mp4Url = [NSURL URLWithString:@"http://192.168.91.251:8011/Images/xihuan.mp4"];
    
    self.toolBarIsShow = YES;
    [self.slider setThumbImage:[UIImage imageNamed:@"videoscreen_icon_round"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"videoscreen_icon_round_pressing"] forState:UIControlStateHighlighted];
    self.slider.minimumTrackTintColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.9];
    self.slider.maximumTrackTintColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.3];
    
    [NotificationCenter addObserver:self selector:@selector(changeProgress) name:kTCCountDownNoti object:nil];
    
    [NotificationCenter addObserver:self selector:@selector(changeNetworkStatus) name:kReachabilityStatusChangeNoti object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)setVideo:(VideoPlayVideo *)video {
    _video = video;
    if (!_player && [video.videoUrl isNotNull]) {
        self.reconnectCount = 0;
        NSURL *videoUrl = [NSURL URLWithString:self.video.videoUrl];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        PLPlayerOption *option = [PLPlayerOption defaultOption];
        [option setOptionValue:@10 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
        //[option setOptionValue:@(YES) forKey:PLPlayerOptionKeyVideoToolbox];
        //[option setOptionValue:@(YES) forKey:PLPlayerOptionKeyVODFFmpegEnable];
        
        self.player = [PLPlayer playerWithURL:videoUrl option:option];
        self.player.delegate = self;
        self.player.delegateQueue = dispatch_get_main_queue();
        self.player.backgroundPlayEnable = enableBackgroundPlay;
#if !enableBackgroundPlay
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayer) name:UIApplicationWillEnterForegroundNotification object:nil];
#endif
        [self.bgView insertSubview:self.player.playerView atIndex:0];
        
        self.player.launchView.contentMode = UIViewContentModeScaleAspectFit;
        [self.player.launchView sd_setImageWithURL:[NSURL URLWithString:self.video.videoImg] placeholderImage:PLACEHOLDERIMAGE_BIG];
        
        self.player.rotationMode =
        PLPlayerRotateLeft// 向左旋
        |PLPlayerRotateRight// 向右旋
        |PLPlayerFlipVertical// 垂直翻转
        |PLPlayerFlipHorizonal// 水平翻转
        |PLPlayerRotate180;// 旋转 180 度
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.player.playerView.frame = self.bgView.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat bottomMargin = self.toolBarIsShow?-self.toolBarHeight.constant:0;
    [UIView animateWithDuration:0.3 animations:^{
        self.toolBarBottomMargin.constant = bottomMargin;
        [self.view layoutIfNeeded];
    }];
    self.toolBarIsShow = !self.toolBarIsShow;
}

- (IBAction)playAction:(UIButton *)sender {
    [self playStopAction];
}
- (IBAction)playBtnCenterAction:(UIButton *)sender {
    [self playStopAction];
}

- (IBAction)sliderAction:(UISlider *)sender {
    CMTime time = CMTimeMake(self.player.totalDuration.value*sender.value, self.player.totalDuration.timescale);
    [self.player seekTo:time];
}
- (IBAction)fullScreenAction:(UIButton *)sender {
    if (self.fullScreenBtn.selected) {
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        TabBarController *target = [TabBarController shareTabBarController].selectedViewController;
        [target setValue:@(UIInterfaceOrientationMaskPortrait) forKey:@"interfaceOrientation"];
        [self dismissViewControllerAnimated:NO completion:^{
            [self.targetView addPlayViewWith:self];
        }];
    }else{
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
        UINavigationController *target = [TabBarController shareTabBarController].selectedViewController;
        [target presentViewController:self animated:NO completion:nil];
    }
    
    self.fullScreenBtn.selected = !self.fullScreenBtn.selected;
    self.isFullScreen = self.fullScreenBtn.selected;
    
    [UIViewController attemptRotationToDeviceOrientation];
}

- (void)changeProgress {
    float current=CMTimeGetSeconds(self.player.currentTime);
    float total=CMTimeGetSeconds(self.player.totalDuration);
    CGFloat value = current/total;
    [self.slider setValue:value animated:YES];
    
    NSString *currentTimeStr = [self timeStrWithSeconds:current];
    NSString *totalTimeStr = [self timeStrWithSeconds:total];
    NSString *timeStr = [NSString stringWithFormat:@"%@ / %@",currentTimeStr,totalTimeStr];
    self.timeL.text = timeStr;
    TCLog(@"current:%f total:%f timeStr:%@",current,total,timeStr);
}

- (NSString *)timeStrWithSeconds:(float)seconds {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:seconds];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = nil;
    if (components.day>0){
        time = [NSString stringWithFormat:@"%.2zd天%.2zd:%.2zd:%.2zd",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd:%.2zd:%.2zd",components.hour,components.minute,components.second];
    }else {
        time = [NSString stringWithFormat:@"%.2zd:%.2zd",components.minute,components.second];
    }
    return time;
}

- (void)playStopAction {
    if (self.playBtn.selected) {
        [self stopPlayer];
    }else{
        [self checkNetwork:^{
            [self startPlayer];
        }];
    }
}

- (void)startPlayer {
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.playBtnCenter.hidden = YES;
    [self.player play];
    
    self.playBtn.selected = YES;
    self.playBtnCenter.selected = YES;
}

- (void)stopPlayer {
    [self.player pause];
    [self.activityIndicatorView stopAnimating];
    self.playBtnCenter.hidden = NO;
    
    self.playBtn.selected = NO;
    self.playBtnCenter.selected = NO;
}

- (void)changeNetworkStatus {
    if (self.player.isPlaying) {
        [self checkNetwork:nil];
    }
}

- (void)checkNetwork:(void(^)())wifiBlock {
    AFNetworkReachabilityStatus status = [ReachabilityManager shareReachabilityManager].status;
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            if (wifiBlock) wifiBlock();
        }
            break;
        case AFNetworkReachabilityStatusNotReachable:
        {
            [self stopPlayer];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络连接不可用，请检查网络后重试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        default:
        {
            [self stopPlayer];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"正在使用非WiFi网络，播放将产生流量费用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self startPlayer];
            }];
            [controller addAction:action];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:cancelAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
    }
}

#pragma mark - PLPlayerDelegate

- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    TCLog(@"%s",__func__);
    
    switch (state) {
        case PLPlayerStatusCaching:
        {
            [self.activityIndicatorView startAnimating];
        }
            break;
        case PLPlayerStatusStopped:
        {
            [self stop];
        }
            break;
        default:
        {
            [self.activityIndicatorView stopAnimating];
        }
            break;
    }
    TCLog(@"%@", status[state]);
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    TCLog(@"%s",__func__);
    [self stop];
    [self tryReconnect:error];
}


#pragma mark PLPlayerDelegate helper

- (void)stop {
    [self.activityIndicatorView stopAnimating];
    self.playBtn.selected = NO;
    self.playBtnCenter.selected = self.playBtn.selected;
}

- (void)tryReconnect:(nullable NSError *)error {
    if (self.reconnectCount < 3) {
        _reconnectCount ++;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:[NSString stringWithFormat:@"错误 %@，播放器将在%.1f后进行第 %d 次重连", error.localizedDescription,0.5 * pow(2, self.reconnectCount - 1), _reconnectCount] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * pow(2, self.reconnectCount) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.player play];
        });
    }else {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:error.localizedDescription
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            __weak typeof(self) wself = self;
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction *action) {
                                                               __strong typeof(wself) strongSelf = wself;
                                                               //[strongSelf.navigationController performSelectorOnMainThread:@selector(popViewControllerAnimated:) withObject:@(YES) waitUntilDone:NO];
                                                           }];
            [alert addAction:cancel];
            //[self presentViewController:alert animated:YES completion:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        TCLog(@"%@", error);
    }
}

#pragma mark - orientation

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.isFullScreen) {
        return UIInterfaceOrientationMaskPortrait|
        UIInterfaceOrientationMaskLandscapeLeft|
        UIInterfaceOrientationMaskLandscapeRight|
        UIInterfaceOrientationMaskPortraitUpsideDown;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
    [NotificationCenter removeObserver:self name:kReachabilityStatusChangeNoti object:nil];
}
@end
