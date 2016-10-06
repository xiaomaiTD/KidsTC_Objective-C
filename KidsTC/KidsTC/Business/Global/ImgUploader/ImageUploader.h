//
//  KTCImageUploader.h
//  KidsTC
//
//  Created by 钱烨 on 8/31/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
@interface ImageUploader : NSObject

singleH(ImageUploader);

- (void)startUploadWithImagesArray:(NSArray *)imagesArray splitCount:(NSUInteger)count withSucceed:(void(^)(NSArray *locateUrlStrings))succeed failure:(void(^)(NSError *error))failure;


@end
