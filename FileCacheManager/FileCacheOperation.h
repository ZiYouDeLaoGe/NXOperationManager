//
//  FileCacheOperation.h
//  OAConnect
//
//  Created by 李仁兵 on 15/12/4.
//  Copyright © 2015年 zengxiangrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXOperation.h"
#import "FileCacheManager.h"

@interface FileCacheOperation : NXOperation

- (instancetype)initWithFileCacheModel:(FileCacheModel *)fileCacheModel searchPathModel:(NXSearchPathModel)searchPathModel rootFilePath:(NSString *)rootFilePath;


- (void)setCompletionBlockWithSuccess:(void (^)(FileCacheOperation *operation, NSString * filePath))success failure:(void (^)(FileCacheOperation *operation, NSString * errorInfo))failure;
@end
