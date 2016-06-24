//
//  ViewController.m
//  CAPSegmentDemo
//
//  Created by captain9911 on 16/6/22.
//  Copyright © 2016年 captain9911. All rights reserved.
//

#import "ViewController.h"
#import "CAPSegmentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CAPSegmentDemo";
    
    UIButton *singleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    singleButton.frame = CGRectMake(50, 100, 80, 30);
    [singleButton setTitle:@"统一控制" forState:UIControlStateNormal];
    [singleButton addTarget:self action:@selector(clickedOnSingleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:singleButton];
    
    UIButton *multipleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    multipleButton.frame = CGRectMake(50, 150, 80, 30);
    [multipleButton setTitle:@"分别控制" forState:UIControlStateNormal];
    [multipleButton addTarget:self action:@selector(clickedOnMultipleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multipleButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 操作响应
- (void)clickedOnSingleButton:(id)sender {
    NSArray *titleArray = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
    NSString *subVCName = @"TestViewControllerOne";
    CAPSegmentViewController *segmentVC = [[CAPSegmentViewController alloc] initWithTitleArray:titleArray subViewControllerName:subVCName];
    segmentVC.pageTitle = @"统一控制";
//    segmentVC.titleWidth = 80;
//    segmentVC.titleHeight = 60;
//    segmentVC.titleDefaultColor = [UIColor greenColor];
//    segmentVC.titleSelectedColor = [UIColor redColor];
//    segmentVC.displayCount = 5;
//    segmentVC.lineColor = [UIColor blueColor];
    [self.navigationController pushViewController:segmentVC animated:YES];
}

- (void)clickedOnMultipleButton:(id)sender {
    NSArray *titleArray = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
    NSArray *subVCNameArray = @[@"TestViewControllerOne", @"TestViewControllerTwo",
                                @"TestViewControllerThree", @"TestViewControllerFour",
                                @"TestViewControllerFive", @"TestViewControllerSix"];
    CAPSegmentViewController *segmentVC = [[CAPSegmentViewController alloc] initWithTitleArray:titleArray subViewControllerNameArray:subVCNameArray];
    segmentVC.pageTitle = @"分别控制";
//    segmentVC.titleWidth = 80;
//    segmentVC.titleHeight = 60;
//    segmentVC.titleDefaultColor = [UIColor greenColor];
//    segmentVC.titleSelectedColor = [UIColor redColor];
//    segmentVC.displayCount = 5;
//    segmentVC.lineColor = [UIColor blueColor];
    [self.navigationController pushViewController:segmentVC animated:YES];
}

@end
