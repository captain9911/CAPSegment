# CAPSegment
分段选择，每页可由同一个ViewController控制，也可由不同的ViewController分别控制。
## Demo截图
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1085.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1092.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1093.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1094.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1095.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1096.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1097.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1086.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1087.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1088.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1089.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1090.PNG)
![image](https://raw.githubusercontent.com/captain9911/CAPSegment/master/Screenshots/IMG_1091.PNG)
## 代码集成
#### 手动集成方式
向工程中导入CAPSegment下的 CAPSegmentViewController.h 和 CAPSegmentViewController.m
## 快速使用
#### 所有页面使用同一个ViewController控制
```objective-c
    NSArray *titleArray = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
    //ViewController类名
    NSString *subVCName = @"TestViewControllerOne";
    CAPSegmentViewController *segmentVC = [[CAPSegmentViewController alloc] initWithTitleArray:titleArray subViewControllerName:subVCName];
    segmentVC.pageTitle = @"统一控制";
//    segmentVC.titleWidth = 80;    //修改segment标题宽度
//    segmentVC.titleHeight = 60;   //修改segment标题高度
//    segmentVC.titleDefaultColor = [UIColor greenColor];   //修改segment标题默认颜色
//    segmentVC.titleSelectedColor = [UIColor redColor];    //修改segment标题选中后的颜色
//    segmentVC.displayCount = 5;                           //修改segment标题显示的数量
//    segmentVC.lineColor = [UIColor blueColor];            //修改segment标题与内容的分割线颜色
    [self.navigationController pushViewController:segmentVC animated:YES];
```
#### 不同页面使用不同ViewController分别控制
```objective-c
    NSArray *titleArray = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
    //ViewController类名
    NSArray *subVCNameArray = @[@"TestViewControllerOne", @"TestViewControllerTwo",
                                @"TestViewControllerThree", @"TestViewControllerFour",
                                @"TestViewControllerFive", @"TestViewControllerSix"];
    CAPSegmentViewController *segmentVC = [[CAPSegmentViewController alloc] initWithTitleArray:titleArray subViewControllerNameArray:subVCNameArray];
    segmentVC.pageTitle = @"分别控制";
//    segmentVC.titleWidth = 80;    //修改segment标题宽度
//    segmentVC.titleHeight = 60;   //修改segment标题高度
//    segmentVC.titleDefaultColor = [UIColor greenColor];   //修改segment标题默认颜色
//    segmentVC.titleSelectedColor = [UIColor redColor];    //修改segment标题选中后的颜色
//    segmentVC.displayCount = 5;                           //修改segment标题显示的数量
//    segmentVC.lineColor = [UIColor blueColor];            //修改segment标题与内容的分割线颜色
    [self.navigationController pushViewController:segmentVC animated:YES];
```