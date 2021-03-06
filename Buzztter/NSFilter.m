//
//  NSFilter.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSFilter.h"

static NSFilter* _sharedFilter = nil;

@implementation NSFilter

+ (NSFilter*)sharedFilter
{
    @synchronized(self) {
        if (_sharedFilter == nil) {
            (void) [[self alloc] init];
        }
    }
    return _sharedFilter;
}


+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_sharedFilter == nil) {
            _sharedFilter = [super allocWithZone:zone];
            return _sharedFilter;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if(self){
        
        //// Check if iCloud Enabled
        _isPremium = NO;
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        if(userData.premium == YES){
            _isPremium = YES;
            if([self openDatabase]){
                [self setNGUsersToArray];
                [self setNGWordsToArray];
                [_db close];
            }
        }

    }
    return self;
}

- (BOOL)reopenDatabase
{
    [_db close];
    _db = nil;
    return [self openDatabase];
}

- (BOOL)openDatabase
{
    if(_db == nil){
        //// General Decralations
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        NSString* documentPath;
        NSString* cachePath;
        NSString* destinationFileName;
        NSString* documentFileName;
        NSString* cacheFileName;
        NSString* sqliteFileName = @"Filters.sqlite";
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSError* error = nil;

        NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentPath = [pathArray objectAtIndex:0];
        documentFileName = [documentPath stringByAppendingPathComponent:sqliteFileName];
        
        pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachePath = [pathArray objectAtIndex:0];
        cacheFileName = [cachePath stringByAppendingPathComponent:sqliteFileName];
        if(userData.iCloudEnabled){
            destinationFileName = documentFileName;
        }else{
            if([fileManager fileExistsAtPath:documentFileName]){
                [fileManager removeItemAtPath:cacheFileName error:&error];
                [fileManager moveItemAtPath:documentFileName toPath:cacheFileName error:&error];
            }
            destinationFileName = cacheFileName;
        }
        
        //// Check if exists
        if([fileManager fileExistsAtPath:destinationFileName]){
            dlog(@"Fiters.sqlite found.");
        }else{
            dlog(@"Filters.sqlite NOT FOUND.");
            if(userData.iCloudEnabled){
                BOOL success = [fileManager copyItemAtPath:cacheFileName toPath:documentFileName error:&error];
                if(success){
                    dlog(@"Filters.sqlite SUCCESSFULLY COPIED FROM CACHE");
                    _db = [FMDatabase databaseWithPath:documentFileName];
                    return [_db open];
                }
            }
            NSString* originalFileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sqliteFileName];
            BOOL success = [fileManager copyItemAtPath:originalFileName toPath:destinationFileName error:&error];
            if(success){
                dlog(@"Filters.sqlite SUCCESSFULLY COPIED.");
            }else{
                dlog(@"FAILED TO COPY Filters.sqlite.");
                return NO;
            }
            
        }
        
        _db = [FMDatabase databaseWithPath:destinationFileName];
    }
    return [_db open];
}

- (BOOL)deleteSqliteFile
{
    //// General Decralations
    NSString* sqliteFileName = @"Filters.sqlite";
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentPath = [pathArray objectAtIndex:0];
    NSString* destinationPath = [documentPath stringByAppendingPathComponent:sqliteFileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    
    //// Remove
    return [fileManager removeItemAtPath:destinationPath error:&error];
}

- (void)setNGUsersToArray
{
    if(_NGUsers){
        [_NGUsers removeAllObjects];
        _NGUsers = nil;
    }
    _NGUsers = [NSMutableArray array];
    FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGUsers"];
    while ([rs next]) {
        [_NGUsers addObject:[NSNumber numberWithInt:[rs intForColumn:@"user_id"]]];
    }
}

- (NSMutableArray*)getHiddenUsersFullData
{
    NSMutableArray* array = [NSMutableArray array];
    if([self openDatabase]){
        FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGUsers"];
        while ([rs next]) {
            NSFilterUsersFullData* data = [[NSFilterUsersFullData alloc] init];
            data.user_id = [rs intForColumn:@"user_id"];
            data.name = [rs stringForColumn:@"name"];
            data.screen_name = [rs stringForColumn:@"screen_name"];
            [array addObject:data];
        }
    }
    return array;
}


- (NSMutableArray*)getNGWords
{
    NSMutableArray* array = [NSMutableArray array];
    if([self openDatabase]){
        FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGWords ORDER BY \"index\" DESC"];
        while ([rs next]) {
            NSFilterWordsFullData* data = [[NSFilterWordsFullData alloc] init];
            data.index = [rs intForColumn:@"index"];
            data.word = [rs stringForColumn:@"word"];
            [array addObject:data];
        }
    }
    return array;
}
- (void)setNGWordsToArray
{
    if(_NGWords){
        [_NGWords removeAllObjects];
        _NGWords = nil;        
    }
    _NGWords = [NSMutableArray array];
    
    FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGWords"];
    while ([rs next]) {
        NSString* word = [rs stringForColumn:@"word"];
        if(word){
            [_NGWords addObject:[NSString stringWithFormat:@"%@",word]];
        }
    }
    
}

