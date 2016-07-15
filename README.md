# YUChineseSorting

一.导入头文件#import "ChineseString.h"

二.使用示例

    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                            @"开源技术",@"社区",@"开发者",@"传播",
                            @"2014",@"a1",@"100",@"中国",@"暑假作业",
                            @"键盘", @"鼠标",@"hello",@"world",@"b1",
                            nil];
    
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.letterResultArr = [ChineseString LetterSortArray:stringsToSort];
    
  
  ![log](http://static.oschina.net/uploads/space/2015/1110/095952_dh2k_868062.png)

  ![效果图](http://static.oschina.net/uploads/space/2014/0304/163611_Wclh_868062.png)

三.注意
因为中文排序里面有c的文件 pinyin.c

plan 1：

pch文件如下
例如：

      #ifdef __OBJC__
      #import "AppDelegate.h"
      #endif

      __OBJC__表示宏内引用的文件确保只被使用Objective-C语言的文件所引用，保证引用关系的清晰。

plan 2 ：

pinyin.c 改为pinyin.m
