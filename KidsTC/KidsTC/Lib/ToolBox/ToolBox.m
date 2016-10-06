//
//  ToolBox.m
//  KidsTC
//
//  Created by zhanping on 7/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ToolBox.h"
#import "UILabel+Category.h"
#import "TTTAttributedLabel.h"

@implementation ToolBox

+ (NSString *)distanceDescriptionWithMeters:(NSUInteger)meters {
    NSString *des = @"";
    if (meters < 1000) {
        des = [NSString stringWithFormat:@"%lu米", (unsigned long)meters];
    } else {
        CGFloat km = meters / 1000.0;
        des = [NSString stringWithFormat:@"%.2f千米", km];
    }
    return des;
}

+ (CLLocationCoordinate2D)coordinateFromString:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    if ([string length] == 0) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    NSArray *components = [string componentsSeparatedByString:@","];
    if ([components count] != 2) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    
    NSString *lonString = [components firstObject];
    [lonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    CLLocationDegrees lon = [lonString doubleValue];
    
    NSString *latString = [components lastObject];
    [latString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    CLLocationDegrees lat = [latString doubleValue];
    
    return CLLocationCoordinate2DMake(lat, lon);
}

+ (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate {
    return [NSString stringWithFormat:@"%f,%f", coordinate.longitude, coordinate.latitude];
}

+ (id)getObjectFromNibWithView:(UIView *)view {
    UIView *nibView = [ToolBox getObjectFromNibWithClass:[view class]];
    [ToolBox replaceAutolayoutConstrainsFromView:view toView:nibView];
    return nibView;
}

+ (id)getObjectFromNibWithClass:(Class)aClass {
    
    NSString *className = NSStringFromClass(aClass);
    
    NSArray *topObjArray = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
    
    for (id anObj in topObjArray) {
        if ([anObj isKindOfClass:aClass]) {
            return anObj;
        }
    }
    
    return nil;
}

+ (void)replaceAutolayoutConstrainsFromView:(UIView *)placeholderView toView:(UIView *)realView {
    realView.autoresizingMask = placeholderView.autoresizingMask;
    realView.translatesAutoresizingMaskIntoConstraints = placeholderView.translatesAutoresizingMaskIntoConstraints;
    
    // Copy autolayout constrains from placeholder view to real view
    if (placeholderView.constraints.count > 0) {
        
        // We only need to copy "self" constraints (like width/height constraints)
        // from placeholder to real view
        for (NSLayoutConstraint *constraint in placeholderView.constraints) {
            
            NSLayoutConstraint* newConstraint;
            
            // "Height" or "Width" constraint
            // "self" as its first item, no second item
            if (!constraint.secondItem) {
                newConstraint =
                [NSLayoutConstraint constraintWithItem:realView
                                             attribute:constraint.firstAttribute
                                             relatedBy:constraint.relation
                                                toItem:nil
                                             attribute:constraint.secondAttribute
                                            multiplier:constraint.multiplier
                                              constant:constraint.constant];
            }
            // "Aspect ratio" constraint
            // "self" as its first AND second item
            else if ([constraint.firstItem isEqual:constraint.secondItem]) {
                newConstraint =
                [NSLayoutConstraint constraintWithItem:realView
                                             attribute:constraint.firstAttribute
                                             relatedBy:constraint.relation
                                                toItem:realView
                                             attribute:constraint.secondAttribute
                                            multiplier:constraint.multiplier
                                              constant:constraint.constant];
            }
            
            // Copy properties to new constraint
            if (newConstraint) {
                newConstraint.shouldBeArchived = constraint.shouldBeArchived;
                newConstraint.priority = constraint.priority;
                if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
                    newConstraint.identifier = constraint.identifier;
                }
                [realView addConstraint:newConstraint];
            }
        }
    }
}

+ (void)renderGradientForView:(UIView *)view displayFrame:(CGRect)frame startPoint:(CGPoint)start endPoint:(CGPoint)end colors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.startPoint = start;
    gradient.endPoint = end;
    if (colors) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (UIColor *color in colors) {
            [temp addObject:(id)(color.CGColor)];
        }
        gradient.colors = temp;
    }
    gradient.locations = locations;
    [view.layer insertSublayer:gradient atIndex:0];
}

