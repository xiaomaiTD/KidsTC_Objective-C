//
//  TCHomeFloorTitleContent.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeFloorTitleContent.h"
#import "NSAttributedString+YYText.h"

@implementation TCHomeFloorTitleContent
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    
    
    return YES;
}

- (void)setupAttName {
    NSString *name = [NSString stringWithFormat:@"%@",_name];
    NSString *subName = [NSString stringWithFormat:@"%@",_subName];
    
    switch (_type) {
        case TCHomeFloorTitleContentTypeNormalTitle:
        {
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:17];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeMoreTitle:
        {
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:17];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeCountDownTitle:
        {
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:17];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeCountDownMoreTitle:
        {
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:17];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
        case TCHomeFloorTitleContentTypeRecommend:
        {
            NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:name];
            attName.color = COLOR_PINK;
            attName.font = [UIFont systemFontOfSize:17];
            attName.alignment = NSTextAlignmentLeft;
            _attName = attName;
            
            NSMutableAttributedString *attSubName = [[NSMutableAttributedString alloc] initWithString:subName];
            attSubName.color = [UIColor lightGrayColor];
            attSubName.font = [UIFont systemFontOfSize:17];
            attSubName.alignment = NSTextAlignmentRight;
            _attSubName = attSubName;
        }
            break;
    }
}

@end
