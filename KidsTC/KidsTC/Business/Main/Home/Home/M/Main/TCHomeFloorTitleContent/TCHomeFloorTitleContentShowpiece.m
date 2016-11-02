//
//  TCHomeFloorTitleContentShowpiece.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorTitleContentShowpiece.h"
#import "TCHomeFloorTitleContent.h"
#import "NSAttributedString+YYText.h"

@interface TCHomeFloorTitleContentShowpiece ()
@property (nonatomic, strong) TCHomeFloorTitleContent *titleContent;
@end

@implementation TCHomeFloorTitleContentShowpiece

+ (instancetype)showpice:(TCHomeFloorTitleContent *)titleContent {
    TCHomeFloorTitleContentShowpiece *showpiece = [TCHomeFloorTitleContentShowpiece new];
    showpiece.titleContent = titleContent;
    return showpiece;
}

- (void)setTitleContent:(TCHomeFloorTitleContent *)titleContent {
    _titleContent = titleContent;
    [self setupAttributes];
}

- (void)setupAttributes {
    NSString *name = [NSString stringWithFormat:@"%@",_titleContent.name];
    NSString *subName = [NSString stringWithFormat:@"%@",_titleContent.subName];
    
    switch (_titleContent.type) {
        case TCHomeFloorTitleContentTypeNormalTitle:
        case TCHomeFloorTitleContentTypeMoreTitle:
        {
            _tipImageViewBGColor = COLOR_PINK;
            _tipImageViewImg = nil;
            
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:16];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeCountDownTitle:
        case TCHomeFloorTitleContentTypeCountDownMoreTitle:
        {
            _tipImageViewBGColor = COLOR_PINK;
            _tipImageViewImg = nil;
            
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:16];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeRecommend:
        {
            _tipImageViewBGColor = [UIColor clearColor];
            _tipImageViewImg = [UIImage imageNamed:@"homeRecommendTip"];
            
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:14];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
    }
}

- (NSAttributedString *)countDownValueString{
    
    if (_titleContent.remainTime<=0) return nil;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_titleContent.remainTime];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    
    NSString *timeStr = @"";
    if (components.year>0) {
        timeStr = [NSString stringWithFormat:@"%.2zd年%.2zd月%.2zd天%.2zd:%.2zd:%.2zd ",components.year,components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.month>0){
        timeStr = [NSString stringWithFormat:@"%.2zd月%.2zd天%.2zd:%.2zd:%.2zd ",components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.day>0){
        timeStr = [NSString stringWithFormat:@"%.2zd天%.2zd:%.2zd:%.2zd ",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        timeStr = [NSString stringWithFormat:@"%.2zd:%.2zd:%.2zd ",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        timeStr = [NSString stringWithFormat:@"%.2zd:%.2zd ",components.minute,components.second];
    }else if (components.second>=0){
        timeStr = [NSString stringWithFormat:@"%.2zd ",components.second];
    }
    _titleContent.remainTime--;
    
    static NSMutableAttributedString *oneStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        UIImage *image = [[UIImage imageNamed:@"countDonw_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        //        attachment.bounds = CGRectMake(0, -3, font.lineHeight-2, font.lineHeight-2);
        //        attachment.image = image;
        //        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSDictionary *countDownStrAtt = @{NSFontAttributeName:font,
                                          NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        oneStr = [[NSMutableAttributedString alloc]init];
        //        [oneStr appendAttributedString:imageStr];
        
        NSString *remainTitle = [NSString stringWithFormat:@" %@ | ",_titleContent.remainName];
        NSMutableAttributedString *leftStr = [[NSMutableAttributedString alloc]initWithString:remainTitle attributes:countDownStrAtt];
        [oneStr appendAttributedString:leftStr];
    });
    
    
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc]init];
    [totalStr appendAttributedString:oneStr];
    
    NSDictionary *timeAtt = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:COLOR_PINK};
    NSAttributedString *timerAttString = [[NSAttributedString alloc]initWithString:timeStr attributes:timeAtt];
    [totalStr appendAttributedString:timerAttString];
    
    return totalStr;
}
@end
