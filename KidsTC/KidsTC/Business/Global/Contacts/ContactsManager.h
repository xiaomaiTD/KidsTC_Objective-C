//
//  ContactsManager.h
//  AddressBookTest
//
//  Created by 詹平 on 16/8/4.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"
@interface ContactsManager : NSObject
+(void)selectContactsWithTarget:(UIViewController *)target
                   successBlock:(void(^)(Contacts *contacts))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock;
@end
