
//  ViewController.m
//  CrashCatchDemo
//
//  Created by Vincent li on 9/5/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)clickMeCrash:(id)sender {
    NSDictionary *dis = [NSDictionary init];
    [dis setValue:nil forKey:@"haha"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/e72622831747"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                
                if (!error) {
                    NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                    NSLog(@"%@", error);
                }
                
            }] resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
