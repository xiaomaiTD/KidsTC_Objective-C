//
//  ComposeData.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeBtn.h"
#import "ComposeClass.h"
@interface ComposeData : Model
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) ComposeBtn *leftTopBtn;
@property (nonatomic, strong) ComposeBtn *rightTopBtn;
@property (nonatomic, strong) NSArray<ComposeClass *> *articleClasses;
@property (nonatomic, strong) ComposeBtn *middleBtn;
@property (nonatomic, strong) NSString *signInPageUrl;
@property (nonatomic, assign) BOOL isSignInPageApp;
@end
