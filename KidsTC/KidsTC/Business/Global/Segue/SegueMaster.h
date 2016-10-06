//
//  SegueMaster.h
//  KidsTC
//
//  Created by Altair on 12/5/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueModel.h"

@interface SegueMaster : NSObject
#define NotificationSegueTag (100001)
+ (UIViewController *)makeSegueWithModel:(SegueModel *)model
                          fromController:(UIViewController *)fromVC;

@end