+ (NSString *)jsonFromObject:(id)obj {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+ (void)resetLineView:(UIView *)view withLayoutAttribute:(NSLayoutAttribute)attribute {
    NSArray *leftBorderConstraintsArray = [view constraints];
    for (NSLayoutConstraint *constraint in leftBorderConstraintsArray) {
        if (constraint.firstAttribute == attribute) {
            //height constraint
            //new
            constraint.constant = LINE_H;
            break;
        }
    }
}

+ (void)resetLineView:(UIView *)view withLayoutAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant {
    NSArray *leftBorderConstraintsArray = [view constraints];
    for (NSLayoutConstraint *constraint in leftBorderConstraintsArray) {
        if (constraint.firstAttribute == attribute) {
            //height constraint
            //new
            constraint.constant = constant;
            break;
        }
    }
}

+ (CGFloat)heightForLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap andText:(NSString *)text {
    if ([text length] == 0) {
        return 0;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, font.pointSize)];
    [label setLineBreakMode:mode];
    [label setFont:font];
    [label setText:text];
    CGFloat height = [label sizeToFitWithMaximumNumberOfLines:0] + tGap + bGap;
    return height;
}

+ (CGFloat)heightForLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap maxLine:(NSUInteger)line andText:(NSString *)text {
    if ([text length] == 0) {
        return 0;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, font.pointSize)];
    [label setLineBreakMode:mode];
    [label setFont:font];
    [label setText:text];
    CGFloat height = [label sizeToFitWithMaximumNumberOfLines:line] + tGap + bGap;
    return height;
}

+ (CGFloat)heightForAttributeLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap maxLine:(NSUInteger)line andText:(NSString *)text {
    
    if ([text length] == 0) {
        return 0;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, font.pointSize)];
    [label setLineBreakMode:mode];
    [label setFont:font];
    [label setText:text];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    //自定义str和TTTAttributedLabel一样的行间距
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrapStyle setLineSpacing:8];
    //设置行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, text.length)];
    //设置字体
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    
    //得到自定义行间距的UILabel的高度
    CGFloat height = [TTTAttributedLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0].height + tGap + bGap;
    
    //    //重新改变tttLabel的frame高度
    //    CGRect rect = tttLabel.frame;
    //    rect.size.height = height;
    //    tttLabel.frame = rect;
    
    return height;
}

+ (void)drawLineOnView:(UIView *)view
        withStartPoint:(CGPoint)start
              endPoint:(CGPoint)end
             lineWidth:(CGFloat)width
                   gap:(CGFloat)gap
         sectionLength:(CGFloat)length
                 color:(UIColor *)color
             isVirtual:(BOOL)isVirtual {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色
    [shapeLayer setStrokeColor:color.CGColor];
    // 设置虚线的宽度
    [shapeLayer setLineWidth:width];
    [shapeLayer setLineJoin:kCALineJoinRound];
    if (isVirtual) {
        // 线段的长度和每条线的间距
        [shapeLayer setLineDashPattern: [NSArray arrayWithObjects:[NSNumber numberWithFloat:length], [NSNumber numberWithFloat:gap], nil]];
    }
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [view.layer addSublayer:shapeLayer];
}

+ (NSString *)countDownTimeStringWithLeftTime:(NSTimeInterval)leftTime {
    NSUInteger intTime = leftTime;
    
    NSUInteger day = intTime / 3600 / 24;
    NSUInteger hour = (intTime % (24 * 3600)) / 3600;
    NSUInteger minute = (intTime % 3600) / 60;
    NSUInteger second = (intTime % 3600) % 60;
    NSString *timeString = @"";
    if (day < 1) {
        timeString = [NSString stringWithFormat:@"%02lu时%02lu分%02lu秒", (unsigned long)hour, (unsigned long)minute, (unsigned long)second];
    } else {
        timeString = [NSString stringWithFormat:@"%lu天%02lu时%02lu分%02lu秒", (unsigned long)day, (unsigned long)hour, (unsigned long)minute, (unsigned long)second];
    }
    return timeString;
}
@end