- (BOOL)isDisplayable:(NSStatus *)status
{
    if(_isPremium == NO){
        return YES;
    }
    _status = status;
    if([self ifConatainNGWord] || [self ifNGUser]){
        return NO;
    }
    return YES;
}

#pragma mark Insert

- (BOOL)insertNGWord:(NSString *)word
{
    word = [word stringByReplacingOccurrencesOfString:@"'" withString:@""];
    if(word.length == 0){
        return NO;
    }
    BOOL success = NO;
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO NGwords values (NULL,'%@');", word];
    if([self openDatabase]){
        [_db beginTransaction];
        [_db setShouldCacheStatements:YES];
        [_db executeUpdate:sql];
        if(![_db hadError]){
            success = YES;
        }
        [_db commit];
    }
    [self setNGWordsToArray];
    [_db close];
    return success;
}

- (BOOL)insertUserInStastus:(NSStatus *)status
{
    if(status == nil){
        return NO;
    }
    BOOL success = NO;
    NSString* name = [status.user.name stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO NGUsers values ('%@','%@','%@');", status.user.id_string, name, status.user.screen_name];
    if([self openDatabase]){
        [_db beginTransaction];
        [_db setShouldCacheStatements:YES];
        [_db executeUpdate:sql];
        if(![_db hadError]){
            success = YES;
        }
        [_db commit];
    }
    [self setNGUsersToArray];
    [_db close];
    return success;
}

- (BOOL)removeUser:(NSFilterUsersFullData *)user
{
    if(user == nil){
        return NO;
    }
    
    BOOL success = NO;
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM NGUsers WHERE \"user_id\" = %d", user.user_id];
    if([self openDatabase]){
        [_db beginTransaction];
        [_db setShouldCacheStatements:YES];
        [_db executeUpdate:sql];
        if(![_db hadError]){
            success = YES;
        }
        [_db commit];
    }
    [self setNGUsersToArray];
    [_db close];
    return success;
}

- (BOOL)removeWord:(NSFilterWordsFullData *)word
{
    if(word == nil){
        return NO;
    }
    
    BOOL success = NO;
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM NGWords WHERE \"index\" = %d", word.index];
    dlog(@"%@", sql);
    if([self openDatabase]){
        [_db beginTransaction];
        [_db setShouldCacheStatements:YES];
        [_db executeUpdate:sql];
        if(![_db hadError]){
            success = YES;
        }
        [_db commit];
    }
    [self setNGWordsToArray];
    [_db close];
    return success;
}

- (BOOL)ifConatainNGWord
{
    int count = [_NGWords count];
    for(int index = 0;index < count;index++){
        NSString* ng_word = [_NGWords objectAtIndex:index];
        NSRange range;
        
        //// Text
        range = [_status.text rangeOfString:ng_word];
        if(range.location != NSNotFound){
            return YES;
        }
    }
    
    return NO;
}
- (BOOL)ifNGUser
{
    int count = [_NGUsers count];
    for(int index = 0;index < count;index++){
        int ng_user_id = [[_NGUsers objectAtIndex:index] intValue];
        if(_status.user.id == ng_user_id){
            return YES;
        }
    }
    return NO;
}

@end
