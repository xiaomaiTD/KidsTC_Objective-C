//
//  ChangeNickNameViewController.h
//  KidsTC
//
//  Created by zhanping on 7/27/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

@interface ChangeNickNameViewController : ViewController
@property (nonatomic, strong) NSString *oldNickName;
@property (nonatomic, copy) BOOL(^successBlock) (NSString *newNickName);
@end
