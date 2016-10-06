//
//  WebFailureView.h
//  KidsTC
//
//  Created by zhanping on 8/30/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebFailureView : UIView
@property (nonatomic, copy) void (^actionBlock)(WebFailureView *webFailureView);
@end
