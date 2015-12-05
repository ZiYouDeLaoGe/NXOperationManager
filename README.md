# NXOperationManager
多线程异步处理数据

#CacheFileDemo
异步缓存文件demo

##FileCacheManager使用说明##

###建立**FileCacheModel**对象###
**FileCacheModel** * fileCacheModel = [[**FileCacheModel** alloc] init];
fileCacheModel.fileName = @"定风波.苏轼";
fileCacheModel.fileData = [content dataUsingEncoding:NSUTF8StringEncoding];
fileCacheModel.fileType = @"txt";
文件名、数据不能为空

###建立**FileCacheOperationManager**对象###
**FileCacheOperationManager** * fileCacheOperationManager =[[**FileCacheOperationManager** alloc] initWithSearchPathModel:NXSearchPathModelCache rootFilePath:@"宋词.苏轼"];
[fileCacheOperationManager cacheFileWith:fileCacheModel success:^(FileCacheOperation *operation, NSString *filePath) {
    NSLog(@"%@",filePath);
    dispatch_async(dispatch_get_main_queue(), ^{
        _filePathLabel.text = filePath;//根据需求是否切换到主线程
    });
} failure:^(FileCacheOperation *operation, NSString *errorInfo) {
    NSLog(@"%@",errorInfo);
    dispatch_async(dispatch_get_main_queue(), ^{
        _filePathLabel.text = errorInfo;
    });
}];

可以进行二次封装，类似于AFNetworking


