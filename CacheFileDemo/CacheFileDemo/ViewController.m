//
//  ViewController.m
//  CacheFileDemo
//
//  Created by 李仁兵 on 15/12/5.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import "ViewController.h"
#import "FileCacheOperationManager.h"

@interface ViewController ()
{
    UILabel * _filePathLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filePathLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 300)];
    _filePathLabel.textColor = [UIColor blackColor];
    _filePathLabel.numberOfLines = 0;
    [self.view addSubview:_filePathLabel];
    
    //缓存文件
    NSString * content = @"定风波 苏轼\n（三月七日沙湖道中遇雨。雨具先去，同行皆狼狈，余独不觉。已而遂晴，故作此 ）。\n莫听穿林打叶声，何妨吟啸且徐行。竹杖芒鞋轻胜马，谁怕？ 一蓑烟雨任平生。\n料峭春风吹酒醒，微冷，山头斜照却相迎。回首向来萧瑟处，归去，也无风雨也无晴。";
    FileCacheModel * fileCacheModel = [[FileCacheModel alloc] init];
    fileCacheModel.fileName = @"定风波.苏轼";
    fileCacheModel.fileData = [content dataUsingEncoding:NSUTF8StringEncoding];
    fileCacheModel.fileType = @"txt";
    
    FileCacheOperationManager * fileCacheOperationManager =[[FileCacheOperationManager alloc] initWithSearchPathModel:NXSearchPathModelCache rootFilePath:@"宋词.苏轼"];
    [fileCacheOperationManager cacheFileWith:fileCacheModel success:^(FileCacheOperation *operation, NSString *filePath) {
        NSLog(@"%@",filePath);
        dispatch_async(dispatch_get_main_queue(), ^{
            _filePathLabel.text = filePath;
        });
    } failure:^(FileCacheOperation *operation, NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
        dispatch_async(dispatch_get_main_queue(), ^{
            _filePathLabel.text = errorInfo;
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
