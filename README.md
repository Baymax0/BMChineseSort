# BMChineseSort

一.导入头文件#import "BMChineseSort.h"

二.使用示例

    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"李白",@"张三",
                            @"黄晓明",@"成龙",@"斑马",@"盖伦",
                            @"幻刺",@"暗影猎手",@"小白",@"小明",@"千珏",
                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",
                            nil];
    //模拟网络请求接收到的数组对象
    array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[stringsToSort count]; i++) {
        Person *p = [[Person alloc] init];
        p.name = [stringsToSort objectAtIndex:i];
        p.number = i;
        [array addObject:p];
    }
    //排序
    self.indexArray = [BMChineseSort IndexWithArray:array Key:@"name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:array Key:@"name"];

二.运行效果
![](http://upload-images.jianshu.io/upload_images/1640181-42fd65f8dd151a40.gif?imageMogr2/auto-orient/strip)
