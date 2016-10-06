//
//  Contacts.h
//  AddressBookTest
//
//  Created by 詹平 on 16/8/4.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
+ (instancetype)contactsWithName:(NSString *)name phone:(NSString *)phone;
@end
