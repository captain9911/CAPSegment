//
//  CAPSegmentViewController.m
//  CAPSegment
//
//  Created by captain9911 on 16/6/22.
//  Copyright © 2016年 captain9911. All rights reserved.
//  https://github.com/captain9911/CAPSegment.git

#import "CAPSegmentViewController.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

#define kTitleScrollViewHeight          44
#define kTitleButtonDefaultWidth        70
#define kDisplayDefaultCount            4

#define kTitleDefaultColor      [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
#define kTitleSelectedColor     [UIColor colorWithRed:57/255.0 green:148/255.0 blue:231/255.0 alpha:1.0]
#define kTitleBackgroundColor   [UIColor whiteColor]
#define kLineDefaultColor       [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]

@interface CAPSegmentViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (retain, nonatomic) NSMutableArray *pages;
@property (retain, nonatomic) UIPageViewController *pageViewController;

@end

@implementation CAPSegmentViewController
{
    NSArray *_titleArray;           //分类标题数组
    NSArray *_subVCNameArray;       //子页面 VC名称
    UIScrollView *_titleScrollView; //分类选项
    UIView *_markView;              //下方的标记
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _pageTitle;
    if (!_titleWidth) {
        _titleWidth = kTitleButtonDefaultWidth;
    }
    if (!_titleHeight) {
        _titleHeight = kTitleScrollViewHeight;
    }
    if (!_titleDefaultColor) {
        _titleDefaultColor = kTitleDefaultColor;
    }
    if (!_titleSelectedColor) {
        _titleSelectedColor = kTitleSelectedColor;
    }
    if (!_titleBackgroundColor) {
        _titleBackgroundColor = kTitleBackgroundColor;
    }
    if (!_displayCount) {
        _displayCount = kDisplayDefaultCount;
    }
    if (_displayCount > _titleArray.count) {
        _displayCount = _titleArray.count;
    }
    if (!_lineColor) {
        _lineColor = kLineDefaultColor;
    }

    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _titleHeight)];
    _titleScrollView.backgroundColor = _titleBackgroundColor;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
    
    [self initTitleScrollView];
    
    self.pages = [[NSMutableArray alloc] init];
    for (int i = 0; i < _titleArray.count; i ++) {
        NSString *subVCName;
        if (_subVCNameArray.count - 1 < i) {
            //当控制器数量少于标题数量时，复用最后一个控制器，使控制器数量与标题数量相等
            subVCName = [_subVCNameArray lastObject];
        } else {
            subVCName = [_subVCNameArray objectAtIndex:i];
        }
        Class subVC = NSClassFromString(subVCName);
        UIViewController *vc = [[subVC alloc] init];
        vc.title = [_titleArray objectAtIndex:i];
        [self.pages addObject:vc];
    }
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    CGRect pageVCFrame = self.pageViewController.view.frame;
    pageVCFrame.origin.y = _titleHeight;
    pageVCFrame.size.height -= _titleHeight;
    self.pageViewController.view.frame = pageVCFrame;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages firstObject]];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化方法
//传入标题数组，适用于各标题对应相同的控制器
- (instancetype)initWithTitleArray:(NSArray *)titleArray subViewControllerName:(NSString *)subVCName {
    self = [super init];
    _titleArray = titleArray;
    _subVCNameArray = [NSArray arrayWithObject:subVCName];
    return self;
}

//传入标题、控制器名的数组，适用于不同的标题对应不同的控制器
- (instancetype)initWithTitleArray:(NSArray *)titleArray subViewControllerNameArray:(NSArray *)subVCNameArray {
    self = [super init];
    _titleArray = titleArray;
    _subVCNameArray = subVCNameArray;
    return self;
}

#pragma mark - 对象方法
//获取按钮的OriginX
- (CGFloat)getButtonOriginXWithSpace:(CGFloat)space buttonIndex:(NSInteger)buttonIndex {
    CGFloat originX;
    originX = space + (_titleWidth + space * 2) * buttonIndex;
    return originX;
}

