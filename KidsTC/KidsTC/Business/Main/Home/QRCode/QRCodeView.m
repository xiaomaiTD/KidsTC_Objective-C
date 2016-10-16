//
//  QRCodeView.m
//  005-QRCodeDeom
//
//  Created by 詹平 on 2016/10/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "QRCodeView.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeAnimateView.h"

typedef enum : NSUInteger {
    QRCodeViewInputTypeScan=1,//扫描
    QRCodeViewInputTypeTfInput//输入
} QRCodeViewInputType;

#define x_marigin_scale 0.15

@interface QRCodeView ()<AVCaptureMetadataOutputObjectsDelegate,UITextFieldDelegate>
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) CALayer *drawLayer;
@property (nonatomic, strong) CAShapeLayer *coverLayer;

@property (nonatomic, strong) QRCodeAnimateView *animateView;
@property (nonatomic, strong) UITextField *tf;

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *lightBtn;
@property (nonatomic, strong) UIButton *barCodeBtn;
@property (nonatomic, strong) UIButton *inputSureBtn;
@property (nonatomic, assign) QRCodeViewInputType inputType;
@end

@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScan];
        
        [self setupCover];
        
        [self setupAnimate];
        
        [self setupTf];
        
        [self setupTip];
        
        [self setupLightBtn];
        
        [self setupBarCodeBtn];
        
        [self setupInputSureBtn];
        
        self.inputType = QRCodeViewInputTypeScan;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.previewLayer.frame = self.bounds;
    self.drawLayer.frame = self.previewLayer.bounds;
    self.coverLayer.mask = self.maskLayer;
    self.animateView.frame = self.scanRect;
    self.tf.frame = self.scanRect;
    self.tipLabel.frame = self.tipLabelFrame;
    self.lightBtn.frame = self.lightBtnFrame;
    self.lightBtn.layer.cornerRadius = CGRectGetHeight(self.lightBtn.frame) * 0.5;
    self.barCodeBtn.frame = self.barCodeBtnFrame;
    self.barCodeBtn.layer.cornerRadius = CGRectGetHeight(self.barCodeBtn.frame) * 0.5;
    self.inputSureBtn.frame = self.inputSureBtnFrame;
    self.inputSureBtn.layer.cornerRadius = CGRectGetHeight(self.inputSureBtn.frame) * 0.5;
    switch (self.inputType) {
        case QRCodeViewInputTypeScan:
        {
            self.tf.hidden = YES;
            self.tipLabel.hidden = NO;
            self.lightBtn.hidden = NO;
            self.inputSureBtn.hidden = YES;
        }
            break;
            
        case QRCodeViewInputTypeTfInput:
        {
            self.tf.hidden = NO;
            self.tipLabel.hidden = YES;
            self.lightBtn.hidden = YES;
            self.inputSureBtn.hidden = NO;
        }
            break;
    }
}

- (void)startScan {
    [self.session startRunning];
    [self.animateView startAnimate];
}

- (void)stopScan {
    [self.session stopRunning];
    [self.animateView stopAnimate];
}

- (CGRect)scanRect {
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    switch (self.inputType) {
        case QRCodeViewInputTypeScan:
        {
            CGFloat scanRect_s = self_w * (1 - x_marigin_scale * 2);
            CGFloat scanRect_x = self_w * x_marigin_scale;
            CGFloat scanRect_y = (self_h - scanRect_s) * 0.5;
            return CGRectMake(scanRect_x, scanRect_y, scanRect_s, scanRect_s);
        }
            break;
            
        case QRCodeViewInputTypeTfInput:
        {
            CGFloat scanRect_s = self_w * (1 - x_marigin_scale * 2);
            CGFloat scanRect_x = self_w * x_marigin_scale;
            CGFloat scanRect_y = (self_h - scanRect_s) * 0.5;
            return CGRectMake(scanRect_x, scanRect_y, scanRect_s, 50);
        }
            break;
    }
}

