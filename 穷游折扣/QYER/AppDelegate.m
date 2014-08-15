//
//  AppDelegate.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstShowViewController.h"
#import "ShowViewController.h"
#import "UMSocialWechatHandler.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   NSUserDefaults *defau=[NSUserDefaults standardUserDefaults];
    NSString *str=[defau objectForKey:@"string"];
    if (str.length==0) {
        [self showUinavigationcontroller];
    }else{
        [self showviewcontroller];
    }

    [UMSocialWechatHandler setWXAppId:@"wxd775c7e7cefe47ff" url:nil];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

-(void)showUinavigationcontroller{
    FirstShowViewController *first=[[FirstShowViewController alloc]init];
    self.window.rootViewController=first;
}
-(void)showviewcontroller{
    ShowViewController *show=[[ShowViewController alloc]init];
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:show];
    self.revealSideViewController = [[PPRevealSideViewController alloc]initWithRootViewController:nv];
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
    //[self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    self.window.rootViewController=self.revealSideViewController;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
