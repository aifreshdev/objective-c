//
//  AppDelegate.m
//  CrashCatchDemo
//
//  Created by Vincent li on 9/5/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"Crash State : %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"crashReporter"]);
    
    [Constants setAppAlive:(YES)];
    NSSetUncaughtExceptionHandler(&appHandleException);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

void appHandleException(NSException* exception){
    //[[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]
    NSLog(@"Apps Crash!!");
    
    __block UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithName:@"CrashReporter" expirationHandler:^{
        NSLog(@"CrashReporter : %d", [Constants getAppAlive]);
        
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
        
//        if([Constants getAppAlive]){
            [[NSUserDefaults standardUserDefaults] setValue:@"Apps Crash Background Task!!" forKey:@"crashReporter"];
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
//        }
    }];

    [app performSelector:@selector(suspend)];
    
        // Start the long-running task and return immediately.
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
            // Do the work associated with the task, preferably in chunks.
            
            //[app endBackgroundTask:bgTask];
            //bgTask = UIBackgroundTaskInvalid;
//        });
//    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
