//
//  Contacts.m
//  AddressBookTest
//
//  Created by 詹平 on 16/8/4.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "Contacts.h"

@implementation Contacts
+ (instancetype)contactsWithName:(NSString *)name phone:(NSString *)phone{
    Contacts *contacts = [[Contacts alloc]init];
    contacts.name = name;
    contacts.phone = phone;
    return contacts;
}
@end
