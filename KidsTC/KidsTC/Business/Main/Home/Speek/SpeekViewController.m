//
//  SpeekViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SpeekViewController.h"
#import "iflyMSC/IFlyMSC.h"
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlyRecognizerView.h>

@interface SpeekViewController ()<IFlyRecognizerViewDelegate>{
    IFlyRecognizerView      *_iflyRecognizerView;
}
@end

@implementation SpeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"语音输入";
    
    CGFloat margin = 20;
    CGFloat btnHeight = 44;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(margin, SCREEN_HEIGHT - btnHeight - margin * 2, SCREEN_WIDTH - margin*2, btnHeight)];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = COLOR_PINK;
    [btn setTitle:@"按住说话" forState:UIControlStateNormal];
    [btn setTitle:@"释放" forState:UIControlStateFocused];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    
    //初始化语音识别控件
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:@"asrview.pcm " forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}

- (void)start {
    //启动识别服务
    [_iflyRecognizerView start];
}

- (void)cancel {
    //启动识别服务
    [_iflyRecognizerView cancel];
}

/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast
{
    NSLog(@"resultArray:%@",resultArray);
    [resultArray enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"json-str:%@",str);
    }];
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"error:%@",error);
}

@end
