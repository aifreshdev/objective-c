//
//  Constants.m
//  CrashCatchDemo
//
//  Created by Vincent li on 9/5/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static BOOL isAppAlive;

+(BOOL)getAppAlive {
    return isAppAlive;
}

+(void)setAppAlive:(BOOL)alive{
    isAppAlive = alive;
}
@end