//初始化类型选择栏
- (void)initTitleScrollView {
    CGFloat space = (kScreenWidth - _titleWidth * _displayCount) / (_displayCount * 2);
    //获得scrollView内容宽度
    CGFloat titleScrollViewContentWidth = [self getButtonOriginXWithSpace:space buttonIndex:_titleArray.count - 1] + _titleWidth + space;
    _titleScrollView.contentSize = CGSizeMake(titleScrollViewContentWidth, 0);
    
    for (int i = 0; i < _titleArray.count; i ++) {
        CGRect buttonFrame = CGRectMake(0, 0, _titleWidth, _titleScrollView.frame.size.height);
        buttonFrame.origin.x = [self getButtonOriginXWithSpace:space buttonIndex:i];
        UIButton *titleButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [titleButton setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [titleButton setTitleColor:_titleDefaultColor forState:UIControlStateNormal];
        [titleButton setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(clickedOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.tag = 1000+i;
        if (i == 0) {
            titleButton.selected = YES;
        }
        [_titleScrollView addSubview:titleButton];
    }
    
    //添加下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleScrollView.frame.size.height - 1, _titleScrollView.contentSize.width, 1)];
    lineView.backgroundColor = _lineColor;
    [_titleScrollView addSubview:lineView];
    
    //选中第一个分类
    _markView = [[UIView alloc] initWithFrame:CGRectMake(space, _titleScrollView.frame.size.height - 3, _titleWidth, 3)];
    _markView.backgroundColor = _titleSelectedColor;
    [_titleScrollView addSubview:_markView];
}

//更新下标的位置
- (void)updateMarkViewLocationWithButtonTag:(NSInteger)buttonTag {
    for (int i = 0 ; i < _titleArray.count; i ++) {
        UIButton *btn = (UIButton *)[_titleScrollView viewWithTag:1000+i];
        btn.selected = NO;
        if (btn.tag == buttonTag) {
            btn.selected = YES;
            CGRect markFrame = btn.frame;
            markFrame.origin.y = markFrame.size.height - _markView.frame.size.height;
            markFrame.size.height = _markView.frame.size.height;
            [UIView animateWithDuration:0.3 animations:^{
                _markView.frame = markFrame;
            }];
        }
    }
}

#pragma mark - 操作响应
//类型按钮点击
- (void)clickedOnTitleButton:(id)sender {
    UIButton *button = sender;
    [self updateMarkViewLocationWithButtonTag:button.tag];
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:button.tag - 1000]];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - UIPageViewControllerDataSource
//向前翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    [self updateMarkViewLocationWithButtonTag:currentIndex + 1000];
    //调整分类标题栏的显示位置
    if (_markView.frame.origin.x < _titleScrollView.contentSize.width - kScreenWidth/2) {
        if (_markView.frame.origin.x + _titleWidth/2 < kScreenWidth/2) {
            [UIView animateWithDuration:0.3 animations:^{
                _titleScrollView.contentOffset = CGPointMake(0, 0);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _titleScrollView.contentOffset = CGPointMake(_markView.frame.origin.x - (kScreenWidth/2 - _titleWidth/2), 0);
            }];
        }
    }
    if (currentIndex > 0) {
        return [self.pages objectAtIndex:currentIndex - 1];
    } else {
        return nil;
    }
}

//向后翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    [self updateMarkViewLocationWithButtonTag:currentIndex + 1000];
    //调整分类标题栏的显示位置
    if (_markView.frame.origin.x + _titleWidth/2 > kScreenWidth/2) {
        if (_markView.frame.origin.x + _titleWidth/2 + kScreenWidth/2 > _titleScrollView.contentSize.width) {
            [UIView animateWithDuration:0.3 animations:^{
                _titleScrollView.contentOffset = CGPointMake(_titleScrollView.contentSize.width - kScreenWidth, 0);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _titleScrollView.contentOffset = CGPointMake(_markView.frame.origin.x - (kScreenWidth/2 - _titleWidth/2), 0);
            }];
        }
    }
    if (currentIndex < self.pages.count - 1) {
        return [self.pages objectAtIndex:currentIndex + 1];
    } else {
        return nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
