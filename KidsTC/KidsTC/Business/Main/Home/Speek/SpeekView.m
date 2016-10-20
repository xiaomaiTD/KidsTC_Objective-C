//
//  SpeekView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SpeekView.h"
#import "iflyMSC/IFlyMSC.h"

@interface SpeekView ()<IFlySpeechRecognizerDelegate>
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *animateIv;
@property (nonatomic, strong) UIButton *speekBtn;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, assign) BOOL isCanceled;
@end

@implementation SpeekView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTipLabel];
        
        [self setupAnimateIv];
        
        [self setupSpeekBtn];
        
        [self setupSpeechRecognizer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.animateIv.frame = self.animateIvFrame;
    self.speekBtn.frame = self.speekBtnFrame;
    self.tipLabel.frame = self.tipLabelFrame;
}

- (void)setupTipLabel {
    UILabel *tipLabel = [UILabel new];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:21];
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
}

- (CGRect)tipLabelFrame {
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    
    CGFloat tipLabel_x = 0;
    CGFloat tipLabel_y = 64;
    CGFloat tipLabel_w = self_w - tipLabel_x * 2;
    CGFloat tipLabel_h = 300;
    return CGRectMake(tipLabel_x, tipLabel_y, tipLabel_w, tipLabel_h);
}

- (void)setupAnimateIv {
    
    UIImageView *animateIv = [UIImageView new];
    [self addSubview:animateIv];
    self.animateIv = animateIv;
    int count = 11;
    animateIv.animationImages = [self images:count];
    animateIv.animationDuration = count * 0.2;
    animateIv.animationRepeatCount = CGFLOAT_MAX;
}

- (NSArray<UIImage *> *)images:(int)count {
    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"audio_wave_%zd",i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [images addObject:image];
        }
    }
    return [NSArray arrayWithArray:images];
}

- (CGRect)animateIvFrame {
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    CGFloat margin_b = 40;
    CGFloat animateIv_h = 80;
    CGFloat animateIv_x = 40;
    CGFloat animateIv_y = self_h - margin_b - animateIv_h;
    CGFloat animateIv_w = self_w - animateIv_x * 2;
    return CGRectMake(animateIv_x, animateIv_y, animateIv_w, animateIv_h);
}

- (void)setupSpeekBtn {
    UIButton *speekBtn = [UIButton new];
    [speekBtn setImage:[UIImage  imageNamed:@"audio_record_n"] forState:UIControlStateNormal];
    [speekBtn setImage:[UIImage imageNamed:@"audio_record_h"] forState:UIControlStateHighlighted];
    [speekBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:speekBtn];
    self.speekBtn = speekBtn;
}

- (CGRect)speekBtnFrame {
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    CGFloat margin_b = 40;
    CGFloat speekBtn_s = 80;
    CGFloat speekBtn_x = (self_w - speekBtn_s) * 0.5;
    CGFloat speekBtn_y = self_h - margin_b - speekBtn_s;
    
    return CGRectMake(speekBtn_x, speekBtn_y, speekBtn_s, speekBtn_s);
}

- (void)action:(UIButton *)btn {
    [self start];
}

- (void)viewWillAppear {
    _iFlySpeechRecognizer.delegate = self;
}
- (void)viewWillDisappear {
    _iFlySpeechRecognizer.delegate = nil;
    [_iFlySpeechRecognizer cancel];
}

- (void)setupSpeechRecognizer {
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"57ea3553"];
    [IFlySpeechUtility createUtility:initString];
    //1.创建语音听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iFlySpeechRecognizer.delegate = self;
}

- (void)start {
    [self startListening];
}

/**
 开始录音
 ****/
- (void)startListening {
    //设置为麦克风输入语音
    bool ret = [_iFlySpeechRecognizer startListening];
    if (ret) {
        TCLog(@"启动识别服务成功");
        [self startSuccess];
    }else{
        TCLog(@"启动识别服务失败，请稍后重试");
        [self startFailed];
    }
}

- (void)startSuccess {
    self.result = @"";
    self.tipLabel.text = @"请说出您心仪的商品";
    [self.animateIv startAnimating];
    self.speekBtn.hidden = YES;
}

