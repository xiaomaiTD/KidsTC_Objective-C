//
//  GuideModel.h
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "Model.h"

@interface GuideDataItem : Model
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) BOOL btnCanShow;
@property (nonatomic, strong) NSString *btnImageName;
@property (nonatomic, assign) CGRect btnFrame;
+(instancetype)itemWithImageName:(NSString *)imageName
                      btnCanShow:(BOOL)btnCanShow
                    btnImageName:(NSString *)btnImageName
                        btnFrame:(CGRect)btnFrame;
@end

@interface GuideModel : Model
@property (nonatomic, strong) NSArray<GuideDataItem *> *datas;
+(instancetype)modelWithDatas:(NSArray<GuideDataItem *> *)datas;
@end
