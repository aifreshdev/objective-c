//
//  ViewController.m
//  InfiniteScrollViewDemo
//
//  Created by Vincent li on 3/7/2018.
//  Copyright © 2018 Vincent li. All rights reserved.
//

#import "ViewController.h"
#import "InfiniteScrollView.h"

@interface ViewController ()
@property (assign, nonatomic)  IBOutlet InfiniteScrollView *infiniteScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_infiniteScrollView initData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