- (void)startFailed {
    self.tipLabel.text = @"启动失败，请稍后再试！";
    [self.animateIv stopAnimating];
    self.speekBtn.hidden = NO;
    [self startListening];
}

- (void)speekEnd {
    self.tipLabel.text = @"正在识别您说的话…";
    [self.animateIv stopAnimating];
    self.speekBtn.hidden = YES;
}

- (void)recognizeSuccess {
    self.tipLabel.text = self.result;
    [self.animateIv stopAnimating];
    self.speekBtn.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(speekView:actionTyp:value:)]) {
        [self.delegate speekView:self actionTyp:SpeekViewActionTypeRecognizeSuccess value:self.result];
    }
}

- (void)recognizeFailed {
    self.tipLabel.text = @"未识别出您说出的话\n请点击话筒的重说";
    [self.animateIv stopAnimating];
    self.speekBtn.hidden = NO;
}

#pragma mark - IFlySpeechRecognizerDelegate

/*!
 *  音量变化回调
 *    在录音过程中，回调音频的音量。
 *
 *  @param volume -[out] 音量，范围从0-30
 */
- (void) onVolumeChanged: (int)volume{
    
}

/*!
 *  开始录音回调
 *   当调用了`startListening`函数之后，如果没有发生错误则会回调此函数。
 *  如果发生错误则回调onError:函数
 */
- (void) onBeginOfSpeech{
    
}

/*!
 *  停止录音回调
 *   当调用了`stopListening`函数或者引擎内部自动检测到断点，如果没有发生错误则回调此函数。
 *  如果发生错误则回调onError:函数
 */
- (void) onEndOfSpeech{
    [self speekEnd];
}

/*!
 *  取消识别回调
 *    当调用了`cancel`函数之后，会回调此函数，在调用了cancel函数和回调onError之前会有一个
 *  短暂时间，您可以在此函数中实现对这段时间的界面显示。
 */
- (void) onCancel{
    
}

/*!
 *  识别结果回调
 *    在进行语音识别过程中的任何时刻都有可能回调此函数，你可以根据errorCode进行相应的处理，
 *  当errorCode没有错误时，表示此次会话正常结束；否则，表示此次会话有错误发生。特别的当调用
 *  `cancel`函数时，引擎不会自动结束，需要等到回调此函数，才表示此次会话结束。在没有回调此函数
 *  之前如果重新调用了`startListenging`函数则会报错误。
 *
 *  @param errorCode 错误描述
 */
- (void) onError:(IFlySpeechError *) error{
    
    NSString *text;
    if (error.errorCode == 0 ) {
        if (_result.length == 0) {
            text = @"无识别结果";
        }else {
            text = @"识别成功";
        }
    }else {
        text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
    TCLog(@"%@",text);
}

/*!
 *  识别结果回调
 *    在识别过程中可能会多次回调此函数，你最好不要在此回调函数中进行界面的更改等操作，只需要将回调的结果保存起来。
 *  使用results的示例如下：
 *  <pre><code>
 *  - (void) onResults:(NSArray *) results{
 *     NSMutableString *result = [[NSMutableString alloc] init];
 *     NSDictionary *dic = [results objectAtIndex:0];
 *     for (NSString *key in dic){
 *        [result appendFormat:@"%@",key];//合并结果
 *     }
 *   }
 *  </code></pre>
 *
 *  @param results  -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度。
 *  @param isLast   -[out] 是否最后一个结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [self stringFromJson:resultString];
    self.result = [NSString stringWithFormat:@"%@%@",self.result,resultFromJson];
    
    if (isLast){
        TCLog(@"听写结果：%@",  self.result);
        self.result = [self stringByTrimming:self.result];
        if (self.result.length>0) {
            [self recognizeSuccess];
        }else{
            [self recognizeFailed];
        }
    }
}

#pragma mark IFlySpeechRecognizerDelegate Helper

- (NSString *)stringByTrimming:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\",.，。"];
    NSArray<NSString *> *results = [params componentsSeparatedByCharactersInSet:set];
    NSMutableString *string = [NSMutableString string];
    [results enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:obj];
    }];
    return [NSString stringWithFormat:@"%@",string];
}

/**
 解析听写json格式的数据
 params例如：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 ****/
- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}


@end
