//
//  KTCImageUploader.m
//  KidsTC
//
//  Created by 钱烨 on 8/31/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "KTCImageUploader.h"
#import "GHeader.h"
#import "NSString+Category.h"

#define FILE_UPLOAD (@"IMAGE_UPLOAD")

@interface KTCImageUploader ()
@property (nonatomic, strong) NSMutableDictionary *uploadResultDic;
@end

@implementation KTCImageUploader

static KTCImageUploader *sharedInstance;
+ (instancetype)sharedInstance {
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        sharedInstance = [[KTCImageUploader alloc] init];
    });
    return sharedInstance;
}

- (void)startUploadWithImagesArray:(NSArray *)imagesArray splitCount:(NSUInteger)count withSucceed:(void (^)(NSArray *))succeed failure:(void (^)(NSError *))failure {
    self.uploadResultDic  = [NSMutableDictionary dictionary];
    NSUInteger totalCount = imagesArray.count;
    for (int i = 0; i<totalCount; i++) {
        UIImage *image = imagesArray[i];
        [self startUploadWithImage:image splitCount:count succeed:^(NSString *locateUrlString) {
            if ([locateUrlString isNotNull]) {
                [self.uploadResultDic setObject:locateUrlString forKey:@(i)];
                NSUInteger dicCount = self.uploadResultDic.count;
                if (dicCount == totalCount) {
                    if (succeed) succeed([self getUploadResultArray]);
                }
            } else {
                if (failure) {
                    NSError *error = [NSError errorWithDomain:@"Image upload" code:-100001 userInfo:[NSDictionary dictionaryWithObject:@"Response not valid." forKey:kErrMsgKey]];
                    failure(error);
                }
            }
        } failure:^(NSError *error) {
            if (failure) failure(error);
        }];
    }
}

#pragma mark Private methods

- (void)startUploadWithImage:(UIImage *)image splitCount:(NSUInteger)count succeed:(void (^)(NSString *))succeed failure:(void (^)(NSError *))failure {
    NSData *data = UIImageJPEGRepresentation(image, 0.0);
    if (!data) return;
    NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (![dataString isNotNull]) return;
    NSDictionary *param = @{@"fileStr" : dataString,
                            @"suffix"  : @"JPEG",
                            @"count"   : @(count)};
    [Request startWithName:FILE_UPLOAD param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSString *location = [self getUploadLocationWithResponse:dic];
        if (succeed) succeed(location);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}

- (NSString *)getUploadLocationWithResponse:(NSDictionary *)respData {
    NSString *dataString = [respData objectForKey:@"data"];
    return [dataString isNotNull]?dataString:nil;
}

- (NSArray *)getUploadResultArray {
    if ((!_uploadResultDic) || (_uploadResultDic.count == 0)) {
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


@end
