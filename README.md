# BMChineseSort
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
