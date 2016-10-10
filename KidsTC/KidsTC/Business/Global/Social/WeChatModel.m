/*
 * Copyright (c) 2012,腾讯科技有限公司
 * All rights reserved.
 *
 * 文件名称：WeChatModel.m
 * 文件标识：
 * 摘 要：
 *
 * 当前版本：1.0
 * 作 者：haoquanbai
 * 完成日期：13-1-4
 */

#import "WeChatModel.h"
#import "TabBarController.h"

@implementation WeChatModel
@synthesize payRequest = _payRequest,loginDelegate;

+ (id)sharedWeChatModel
{
    static WeChatModel *sharedWechatModel = nil;
    if (sharedWechatModel == nil)
    {
        sharedWechatModel = [[WeChatModel alloc] init];
    }
    
    return sharedWechatModel;
}

- (id)init
{
    if (self = [super init])
    {
        self.payRequest = nil;
    }
    
    return self;
}

- (BOOL)isValidRequest
{
    BOOL valid = NO;
    if (self.payRequest != nil && self.payRequest.partnerId != nil && self.payRequest.prepayId != nil && self.payRequest.sign != nil && self.payRequest.package != nil)
    {
        valid = YES;
    }
    
    return valid;
}
- (void)startWeChatTrade
{
    if ([self isValidRequest])
    {
        [WXApi sendReq:self.payRequest];
    }
}

- (void)weixinLogin:(id<WeChatLoginDelegate>)_target
{
    self.loginDelegate = _target;
    
    if (![WXApi isWXAppInstalled])
    {
        [loginDelegate weixinLoginFailed:WXLOGIN_ERROR_NOT_INSTALLED];
        return;
    }
    
    if (![WXApi isWXAppSupportApi])
    {
        [loginDelegate weixinLoginFailed:WXLOGIN_ERROR_NOT_SUPPORT_API];
        return;
    }
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"51Buy";
    
    [WXApi sendReq:req];
}


/*
 生成随即数字字符串
 */
+ (NSString *)getRandomCode:(int)length
{
    long code = 0;
    unsigned int maxSize = 10;
    int strLength = length;
    while (strLength>1)
    {
        maxSize = maxSize * 10;
        strLength--;
    }
    srandom((unsigned)time(NULL));
    code = random()%maxSize;
    NSString * codeFromat = [NSString stringWithFormat:@"%%0.%dd",length];
    NSString * randomCode = [NSString stringWithFormat:codeFromat, code];
    
    return randomCode;
}

/*
 生成随即串
 */
+ (NSString *)getRandomStr:(int)length
{
    NSString *charSet = @"abcdefghijklmnopqrstuvwxyz1234567890";
    NSUInteger charCount = [charSet length];
    NSString *string = [NSString string];
    int strLength = length;
    long code = 0;
    srandom((unsigned)time(NULL));
    while (strLength>0)
    {
        code = random()%charCount;
        string = [string stringByAppendingFormat:@"%c",[charSet characterAtIndex:code]];
        strLength--;
    }
    
    return string;
}

+ (NSString *)genNonceNum
{
    int limitCount = 8;
    
    NSString *nonceStr = [WeChatModel getRandomStr:limitCount];
    
    return nonceStr;
}
+ (NSString *)appID
{
    return @"";
}
+ (NSString *)appKey
{
    //考虑安全因素，APP不持有APPKEY.
    return nil;
}

+ (void)onWeChatReq:(BaseReq *)req
{
    // We do not have things to do here yet
    if ([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // ...
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        // ...
    }
}

+ (BOOL)isValidWeChatApp
{
    BOOL isValid = [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
    return isValid;
}

@end

