//
//  CommonShareObject.m
//  KidsTC
//
//  Created by Altair on 11/20/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommonShareObject.h"

@implementation CommonShareObject

+ (instancetype)shareObjectWithTitle:(NSString *)title
                         description:(NSString *)description
                          thumbImage:(UIImage *)thumb
                           urlString:(NSString *)urlString {
    if (title && ![title isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (description && ![description isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (thumb && ![thumb isKindOfClass:[UIImage class]]) {
        return nil;
    }
    if (!urlString || ![urlString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    CommonShareObject *object = [[CommonShareObject alloc] init];
    object.title = title;
    object.shareDescription = description;
    object.thumbImage = thumb;
    object.webPageUrlString = urlString;
    return object;
}

+ (instancetype)shareObjectWithTitle:(NSString *)title
                         description:(NSString *)description
                       thumbImageUrl:(NSURL *)thumbUrl
                           urlString:(NSString *)urlString {
    if (title && ![title isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (description && ![description isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (thumbUrl && ![thumbUrl isKindOfClass:[NSURL class]]) {
        return nil;
    }
    if (!urlString || ![urlString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    CommonShareObject *object = [[CommonShareObject alloc] init];
    object.title = title;
    object.shareDescription = description;
    object.thumbImageUrl = thumbUrl;
    object.webPageUrlString = urlString;
    return object;
}

+ (instancetype)shareObjectWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) return nil;
    NSString *title         = [NSString stringWithFormat:@"%@", [data objectForKey:@"title"]];
    NSString *desc          = [NSString stringWithFormat:@"%@", [data objectForKey:@"desc"]];
    NSString *imgUrlString  = [NSString stringWithFormat:@"%@", [data objectForKey:@"imgUrl"]];
    NSString *linkUrlString = [NSString stringWithFormat:@"%@", [data objectForKey:@"linkUrl"]];
    CommonShareObject *shareObj = [CommonShareObject shareObjectWithTitle:title description:desc thumbImageUrl:[NSURL URLWithString:imgUrlString] urlString:linkUrlString];
    return shareObj;
}

+ (instancetype)defaultShareObjWithTitle:(NSString *)title url:(NSString *)urlString {
    CommonShareObject *object = [[CommonShareObject alloc] init];
    object.title = @"童成与您一起分享";
    object.shareDescription = @"童成与您一起分享";
    object.thumbImage = [UIImage imageNamed:@"Icon-60"];
    object.webPageUrlString = urlString;
    return object;
}

- (NSString *)identifier {
    if (!_identifier) {
        _identifier = @"noneId";
    }
    return _identifier;
}

- (CommonShareObject *)copyObject {
    CommonShareObject *retObj = [[CommonShareObject alloc] init];
    retObj.identifier = self.identifier;
    retObj.title = self.title;
    retObj.shareDescription = self.shareDescription;
    if (self.thumbImage) {
        retObj.thumbImage = [UIImage imageWithCGImage:self.thumbImage.CGImage];
    }
    retObj.thumbImageUrl = [self.thumbImageUrl copy];
    retObj.webPageUrlString = self.webPageUrlString;
    retObj.followingContent = self.followingContent;
    retObj.shareName = self.shareName;
    return retObj;
}


@end
