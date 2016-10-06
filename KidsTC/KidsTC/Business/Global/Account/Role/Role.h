//
//  Role.h
//  KidsTC
//
//  Created by Altair on 11/13/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RoleTypeUnknown           = 0,//未知
    RoleTypeZeroToOne         = 11,//0-1
    RoleTypeTwoToThree        = 13,//2-3
    RoleTypeFourToSix         = 15,//4-6
    RoleTypeSevenToTwelveMale = 17,//7-12
}RoleType;

typedef enum {
    RoleSexUnknown = 0, //未知
    RoleSexMale, //男
    RoleSexFemale //女
}RoleSex;

@interface Role : NSObject
@property (nonatomic, assign) RoleType type;
@property (nonatomic, assign) RoleSex sex;
@property (nonatomic, strong) NSString *roleName;

+ (instancetype)instanceWithType:(RoleType)type sex:(RoleSex)sex;

+ (NSUInteger)roleIdentifierWithType:(RoleType)type sex:(RoleSex)sex;

- (NSString *)roleIdentifierString;

- (NSString *)statusName;

- (UIImage *)emptyTableBGImage;

@end
