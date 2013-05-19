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

@interface NSFilter : NSObject
{
    NSMutableArray* _NGWords;
    NSMutableArray* _NGUsers;
    __weak NSStatus* _status;
    FMDatabase* _db;
}

@property (nonatomic, assign) BOOL databaseOpened;

+ (NSFilter*)sharedFilter;
- (BOOL)isDisplayable:(NSStatus*)status;
- (BOOL)ifConatainNGWord;
- (BOOL)ifNGUser;

- (BOOL)openDatabase;
- (BOOL)deleteSqliteFile;
- (void)setNGUsersToArray;
- (void)setNGWordsToArray;

- (BOOL)insertUserInStastus:(NSStatus*)status;
- (BOOL)insertNGWord:(NSString*)word;

@end
