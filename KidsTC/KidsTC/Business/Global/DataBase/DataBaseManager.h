//
//  DataBaseManager.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/7.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "BuryPointModel.h"
@interface DataBaseManager : NSObject
singleH(DataBaseManager)

#pragma mark - buryPoint

- (void)buryPoint_inset:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock;

- (void)buryPoint_delete:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock;

- (void)buryPoint_modify:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock;

- (void)buryPoint_not_upload_count:(void(^)(NSUInteger count))countBlock;

- (void)buryPoint_not_upload_allModels:(void(^)(NSArray<BuryPointModel *> *models))allModelsBlock;

- (void)buryPoint_inset_did_upload:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock;

@end