-  (void)setupScan {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) {
        NSLog(@"input输入创建失败");
        return;
    }
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if (!output) {
        NSLog(@"ouput输出创建失败");
        return;
    }
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    CGFloat size = self_w * (1 - 2 * x_marigin_scale);
    CGFloat minY = (self_h - size) * 0.5 / self_h;
    CGFloat maxY = (self_h + size) * 0.5 / self_h;
    output.rectOfInterest = CGRectMake(minY, x_marigin_scale, maxY, 1 - x_marigin_scale * 2);
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if (![session canAddInput:input] || ![session canAddOutput:output]) {
        NSLog(@"当前设备不可添加输入或输出");
        return;
    }
    [session addInput:input];
    [session addOutput:output];
    self.session = session;
    
    [output setMetadataObjectTypes:output.availableMetadataObjectTypes];
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:previewLayer];
    self.previewLayer = previewLayer;
    
    CALayer *drawLayer = [CALayer layer];
    [previewLayer addSublayer:drawLayer];
    self.drawLayer = drawLayer;
}

- (void)setupCover {
    
    CAShapeLayer *coverLayer = [CAShapeLayer layer];
    coverLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    coverLayer.fillColor = [UIColor colorWithWhite: 0 alpha: 0.5].CGColor;
    [self.layer addSublayer:coverLayer];
    self.coverLayer = coverLayer;
}

