//
//  ContactsManager.m
//  AddressBookTest
//
//  Created by 詹平 on 16/8/4.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ContactsManager.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ContactsManager ()<ABPeoplePickerNavigationControllerDelegate>
@property (nonatomic, strong) ABPeoplePickerNavigationController *ppnc;
@property (nonatomic, copy) void (^successBlock) (Contacts *contacts);
@property (nonatomic, copy) void (^failureBlock) (NSError *error);
@end

@implementation ContactsManager

static ContactsManager *_manager;
+(instancetype)shareContactsManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

+(void)selectContactsWithTarget:(UIViewController *)target
                   successBlock:(void(^)(Contacts *contacts))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock{
    
    if (![target isKindOfClass:[UIViewController class]]) {
        NSError *error = [[NSError alloc]initWithDomain:@"选择联系人传入的target不是视图控制器" code:-1 userInfo:nil];
        if (failureBlock) failureBlock(error);
        return;
    }
    ABAuthorizationStatus type =  ABAddressBookGetAuthorizationStatus();
    switch (type) {
        case kABAuthorizationStatusNotDetermined:
        {
            ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    TCLog(@"授权允许");
                    [self presentContactsWithTarget:target successBlock:successBlock failureBlock:failureBlock];
                }else{
                    TCLog(@"授权拒绝");
                }
            });
            CFRelease(book);
        }
            break;
        case kABAuthorizationStatusAuthorized:
        {
            [self presentContactsWithTarget:target successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        default:
        {
            [self alertTipWithTarget:target];
        }
            break;
    }
}

+ (void)presentContactsWithTarget:(UIViewController *)target
                     successBlock:(void(^)(Contacts *contacts))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    ContactsManager *manager = [self shareContactsManager];
    if(!manager.ppnc){
        ABPeoplePickerNavigationController *ppnc = [[ABPeoplePickerNavigationController alloc] init];
        ppnc.peoplePickerDelegate = manager;
        ppnc.displayedProperties = @[@(kABPersonPhoneProperty)];
        manager.ppnc = ppnc;
    }
    [target presentViewController:manager.ppnc animated:YES completion:nil];
    manager.successBlock = successBlock;
    manager.failureBlock = failureBlock;
}

+ (void)alertTipWithTarget:(UIViewController *)target {
    NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    NSString *message = [NSString stringWithFormat:@"您尚未开启%@APP通讯录授权，不能使用该功能。请到“设置-%@-通讯录”中开启",prodName,prodName];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通讯录授权" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:cancle];
    [alert addAction:sure];
    [target presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker
                         didSelectPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMultiValueRef phones =   ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString *selectedPhone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, identifier));
        NSString *formatPhoneNum = [self formatPhoneNum:selectedPhone];

        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSMutableString *name = [NSMutableString string];
        if (lastName.length>0) [name appendString:lastName];
        if (firstName.length>0) [name appendString:firstName];
        
        Contacts *contacts = [Contacts contactsWithName:name phone:formatPhoneNum];
        if (self.successBlock) self.successBlock(contacts);
        
        CFRelease(phones);
    }
}

#pragma mark - private

- (NSString *)formatPhoneNum:(NSString *)phone{
    
    NSMutableString *mutablePhone = [NSMutableString stringWithString:phone];
    NSRange range1 = [mutablePhone rangeOfString:@"-"];
    while (range1.location!=NSNotFound) {
        [mutablePhone replaceCharactersInRange:range1 withString:@""];
        range1 = [mutablePhone rangeOfString:@"-"];
    }
    
    NSRange range2 = [mutablePhone rangeOfString:@"."];
    while (range2.location!=NSNotFound) {
        [mutablePhone replaceCharactersInRange:range2 withString:@""];
        range2 = [mutablePhone rangeOfString:@"."];
    }
    
    NSRange range3 = [mutablePhone rangeOfString:@"+86"];
    while (range3.location!=NSNotFound) {
        [mutablePhone replaceCharactersInRange:range3 withString:@""];
        range3 = [mutablePhone rangeOfString:@"+86"];
    }
    
    NSRange range4 = [mutablePhone rangeOfString:@" "];
    while (range4.location!=NSNotFound) {
        [mutablePhone replaceCharactersInRange:range4 withString:@""];
        range4 = [mutablePhone rangeOfString:@" "];
    }
    
    return mutablePhone;
}

@end
