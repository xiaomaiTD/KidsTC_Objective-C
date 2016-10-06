//
//  ZPDownloadView.m
//  ZPDownloadView
//
//  Created by 詹平 on 16/4/23.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ZPProgress.h"


//类型1
#define TypeOneEllipseRadius 20 //半径

//类型2
#define TypeTwoEllipseRadius 20 //半径
#define TypeTwoEllipseLineWidth 2 //圆的的线条宽度

//类型3
#define TypeThreeInnerEllipseRadius 20   //内圆半径
#define TypeThreeOuterEllipseLineWidth 2 //外圆线条宽度

//类型4
#define TypeFourInnerEllipseRadius 30   //内圆半径
#define TypeFourOuterEllipseLineWidth 5 //外圆线条宽度


@implementation ZPProgress

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    //[self drawTypeOneRect:rect];
    
    [self drawTypeTwoRect:rect];
    
    //[self drawTypeThreeRect:rect];

    
    //[self drawTypeTwoRect:rect];
    
}

- (void)drawTypeOneRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    
    //画内圆
    CGFloat centerX = rect.size.width*0.5;
    CGFloat centerY = rect.size.height*0.5;
    CGContextSetLineWidth(ctx, TypeOneEllipseRadius);
    CGContextAddArc(ctx, centerX, centerY, TypeOneEllipseRadius*0.5, M_PI_2*3, M_PI_2*3+self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx);
}

- (void)drawTypeTwoRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    
    //画内圆
    CGFloat centerX = rect.size.width*0.5;
    CGFloat centerY = rect.size.height*0.5;
    CGContextSetLineWidth(ctx, TypeTwoEllipseLineWidth);
    CGContextAddArc(ctx, centerX, centerY, TypeTwoEllipseRadius - TypeTwoEllipseLineWidth*0.5, M_PI_2*3, M_PI_2*3+self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx);
}

- (void)drawTypeThreeRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    
    //画内圆
    CGFloat centerX = rect.size.width*0.5;
    CGFloat centerY = rect.size.height*0.5;
    CGContextSetLineWidth(ctx, TypeThreeInnerEllipseRadius);
    CGContextAddArc(ctx, centerX, centerY, TypeThreeInnerEllipseRadius*0.5, M_PI_2*3, M_PI_2*3 + self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx);
    
    //画内外圆
    CGContextSetLineWidth(ctx, TypeThreeOuterEllipseLineWidth);
    CGContextAddArc(ctx, centerX, centerY, TypeThreeInnerEllipseRadius+1.5*TypeThreeOuterEllipseLineWidth, M_PI_2*3,M_PI_2*3 + M_PI*2, 0);
    CGContextStrokePath(ctx);
}

- (void)drawTypeFourRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    
    //画内圆
    CGFloat centerX = rect.size.width*0.5;
    CGFloat centerY = rect.size.height*0.5;
    CGContextSetLineWidth(ctx, TypeFourInnerEllipseRadius);
    CGContextAddArc(ctx, centerX, centerY, TypeFourInnerEllipseRadius*0.5, M_PI_2*3, M_PI_2*3+M_PI*2, 0);
    CGContextStrokePath(ctx);
    
    //画内外圆
    CGContextSetLineWidth(ctx, TypeFourOuterEllipseLineWidth);
    CGContextAddArc(ctx, centerX, centerY, TypeFourInnerEllipseRadius+1.5*TypeFourOuterEllipseLineWidth, M_PI_2*3, M_PI_2*3 + self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx);
}



@end
