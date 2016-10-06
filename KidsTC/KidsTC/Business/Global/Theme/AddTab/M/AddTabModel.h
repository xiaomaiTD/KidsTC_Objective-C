//
//  AddTabModel.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"

@interface AddTabData : Model
@property (nonatomic, assign) NSTimeInterval expireTime;
@property (nonatomic, strong) NSString *fImg;
@property (nonatomic, strong) NSString *sImg;
@property (nonatomic, strong) NSString *url;
@end

@interface AddTabModel : Model
@property (nonatomic, assign) BOOL downloaded;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) AddTabData *data;
@end
