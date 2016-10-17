//
//  SpeekViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SpeekViewController.h"
#import "iflyMSC/IFlyMSC.h"

@interface SpeekViewController ()<IFlySpeechRecognizerDelegate>
//语音语义理解对象
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;
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
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    _iFlySpeechUnderstander = [IFlySpeechUnderstander sharedInstance];
    _iFlySpeechUnderstander.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self stop];
}

/**
 开始录音
 ****/
- (void)start {
    //设置为麦克风输入语音
    bool ret = [_iFlySpeechUnderstander startListening];
    if (ret) {
        NSLog(@"启动识别服务成功");
    }else{
        NSLog(@"启动识别服务失败，请稍后重试");
    }
}

/**
 停止录音
 ****/
- (void)stop {
    [_iFlySpeechUnderstander stopListening];
}

#pragma mark - 识别回调 IFlySpeechRecognizerDelegate


/**
 语义理解服务结束回调（注：无论是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSString * text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
    NSLog(@"%@",text);
}


/**
 语义理解结果回调
 result 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = results [0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    NSLog(@"听写结果：%@",result);
}


@end
