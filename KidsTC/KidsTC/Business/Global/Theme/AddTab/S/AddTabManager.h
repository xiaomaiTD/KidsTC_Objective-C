//
//  AddTabManager.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "Theme.h"
@interface AddTabManager : NSObject
singleH(AddTabManager)
@property (nonatomic, strong) TabBarItemElement *addElement;
- (void)synchronize;
@end
