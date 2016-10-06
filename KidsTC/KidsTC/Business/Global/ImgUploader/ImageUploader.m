//
//  KTCImageUploader.m
//  KidsTC
//
//  Created by 钱烨 on 8/31/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ImageUploader.h"
#import "Request.h"
#define FILE_UPLOAD (@"IMAGE_UPLOAD")

@interface ImageUploader ()

@property (nonatomic, strong) NSMutableDictionary *uploadResultDic;
@property (nonatomic, strong) NSMutableArray *uploadFailureArr;//记录失败数组

- (void)startUploadWithImage:(UIImage *)image splitCount:(NSUInteger)count succeed:(void(^)(NSString *locateUrlString))succeed failure:(void(^)(NSError *error))failure;

- (NSString *)getUploadLocationWithResponse:(NSDictionary *)respData;

- (NSArray *)getUploadResultArray;

@end

@implementation ImageUploader
singleM(ImageUploader);

- (void)startUploadWithImagesArray:(NSArray *)imagesArray splitCount:(NSUInteger)count withSucceed:(void (^)(NSArray *))succeed failure:(void (^)(NSError *))failure {
    
    [self.uploadResultDic removeAllObjects];
    [self.uploadFailureArr removeAllObjects];
    NSUInteger imageCount = [imagesArray count];
    
    for (NSUInteger index = 0; index < imageCount; index ++) {
        UIImage *image = [imagesArray objectAtIndex:index];
        
            [self startUploadWithImage:image splitCount:count succeed:^(NSString *locateUrlString) {
                if ([locateUrlString length] > 0) {
                    [self.uploadResultDic setObject:locateUrlString forKey:[NSNumber numberWithInteger:index]];
                    if ([self.uploadResultDic count] == imageCount && succeed) {
                        //上传完成
                        succeed([self getUploadResultArray]);
                    }
                } else {
                    if (failure) {
                        NSError *error = [NSError errorWithDomain:@"Image upload" code:-100001 userInfo:[NSDictionary dictionaryWithObject:@"Response not valid." forKey:kErrMsgKey]];
                        failure(error);
                    }
                }
            } failure:^(NSError *error) {
                if (failure) {
                    failure(error);
                }
            }];
    }
}


#pragma mark Private methods
- (void)startUploadWithImage:(UIImage *)image splitCount:(NSUInteger)count  succeed:(void (^)(NSString *))succeed failure:(void (^)(NSError *))failure {
    NSData *data = UIImageJPEGRepresentation(image, 0.0);
    if (!data) return;
    
    NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:dataString, @"fileStr", @"JPEG", @"suffix", [NSNumber numberWithInteger:count], @"count", nil];
    [Request startAndCallBackInChildThreadWithName:FILE_UPLOAD param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSString *location = [self getUploadLocationWithResponse:dic];
        if (succeed) {
            succeed(location);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.uploadFailureArr addObject:image];
        if (failure) {
            failure(error);
        }
    }];
}

- (NSString *)getUploadLocationWithResponse:(NSDictionary *)respData {
    NSString *data = [respData objectForKey:@"data"];
    if (!data || ![data isKindOfClass:[NSString class]]) {
        return nil;
    }
    return data;
}

- (NSArray *)getUploadResultArray {
    if ([self.uploadResultDic count] == 0) {
        return nil;
    }
    NSArray *allKeys = [self.uploadResultDic allKeys];
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *key1 = obj1;
        NSNumber *key2 = obj2;
        return [key1 compare:key2];
    }];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSNumber *key in allKeys) {
        NSString *result = [self.uploadResultDic objectForKey:key];
        [tempArray addObject:result];
    }
    return [NSArray arrayWithArray:tempArray];
}

- (NSMutableDictionary *)uploadResultDic{
    if (!_uploadResultDic) {
        _uploadResultDic = [NSMutableDictionary dictionary];
    }
    return _uploadResultDic;
}

- (NSMutableArray *)uploadFailureArr{
    if (!_uploadFailureArr) {
        _uploadFailureArr = [NSMutableArray array];
    }
    return _uploadFailureArr;
}
@end
