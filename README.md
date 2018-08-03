BMChineseSort
=======================
[![Use Language](https://img.shields.io/badge/language-objc-green.svg)](https://github.com/Baymax0/BMChineseSort)
[![Use Language](https://img.shields.io/badge/version-0.2.0-blue.svg)](https://github.com/Baymax0/BMChineseSort)

## 介绍
`BMChineseSort`是一个为模型、字典、字符串数组根据特定中文属性基于tableview分组优化的工具类，基于异步、多线程降低排序时间。对于多音字的问题，开放了一个映射属性，可手动修改个别多音字或你想要的映射关系。


## 使用 事例 (TableView分组排序)

### 模型排序

普通自定义的模型对象
```objective-c
//Person模型
@interface Person : NSObject
@property (strong , nonatomic) NSString * name;
@property (assign , nonatomic) NSInteger number;
@end
```

使用sortWithArray方法进行排序
```objective-c
NSMutableArray<Person*> *dataArr;//数据源
NSMutableArray *firstLetterArray;//排序后的出现过的拼音首字母数组
NSMutableArray *sortedModelArr;//排序好的结果数组
[BMChineseSort sortWithArray:dataArr key:@"name" finish:^(bool isSuccess, NSMutableArray<NSString *> *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [_tableView reloadData];
        }
    }];
```

使用排序结果
```objective-c
    //section的titleHeader
    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return [self.indexArray objectAtIndex:section];
    }
    //section行数
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return [self.indexArray count];
    }
    //每组section个数
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [[self.letterResultArr objectAtIndex:section] count];
    }
    //section右侧index数组
    -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
        return self.indexArray;
    }
    //点击右侧索引表项时调用 索引与section的对应关系
    - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
        return index;
    }
    //返回cell
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        }
        //获得对应的Person对象<替换为你自己的model对象>
        Person *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = p.name;
        return cell;
    }
```


### 字符串排序
使用方法与模型排序相同，注意 key = nil,否则排序失败。
```objective-c
NSMutableArray * provinceArr = @[@"北京",@"河南",@"重庆",@"沈阳",@"长春",@"abc",];
//字符串数组 key 传nil 即可
[BMChineseSort sortWithArray:provinceArr key:nil finish:^(bool isSuccess, NSMutableArray<NSString *> *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        // sortedObjArr是NSMutableArray<NSMutableArray *<NSString*>>类型
}];
```

## 设置

通过 `BMChineseSortSetting.share` 来进行设置

### 拼音转换方式替换

两种方法都是基于多线程异步操作后进行优化了。

- sortMode=1 使用CFStringTransform 方法转换，比较耗时

- sortMode=2 使用汉字码表对应的首字母码表，通过编码顺序查找，比较快，码表来源于网络 不保证准确性，可以码表配合polyphoneMapping手动修改错误的映射

```objective-c
BMChineseSortSetting.share.sortMode = 1
```

### 剔除不要特定字符开头的元素

如果想过滤 某些字符开头的元素，使用 `ignoreModelWithPrefix`，下面例子中剔除了所有元素中对应key的值是`数字`开头的元素
```objective-c
BMChineseSortSetting.share.ignoreModelWithPrefix = @"0123456789"
```

### 多音字映射

实际使用中如果遇到想手动映射拼音的 可以使用到`polyphoneMapping`完成映射,由于多音字在本地中是无法动态解决的，如果不是通过后台获取的拼音，则只能通过手动过滤的方法了。
如果你觉得常用的，可以在issue中提出来，我更新在默认值中。

- 使用格式: {"匹配的文字":"对应的首字母(大写)"}

```objective-c
//使用时不需要添加，直接赋值即可，不会覆盖上一次的值
BMChineseSortSetting.share.polyphoneMapping = @{@"长安":@"CA"};
BMChineseSortSetting.share.polyphoneMapping = @{@"长":@"C"};//所有长 都映射为chang(C)
BMChineseSortSetting.share.polyphoneMapping = @{@"厦门":@"XM",@"重庆":@"CQ"};
```


## Migration

### Version 0.2.0

1.合并`IndexWithArray:`和`sortObjectArray`方法，减少对数据的多次遍历造成的时间浪费，

2.同时添加将排序转入后台多线程，使用block回调拿到数据。

3.将模型与字符串排序合并为一个方法，使用通过key区分。

<!-- 
sublime编辑时自动刷新用:
<meta http-equiv="refresh" content="8"> 
-->


