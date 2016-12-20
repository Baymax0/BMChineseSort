# BMChineseSort使用方法
一.import

    #import "BMChineseSort.h"

二.获得排序结果

    self.indexArray = [BMChineseSort IndexWithArray:array Key:@"name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:array Key:@"name"];
三.使用排序结果

    #pragma mark - UITableView -
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

# 其他

添加了使用系统汉字解析的方式，通过修改BMChineseSort.h文件的BMSortMode切换
####BMSortMode==1
使用系统解析汉字拼音方法，准确性有保障，同时能区分一部分的多音字如（重庆，重量）（*经过测试发现仅仅能区分很小一部分多音字）
数据比较多的话非常耗时！非常耗时！非常耗时！、（如果数据量不大，可以使用这个）
####BMSortMode==2
使用一个放在内存中的拼音数组进行查询，对于多音字没有任何判断，但是效率远超过BMSortMode=1

可通过BMLog=1开启打印耗时进行比较后选择，默认选择BMSortMode==2
