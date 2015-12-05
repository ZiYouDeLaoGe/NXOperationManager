//
//  ViewController.m
//  CacheFileDemo
//
//  Created by 李仁兵 on 15/12/5.
//  Copyright © 2015年 李仁兵. All rights reserved.
//

#import "ViewController.h"
#import "FileCacheOperationManager.h"

#import "SongCiCacheOperationManager.h"

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
    
    
    NSString * content2 = @"少年听雨歌楼上。红烛昏罗帐。壮年听雨客舟中。江阔云低、断雁叫西风。\n而今听雨僧庐下。鬓已星星也。悲欢离合总无情。一任阶前、点滴到天明。";
    FileCacheModel * fileCacheModel2 = [[FileCacheModel alloc] init];
    fileCacheModel2.fileName = @"虞美人·听雨";
    fileCacheModel2.fileData = [content2 dataUsingEncoding:NSUTF8StringEncoding];
    fileCacheModel2.fileType = @"txt";
    
    
    //二次封装应用
    [[SongCiCacheOperationManager sharedSongciCacheOperationManager] cacheFileWith:fileCacheModel success:^(FileCacheOperation *operation, NSString *filePath) {
        NSLog(@"二次封装----%@",filePath);
    } failure:^(FileCacheOperation *operation, NSString *errorInfo) {
        NSLog(@"二次封装----%@",errorInfo);
    }];
    
    [[SongCiCacheOperationManager sharedSongciCacheOperationManager] cacheFileWith:fileCacheModel2 success:^(FileCacheOperation *operation, NSString *filePath) {
        NSLog(@"二次封装----%@",filePath);
    } failure:^(FileCacheOperation *operation, NSString *errorInfo) {
        NSLog(@"二次封装----%@",errorInfo);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
