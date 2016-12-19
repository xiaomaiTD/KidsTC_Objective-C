//
//  SynchronizeManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SynchronizeManager.h"

#import "InterfaceManager.h"
#import "ThemeManager.h"
#import "AddTabManager.h"
#import "CategoryDataManager.h"
#import "AreaAndAgeDataManager.h"
#import "SearchHotKeywordsManager.h"
#import "PosterManager.h"
#import "AddressDataManager.h"
#import "HomeActivityManager.h"
#import "AppVersionManager.h"
#import "HomeRefreshManager.h"
#import "ComposeManager.h"
#import "AppBaseManager.h"

@implementation SynchronizeManager

+ (void)synchronizeEnterForeground{
    
    //===================== LOCAL SAVE ===========================
    
    [[InterfaceManager shareInterfaceManager] synchronize];
    
    [[CategoryDataManager shareCategoryDataManager] synchronize];
    
    [[SearchHotKeywordsManager shareSearchHotKeywordsManager] synchronize];
    
    [[AreaAndAgeDataManager shareAreaAndAgeDataManager] synchronize];
    
    [[AddressDataManager shareAddressDataManager] synchronize];
    
    [[AppBaseManager shareAppBaseManager] synchronize];
    
    //=============================================================
    
    [[AddTabManager shareAddTabManager] synchronize];
    
    [[ThemeManager shareThemeManager] synchronize];
    
    [[PosterManager sharePosterManager] synchronize];
    
    [[HomeActivityManager shareHomeActivityManager] synchronize];
    
    [[HomeRefreshManager shareHomeRefreshManager] synchronize];
    
    [[AppVersionManager shareAppVersionManager] checkRemote];
    
    [[ComposeManager shareComposeManager] synchronize];
    
    [[User shareUser] getUserPopulation];
}

+ (void)synchronizeEnterBackground {
    
    [[AddTabManager shareAddTabManager] synchronize];
    
    [[ThemeManager shareThemeManager] synchronize];
    
    [[PosterManager sharePosterManager] synchronize];
    
    [[HomeActivityManager shareHomeActivityManager] synchronize];
    
    [[HomeRefreshManager shareHomeRefreshManager] synchronize];
}
@end
