//
//  DataBaseManager.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/7.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"
#import "NSString+Category.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"

@interface DataBaseManager ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

@implementation DataBaseManager
singleM(DataBaseManager)

- (instancetype)init {
    self = [super init];
    if(self){
        [self initDataBase];
    };
    return self;
}

- (void)getDB:(void(^)(FMDatabase *db))dbBlock {
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:FILE_CACHE_PATH(@"model.sqlite")];
    [dbQueue inDatabase:^(FMDatabase *db) {
        if(dbBlock)dbBlock(db);
    }];
}

- (void)initDataBase{
    // 实例化FMDataBase对象
    //_dbQueue = [FMDatabaseQueue databaseQueueWithPath:FILE_CACHE_PATH(@"model.sqlite")];
    [self getDB:^(FMDatabase *db) {
        
        if ([db open]) {
            
            // 初始化数据表
            BOOL buryPoint_not_upload_exists = [db tableExists:@"buryPoint_not_upload"];
            if (!buryPoint_not_upload_exists) {
                NSString *buryPoint_not_upload = @"CREATE TABLE 'buryPoint_not_upload' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'pk' VARCHAR(255), 'status' BOOL, 'time' VARCHAR(255), 'content' VARCHAR(255))";
                BOOL buryPoint_not_upload_creat = [db executeUpdate:buryPoint_not_upload];
                if (buryPoint_not_upload_creat) {
                    TCLog(@"buryPoint_not_upload建表成功…");
                }else{
                    TCLog(@"buryPoint_not_upload建表失败…");
                }
            }
            
            BOOL buryPoint_did_upload_exists = [db tableExists:@"buryPoint_did_upload"];
            if (!buryPoint_did_upload_exists) {
                NSString *buryPoint_did_upload = @"CREATE TABLE 'buryPoint_did_upload' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'pk' VARCHAR(255), 'status' BOOL, 'time' VARCHAR(255), 'content' VARCHAR(255))";
                BOOL buryPoint_did_uploadcreat = [db executeUpdate:buryPoint_did_upload];
                if (buryPoint_did_uploadcreat) {
                    TCLog(@"buryPoint_did_upload建表成功…");
                }else{
                    TCLog(@"buryPoint_did_upload建表失败…");
                }
            }
            
            [db close];
        }
    }];
    
}

#pragma mark - buryPoint

- (void)buryPoint_inset:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock {
    if (!model) {
        if (successBlock) successBlock(NO);
    }
    if (![model.pk isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    if (![model.content isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            BOOL success = [db executeUpdate:@"INSERT INTO buryPoint_not_upload (pk, status, time, content) VALUES (?, ?, ?, ?);", model.pk, @(model.status), @(model.time), model.content];
            [db close];
            if (successBlock) successBlock(success);
        }else{
            if (successBlock) successBlock(NO);
        }
    }];
}

- (void)buryPoint_delete:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock {
    if (!model) {
        if (successBlock) successBlock(NO);
    }
    if (![model.pk isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            BOOL success = [db executeUpdate:@"DELETE FROM buryPoint_not_upload WHERE pk = ?",model.pk];
            [db close];
            if (successBlock) successBlock(success);
        }else{
            if (successBlock) successBlock(NO);
        }
    }];
}

- (void)buryPoint_modify:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock {
    if (!model) {
        if (successBlock) successBlock(NO);
    }
    if (![model.pk isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    if (![model.content isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            BOOL success = [db executeUpdate:@"UPDATE 'buryPoint_not_upload' SET status = ?  WHERE pk = ? ", @(YES), model.pk];
            [db close];
            if (successBlock) successBlock(success);
        }else{
            if (successBlock) successBlock(NO);
        }
    }];
}

- (void)buryPoint_not_upload_count:(void(^)(NSUInteger count))countBlock {
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            NSUInteger count = [db intForQuery:@"select count(*) from buryPoint_not_upload"];
            [db close];
            if (countBlock) countBlock(count);
        }else{
            if (countBlock) countBlock(0);
        }
    }];
}

- (void)buryPoint_not_upload_allModels:(void(^)(NSArray<BuryPointModel *> *models))allModelsBlock{
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            FMResultSet *res = [db executeQuery:@"SELECT * FROM buryPoint_not_upload"];
            while ([res next]) {
                BuryPointModel *model = [[BuryPointModel alloc] init];
                model.ID = [NSString stringWithFormat:@"%@",[res stringForColumn:@"id"]];
                model.pk = [NSString stringWithFormat:@"%@",[res stringForColumn:@"pk"]];
                model.status = [[res stringForColumn:@"status"] boolValue];
                model.time = [[res stringForColumn:@"time"] doubleValue];
                model.content = [NSString stringWithFormat:@"%@",[res stringForColumn:@"content"]];
                if(model) [dataArray addObject:model];
            }
            [db close];
            NSArray *ary = [NSArray arrayWithArray:dataArray];
            if (allModelsBlock) allModelsBlock(ary);
        }else{
            if (allModelsBlock) allModelsBlock(nil);
        }
    }];
}

- (void)buryPoint_inset_did_upload:(BuryPointModel *)model successBlock:(void(^)(BOOL success))successBlock {
    if (!model) {
        if (successBlock) successBlock(NO);
    }
    if (![model.pk isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    if (![model.content isNotNull]) {
        if (successBlock) successBlock(NO);
    }
    [self getDB:^(FMDatabase *db) {
        if ([db open]) {
            BOOL success = [db executeUpdate:@"INSERT INTO buryPoint_did_upload (pk, status, time, content) VALUES (?, ?, ?, ?);", model.pk, @(model.status), @(model.time), model.content];
            [db close];
            if (successBlock) successBlock(success);
        }else{
            if (successBlock) successBlock(NO);
        }
    }];
}

@end
