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
        self.databaseOpened = [self openDatabase];
        if(self.databaseOpened){
            [self setNGUsersToArray];
            [self setNGWordsToArray];
            [_db close];
        }
    }
    return self;
}

- (BOOL)openDatabase
{
    //// Check if iCloud Enabled
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.iCloudEnabled == NO || userData.premium == NO){
        return NO;
    }
    
    //// General Decralations
    NSString* sqliteFileName = @"Filters.sqlite";
    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentPath = [pathArray objectAtIndex:0];
    NSString* destinationPath = [documentPath stringByAppendingPathComponent:sqliteFileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    
    //// Check if exists
    if([fileManager fileExistsAtPath:destinationPath]){
        dlog(@"Fiters.sqlite found.");
    }else{
        dlog(@"Filters.sqlite NOT FOUND.");
        NSString* originalSqliteFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sqliteFileName];
        BOOL success = [fileManager copyItemAtPath:originalSqliteFilePath toPath:destinationPath error:&error];
        if(success){
            dlog(@"Filters.sqlite SUCCESSFULLY COPIED.");
        }else{
            dlog(@"FAILED TO COPY Filters.sqlite.");
            return NO;
        }
    }
    
    _db = [FMDatabase databaseWithPath:destinationPath];
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
    _NGUsers = [NSMutableArray array];
    if(self.databaseOpened){
        FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGUsers"];
        while ([rs next]) {
            [_NGUsers addObject:[NSNumber numberWithInt:[rs intForColumn:@"user_id"]]];
        }
    }
}

- (void)setNGWordsToArray
{
    _NGWords = [NSMutableArray array];
    if(self.databaseOpened){
        FMResultSet* rs = [_db executeQuery:@"SELECT * FROM NGWords"];
        while ([rs next]) {
            NSString* word = [rs stringForColumn:@"word"];
            dlog(@"NG:%@", word);
            if(word){
                [_NGWords addObject:[NSString stringWithFormat:@"%@",word]];                
            }
        }
    }
}

- (BOOL)isDisplayable:(NSStatus *)status
{
    _status = status;
    if([self ifConatainNGWord] || [self ifNGUser]){
        return NO;
    }
    return YES;
}

#pragma mark Insert

- (void)insertNGWord:(NSString *)word
{
    
}

- (void)insertUserInStastus:(NSStatus *)status
{
    
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
