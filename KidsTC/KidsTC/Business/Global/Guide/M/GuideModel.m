//
//  GuideModel.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "GuideModel.h"

@implementation GuideDataItem

- (instancetype)initWithImageName:(NSString *)imageName
               btnCanShow:(BOOL)btnCanShow
             btnImageName:(NSString *)btnImageName
                 btnFrame:(CGRect)btnFrame
{
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.btnCanShow = btnCanShow;
        self.btnImageName = btnImageName;
        self.btnFrame = btnFrame;
    }
    return self;
}

+(instancetype)itemWithImageName:(NSString *)imageName
                      btnCanShow:(BOOL)btnCanShow
                    btnImageName:(NSString *)btnImageName
                        btnFrame:(CGRect)btnFrame
{
    return [[self alloc] initWithImageName:imageName
                                btnCanShow:btnCanShow
                              btnImageName:btnImageName
                                  btnFrame:btnFrame];
}
@end

@implementation GuideModel
- (instancetype)initWithDatas:(NSArray<GuideDataItem *> *)datas{
    self = [super init];
    if (self) {
        self.datas = datas;
    }
    return self;
}
+(instancetype)modelWithDatas:(NSArray<GuideDataItem *> *)datas{
    return [[self alloc]initWithDatas:datas];
}
@end
