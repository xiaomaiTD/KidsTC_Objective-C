//
//  WebFailureView.m
//  KidsTC
//
//  Created by zhanping on 8/30/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WebFailureView.h"

@implementation WebFailureView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.actionBlock) self.actionBlock(self);
}

@end
