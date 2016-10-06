//
//  SettlementResultShareModel.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementResultShareModel.h"
#import "NSString+Category.h"

@implementation SettlementResultShareData
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    NSString *string = @"";
    if ([_shareTips isNotNull]) {
        string = _shareTips;
        NSString *myNewLineStr = @"\n";
        string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:myNewLineStr];
    }
    _shareTips = string;
    
    CommonShareObject *shareObj = [CommonShareObject shareObjectWithTitle:_tit description:_desc thumbImageUrl:[NSURL URLWithString:_imgUrl] urlString:_pageUrl];
    shareObj.identifier = @(_shareSysNo).stringValue;
    shareObj.shareName = _shareName;
    shareObj.followingContent = @"【童成网】";
    _shareObj = shareObj;
    return YES;
}
@end

@implementation SettlementResultShareModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
