//
//  NSFilter.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NSStatus.h"
#import "FMDatabase.h"
#import "NSEnduserData.h"
#import "NSFilterUsersFullData.h"
#import "NSFilterWordsFullData.h"

@interface NSFilter : NSObject
{
    NSMutableArray* _NGWords;
    NSMutableArray* _NGUsers;
    __weak NSStatus* _status;
    FMDatabase* _db;
    BOOL _isPremium;
}

+ (NSFilter*)sharedFilter;
- (BOOL)isDisplayable:(NSStatus*)status;
- (BOOL)ifConatainNGWord;
- (BOOL)ifNGUser;

- (BOOL)openDatabase;
- (BOOL)reopenDatabase;
- (BOOL)deleteSqliteFile;
- (void)setNGUsersToArray;
- (void)setNGWordsToArray;

- (BOOL)insertUserInStastus:(NSStatus*)status;
- (BOOL)insertNGWord:(NSString*)word;

- (BOOL)removeUser:(NSFilterUsersFullData*)user;
- (BOOL)removeWord:(NSFilterWordsFullData*)word;

- (NSMutableArray*)getHiddenUsersFullData;
- (NSMutableArray*)getNGWords;

@end
