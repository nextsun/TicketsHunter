//
//  FMDB.h
//  FMDBTest
//
//  Created by 冀 睿哲 on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//  仅是对已有FMDatabase的方法进行了一次封装，以防止FMDatabase变动后程序代码的修改
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface FMDB : NSObject {
    FMDatabase *db;
}

- (id)initWithPath:(NSString*)inPath;
- (BOOL) open;
- (NSString *) databasePath;

- (NSString*) lastErrorMessage;

- (int) lastErrorCode;
- (BOOL) hadError;
- (sqlite_int64) lastInsertRowId;

- (sqlite3*) sqliteHandle;

- (BOOL) executeUpdate:(NSString*)sql, ...;
- (BOOL) executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;

- (id) executeQuery:(NSString*)sql, ...;
- (id) executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

- (BOOL) rollback;
- (BOOL) commit;
- (BOOL) beginTransaction;
- (BOOL) beginDeferredTransaction;

- (BOOL)logsErrors;
- (void)setLogsErrors:(BOOL)flag;

- (BOOL)crashOnErrors;
- (void)setCrashOnErrors:(BOOL)flag;

- (BOOL)inUse;
- (void)setInUse:(BOOL)value;

- (BOOL)inTransaction;
- (void)setInTransaction:(BOOL)flag;

- (BOOL)traceExecution;
- (void)setTraceExecution:(BOOL)flag;

- (BOOL)checkedOut;
- (void)setCheckedOut:(BOOL)flag;

- (int)busyRetryTimeout;
- (void)setBusyRetryTimeout:(int)newBusyRetryTimeout;

- (BOOL)shouldCacheStatements;
- (void)setShouldCacheStatements:(BOOL)value;

- (NSMutableDictionary *)cachedStatements;
- (void)setCachedStatements:(NSMutableDictionary *)value;


+ (NSString*) sqliteLibVersion;


- (int)changes;

@end
