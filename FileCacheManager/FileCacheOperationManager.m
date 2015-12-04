//
//  FileCacheOperationManager.m
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import "FileCacheOperationManager.h"

@interface FileCacheOperationManager ()
{
    NXSearchPathModel _searchPathModel;
    NSString * _rootFilePath;
}
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation FileCacheOperationManager
- (instancetype)initWithSearchPathModel:(NXSearchPathModel)searchPathModel rootFilePath:(NSString *)rootFilePath
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.operationQueue = [[NSOperationQueue alloc] init];
    _searchPathModel = searchPathModel;
    _rootFilePath = rootFilePath;
    return self;
}

- (FileCacheOperation *)cacheFileWith:(FileCacheModel *)fileCacheModel success:(void (^)(FileCacheOperation *, NSString *))success failure:(void (^)(FileCacheOperation *))failure
{
    FileCacheOperation * fileCacheOperation = [[FileCacheOperation alloc] initWithFileCacheModel:fileCacheModel searchPathModel:_searchPathModel rootFilePath:_rootFilePath];
    [fileCacheOperation setCompletionBlockWithSuccess:success failure:failure];
    [self.operationQueue addOperation:fileCacheOperation];
    return fileCacheOperation;
}

@end
