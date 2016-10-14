//
//  QRCodeMyCodeViewController.m
//  QRCodeDemo
//
//  Created by 詹平 on 2016/10/2.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "QRCodeMyCodeViewController.h"

@interface QRCodeMyCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QRCodeMyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的二维码";
    
    [self generateQRCode:@"http://baike.baidu.com/link?url=x6z979lBkPIY5KcrB6PU3tuOuvpK6ePJt06oMqxKhP2YoHOaTGB578xntlUdSGFuzFtmw3hg7nJKzTCVeWP9QgM8MDQVuo-M9TG2pDtDfIFwl4_f7aLwrNKuktEmOWoq-d3SXMNYkqZVhcMa8pttL_"];
}

- (void)generateQRCode:(NSString *)dataString{
    
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    UIImage *bgImage = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:300];
    
//    NSString *iconImageName = [NSString stringWithFormat:@"%zd",arc4random()%38];
//    UIImage *iconImage = [self createRoundedRectImage:[UIImage imageNamed:iconImageName] withSize:CGSizeMake(62, 62) withRadius:8];
//    UIImage *newImage = [self generateIconImage:bgImage iconImage:iconImage];
    
    self.imageView.image = bgImage;
}

static void addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
    float fw, fh;
    if (widthOfRadius == 0 || heightOfRadius == 0)
    {
        CGContextAddRect(contextRef, rect);
        return;
    }

    CGContextSaveGState(contextRef);
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    fw = CGRectGetWidth(rect) / widthOfRadius;
    fh = CGRectGetHeight(rect) / heightOfRadius;

    CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    CGContextClosePath(contextRef);
    CGContextRestoreGState(contextRef);
}

#pragma mark - Public Methods
- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
     int w = size.width;
     int h = size.height;

     CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
     CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
     CGRect rect = CGRectMake(0, 0, w, h);

     CGContextBeginPath(contextRef);
     addRoundedRectToPath(contextRef, rect, radius, radius);
     CGContextClosePath(contextRef);
     CGContextClip(contextRef);
     CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
     CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
     UIImage *img = [UIImage imageWithCGImage:imageMasked];

     CGContextRelease(contextRef);
     CGColorSpaceRelease(colorSpaceRef);
     CGImageRelease(imageMasked);
     return img;
}

- (UIImage *)generateIconImage:(UIImage *)bgImage iconImage:(UIImage *)iconImage {
    
    CGSize bgSize = bgImage.size;
    
    UIGraphicsBeginImageContext(bgSize);
    [bgImage drawInRect:CGRectMake(0, 0, bgSize.width, bgSize.height)];
    
    CGFloat icon_w = 62;
    CGFloat icon_h = icon_w;
    CGFloat icon_x = (bgSize.width - icon_w) * 0.5;
    CGFloat icon_y = (bgSize.height - icon_h) * 0.5;
    CGRect icon_drawRect = CGRectMake(icon_x, icon_y, icon_w, icon_h);
    [iconImage drawInRect:icon_drawRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