- (CAShapeLayer *)maskLayer {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [maskPath appendPath:[[UIBezierPath bezierPathWithRect:self.scanRect] bezierPathByReversingPath]];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

- (void)setupAnimate {
    QRCodeAnimateView *animateView = [[QRCodeAnimateView alloc] init];
    [self addSubview:animateView];
    self.animateView = animateView;
}

- (void)setupTf {
    UITextField *tf = [[UITextField alloc] init];
    tf.backgroundColor = [UIColor whiteColor];
    tf.font = [UIFont systemFontOfSize:21];
    tf.placeholder = @"请输入条形码";
    tf.delegate = self;
    [self addSubview:tf];
    self.tf = tf;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tfTextDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setupTip {
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"对准二维码/条形码到框内即可扫描";
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
}

- (CGRect)tipLabelFrame {
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat tipLabel_w = self_w;
    CGFloat tipLabel_h = 21;
    CGFloat tipLabel_x = 0;
    CGFloat tipLabel_y = CGRectGetMinY(self.scanRect) - tipLabel_h - 12;
    return CGRectMake(tipLabel_x, tipLabel_y, tipLabel_w, tipLabel_h);
}


- (void)setupLightBtn {
    UIButton *lightBtn = [[UIButton alloc] init];
    [lightBtn setImage:[UIImage imageNamed:@"newbarcode_light_off"] forState:UIControlStateNormal];
    [lightBtn setImage:[UIImage imageNamed:@"newbarcode_light_on"] forState:UIControlStateSelected];
    lightBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    lightBtn.layer.masksToBounds = YES;
    [lightBtn addTarget:self action:@selector(light:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lightBtn];
    self.lightBtn = lightBtn;
}

- (CGRect)lightBtnFrame {
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat btn_s = 40;
    CGFloat btn_x = (self_w - btn_s) * 0.5;
    CGFloat btn_y = CGRectGetMaxY(self.scanRect) + 12;
    return CGRectMake(btn_x, btn_y, btn_s, btn_s);
}

- (void)setupBarCodeBtn {
    UIButton *barCodeBtn = [[UIButton alloc] init];
    barCodeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    barCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [barCodeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    
    [barCodeBtn setImage:[UIImage imageNamed:@"newbarcode_shurutiaoma_icon"] forState:UIControlStateNormal];
    [barCodeBtn setTitle:@"输入条码  " forState:UIControlStateNormal];
    [barCodeBtn setImage:[UIImage imageNamed:@"OrderInfo_GiftCard_ScanBtn"] forState:UIControlStateSelected];
    [barCodeBtn setTitle:@"  切换扫码" forState:UIControlStateSelected];
    
    barCodeBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    barCodeBtn.layer.masksToBounds = YES;
    [barCodeBtn addTarget:self action:@selector(changeBarCode:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:barCodeBtn];
    self.barCodeBtn = barCodeBtn;
}

- (CGRect)barCodeBtnFrame {
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat btn_w = 130;
    CGFloat btn_h = 40;
    CGFloat btn_x;
    CGFloat btn_y;
    switch (self.inputType) {
        case QRCodeViewInputTypeScan:
        {
            btn_x = (self_w - btn_w) * 0.5;
            btn_y = CGRectGetMaxY(self.lightBtn.frame) + 24;
        }
            break;
            
        case QRCodeViewInputTypeTfInput:
        {
            btn_x = (self_w * 0.5 - btn_w) * 0.5;
            btn_y = CGRectGetMaxY(self.scanRect) + 20;
        }
            break;
    }
    return CGRectMake(btn_x, btn_y, btn_w, btn_h);
}

- (void)setupInputSureBtn {
    UIButton *inputSureBtn = [[UIButton alloc] init];
    inputSureBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    inputSureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [inputSureBtn setTitle:@"完成" forState:UIControlStateNormal];
    inputSureBtn.layer.masksToBounds = YES;
    [inputSureBtn addTarget:self action:@selector(inputSure:) forControlEvents:UIControlEventTouchUpInside];
    [inputSureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [inputSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inputSureBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    inputSureBtn.enabled = NO;
    [self addSubview:inputSureBtn];
    self.inputSureBtn = inputSureBtn;
}

- (CGRect)inputSureBtnFrame {
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat btn_w = 130;
    CGFloat btn_h = 40;
    CGFloat btn_x = (self_w * 1.5 - btn_w) * 0.5;
    CGFloat btn_y = CGRectGetMaxY(self.scanRect) + 20;
    return CGRectMake(btn_x, btn_y, btn_w, btn_h);
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self clearConers];
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            self.tipLabel.text = object.stringValue;
            AVMetadataMachineReadableCodeObject *newObj = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:object];
            NSLog(@"%@", newObj);
            [self drawCorners:newObj];
        }else{
            NSLog(@"没有扫描到数据");
        }
    } else {
        NSLog(@"没有扫描到数据");
    }
}

- (void)clearConers {
    if (self.drawLayer.sublayers.count==0) {
        return;
    }
    [self.drawLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)drawCorners:(AVMetadataMachineReadableCodeObject *)obj {
    
    if (obj.corners.count==0) {
        return;
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point = CGPointZero;
    int index = 0;
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)obj.corners[index++], &point);
    [path moveToPoint:point];
    while (index<obj.corners.count) {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)obj.corners[index++], &point);
        [path addLineToPoint:point];
    }
    [path closePath];
    layer.path = path.CGPath;
    
    [self.drawLayer addSublayer:layer];
}

#pragma mark - UITextFieldDelegate

- (void)tfTextDidChanged {
    
    if (self.tf.text.length>0) {
        self.inputSureBtn.backgroundColor = [UIColor blueColor];
        self.inputSureBtn.enabled = YES;
    }else{
        self.inputSureBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.inputSureBtn.enabled = NO;
    }
}

- (void)light:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self turnTorchOn:btn.selected];
}

- (void)turnTorchOn:(BOOL)on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
#pragma clang diagnostic pop
            [device unlockForConfiguration];
        }
    }
}

- (void)changeBarCode:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.lightBtn.selected = YES;
    [self light:self.lightBtn];
    if (btn.selected) {
        [self stopScan];
        [self.tf becomeFirstResponder];
        self.inputType = QRCodeViewInputTypeTfInput;
    }else{
        [self startScan];
        [self.tf resignFirstResponder];
        self.inputType = QRCodeViewInputTypeScan;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)inputSure:(UIButton *)btn {
    
}

- (void)dealloc {
    [self stopScan];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
