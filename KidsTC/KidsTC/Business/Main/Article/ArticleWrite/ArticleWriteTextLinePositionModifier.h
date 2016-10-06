//
//  ArticleWriteTextLinePositionModifier.h
//  KidsTC
//
//  Created by zhanping on 2016/9/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h"

@interface ArticleWriteTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;
@end
