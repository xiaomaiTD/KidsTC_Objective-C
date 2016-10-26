//
//  ComposeModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeMd5Data.h"

@interface ComposeModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ComposeMd5Data *data;
@end
