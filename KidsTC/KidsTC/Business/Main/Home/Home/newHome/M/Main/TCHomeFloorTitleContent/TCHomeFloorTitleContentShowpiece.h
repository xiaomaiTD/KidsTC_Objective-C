//
//  TCHomeFloorTitleContentShowpiece.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCHomeFloorTitleContent;
@interface TCHomeFloorTitleContentShowpiece : NSObject

@property (nonatomic, strong) UIColor *tipImageViewBGColor;
@property (nonatomic, strong) UIImage *tipImageViewImg;

@property (nonatomic, strong) NSAttributedString *attName;
@property (nonatomic, strong) NSAttributedString *attSubName;
@property (nonatomic, strong) NSAttributedString *countDownValueString;
+ (instancetype)showpice:(TCHomeFloorTitleContent *)titleContent;
@end
