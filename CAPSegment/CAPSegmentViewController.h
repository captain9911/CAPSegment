//
//  CAPSegmentViewController.h
//  CAPSegment
//
//  Created by captain9911 on 16/6/22.
//  Copyright © 2016年 captain9911. All rights reserved.
//  https://github.com/captain9911/CAPSegment.git

#import <UIKit/UIKit.h>

@interface CAPSegmentViewController : UIViewController

//页面标题
@property (strong, nonatomic) NSString *pageTitle;
//segment标题宽度
@property (nonatomic) CGFloat titleWidth;
//segment标题高度
@property (nonatomic) CGFloat titleHeight;
//segment默认颜色
@property (strong, nonatomic) UIColor *titleDefaultColor;
//segment选中时的颜色
@property (strong, nonatomic) UIColor *titleSelectedColor;
//segment显示的数量
@property (nonatomic) NSInteger displayCount;
//segment标题与内容的分割线颜色
@property (strong, nonatomic) UIColor *lineColor;

//传入标题数组，适用于各标题对应相同的控制器
- (instancetype)initWithTitleArray:(NSArray *)titleArray subViewControllerName:(NSString *)subVCName;
//传入标题、控制器名的数组，适用于不同的标题对应不同的控制器
- (instancetype)initWithTitleArray:(NSArray *)titleArray subViewControllerNameArray:(NSArray *)subVCNameArray;

@end
