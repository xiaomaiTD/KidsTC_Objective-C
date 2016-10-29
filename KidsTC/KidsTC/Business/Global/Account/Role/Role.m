//
//  Role.m
//  KidsTC
//
//  Created by Altair on 11/13/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "Role.h"

@implementation Role

+ (instancetype)instanceWithType:(RoleType)type sex:(RoleSex)sex {
    NSString *name = @"未知";
    NSUInteger identifier = [Role roleIdentifierWithType:type sex:sex];
    switch (identifier) {
        case 0:
        {
            name = @"未知";
        }
            break;
        case 11:
        {
            name = @"备孕 孕期 婴儿";
        }
            break;
        case 13:
        {
            name = @"幼儿(男)";
        }
            break;
        case 14:
        {
            name = @"幼儿(女)";
        }
            break;
        case 15:
        {
            name = @"学前(男)";
        }
            break;
        case 16:
        {
            name = @"学前(女)";
        }
            break;
        case 17:
        {
            name = @"学龄(男)";
        }
            break;
        case 18:
        {
            name = @"学龄(女)";
        }
            break;
        default:
            break;
    }
    return [Role instanceWithType:type sex:sex andName:name];
}

+ (instancetype)instanceWithType:(RoleType)type sex:(RoleSex)sex andName:(NSString *)name {
    Role *role = [[Role alloc] init];
    role.type = type;
    role.sex = sex;
    role.roleName = name;
    return role;
}

+ (instancetype)roleWityID:(NSInteger)ID {
    
    RoleType roleType;
    RoleSex roleSex;
    if (ID%2 == 1) {
        roleType = (RoleType)ID;
        roleSex = (roleType==RoleTypeZeroToOne)?RoleSexUnknown:RoleSexMale;
    }else{
        roleType = (RoleType)(ID-1);
        roleSex = RoleSexFemale;
    }
    return [Role instanceWithType:roleType sex:roleSex];
}

+ (NSUInteger)roleIdentifierWithType:(RoleType)type sex:(RoleSex)sex {
    NSUInteger identifier = 0;
    if (sex == RoleSexUnknown) {
        identifier = type;
    } else {
        identifier = type + sex - 1;
    }
    // 男  女
    // 11 12
    // 13 14
    // 15 16
    // 17 18
    return identifier;
}

- (NSString *)roleIdentifierString {
    return [NSString stringWithFormat:@"%zd", [Role roleIdentifierWithType:self.type sex:self.sex]];
}

- (NSInteger)roleIdentifier {
    return [Role roleIdentifierWithType:self.type sex:self.sex];
}

- (NSString *)statusName{
    RoleType type = self.type;
    NSString *name = nil;
    switch (type) {
            
        case RoleTypeUnknown:
        {
            name = @"孕产";
        }
            break;
        case RoleTypeZeroToOne:
        {
            name = @"孕产";
        }
            break;
        case RoleTypeTwoToThree:
        {
            name = @"幼儿";
        }
            break;
        case RoleTypeFourToSix:
        {
            name = @"学前";
        }
            break;
        case RoleTypeSevenToTwelveMale:
        {
            name = @"学龄";
        }
            break;

        default:
            break;
    }
    return name;
}

- (UIImage *)emptyTableBGImage {
    NSString *imageName = [NSString stringWithFormat:@"loading_empty_%@",self.roleIdentifierString];
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        image = [UIImage imageNamed:@"loading_empty_11"];
    }
    return image;
}

@end
