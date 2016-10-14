//
//  QRCodeScanViewController.m
//  QRCodeDemo
//
//  Created by 詹平 on 2016/10/2.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#define CONTENTVIEW_SIZE 300
#define TABBAR_HEIGHT 49


@interface QRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *borderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstratint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstratint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanImageViewTopConstraint;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) CALayer *drawLayer;

@end

@implementation QRCodeScanViewController

- (CALayer *)drawLayer{
    if (!_drawLayer) {
        _drawLayer = [CALayer layer];
        _drawLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _drawLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码/条形码";
    
    [self setupScanImageView:- self.contentViewHeightConstratint.constant];
    
    self.tabBar.selectedItem = self.tabBar.items[0];
    
    [self startScan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animate];
}

-  (void)startScan {
    
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
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if (![session canAddInput:input] || ![session canAddOutput:output]) {
        NSLog(@"当前设备不可添加输入或输出");
        return;
    }
    [session addInput:input];
    [session addOutput:output];
    
    [output setMetadataObjectTypes:output.availableMetadataObjectTypes];
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    [previewLayer addSublayer:self.drawLayer];
    
    [session startRunning];
}

- (void)animate {
    
    [self setupScanImageView:-self.contentViewHeightConstratint.constant];
    
    [UIView beginAnimations:@"hello" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationRepeatCount:CGFLOAT_MAX];
    [self setupScanImageView:self.contentViewHeightConstratint.constant];
    [UIView commitAnimations];
}

- (void)setupScanImageView:(CGFloat)constant {
    self.scanImageViewTopConstraint.constant = constant;
    [self.contentView layoutIfNeeded];
}

- (IBAction)dismiss:(id)sender {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    self.contentViewHeightConstratint.constant = self.contentViewWidthConstratint.constant * (item.tag==1?1:0.5);
    [self.contentView layoutIfNeeded];
    
    self.scanImageView.image = [UIImage imageNamed:(item.tag==1?@"qrcode_scanline_qrcode":@"qrcode_scanline_barcode")];
    
    [self.scanImageView.layer removeAllAnimations];
    [self animate];
}

@end
