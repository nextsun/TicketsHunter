//
//  FMDB.m
//  FMDBTest
//
//  Created by 冀 睿哲 on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FMDB.h"


@implementation FMDB

/*
 初始化
 */
- (id)initWithPath:(NSString*)aPath {
    self = [super init];
	
    if (self) {
        db = [[FMDatabase alloc] initWithPath:aPath];
    }
	
	return self;
}

- (void)dealloc {
    //先关闭在释放
    [db close];
    [db release];
	
    [super dealloc];
}

- (BOOL) open {
    return [db open];
}

- (NSString *) databasePath {
    return [db databasePath];
}

- (NSString*) lastErrorMessage {
    return [db lastErrorMessage];
}

- (int) lastErrorCode {
    return [db lastErrorCode];
}
- (BOOL) hadError {
    return [db hadError];
}

- (sqlite_int64) lastInsertRowId {
    return [db lastInsertRowId];
}

- (sqlite3*) sqliteHandle {
    return [db sqliteHandle];
}

- (BOOL) executeUpdate:(NSString*)sql, ... {
    va_list args;
    va_start(args, sql);
    
    BOOL result = [db executeUpdate:sql withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (BOOL) executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments {
    return [db executeUpdate:sql withArgumentsInArray:arguments];
}

- (id) executeQuery:(NSString*)sql, ... {
    va_list args;
    va_start(args, sql);
    
    id result = [db executeQuery:sql withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (id) executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments {
    return [db executeQuery:sql withArgumentsInArray:arguments];
}

- (BOOL) rollback {
    return [db rollback];
}
- (BOOL) commit {
    return [db commit];
}
- (BOOL) beginTransaction {
    return [db beginTransaction];
}
- (BOOL) beginDeferredTransaction {
    return [db beginDeferredTransaction];
}

- (BOOL)logsErrors {
    return [db logsErrors];
}

- (void)setLogsErrors:(BOOL)flag {
    return [db setLogsErrors:flag];
}

- (BOOL)crashOnErrors {
    return [db crashOnErrors];
}

- (void)setCrashOnErrors:(BOOL)flag {
    return [db setLogsErrors:flag];
}

- (BOOL)inUse {
    return [db inUse];
}

- (void)setInUse:(BOOL)value {
    return [db setInUse:value];
}

- (BOOL)inTransaction {
    return [db inTransaction];
}

- (void)setInTransaction:(BOOL)flag {
    return [db setInTransaction:flag];
}

- (BOOL)traceExecution {
    return [db traceExecution];
}

- (void)setTraceExecution:(BOOL)flag {
    return [db setTraceExecution:flag];
}

- (BOOL)checkedOut {
    return [db checkedOut];
}

- (void)setCheckedOut:(BOOL)flag {
    return [db setCheckedOut:flag];
}

- (int)busyRetryTimeout {
    return [db busyRetryTimeout];
}

- (void)setBusyRetryTimeout:(int)newBusyRetryTimeout {
    return [db setBusyRetryTimeout:newBusyRetryTimeout];
}

- (BOOL)shouldCacheStatements {
    return [db shouldCacheStatements];
}

- (void)setShouldCacheStatements:(BOOL)value {
    return [db setShouldCacheStatements:value];
}

- (NSMutableDictionary *)cachedStatements {
    return [db cachedStatements];
}

- (void)setCachedStatements:(NSMutableDictionary *)value {
    return [db setCachedStatements:value];
}

+ (NSString*) sqliteLibVersion {
    return [FMDatabase sqliteLibVersion];
}

- (int)changes {
    return [db changes];
}

@end
