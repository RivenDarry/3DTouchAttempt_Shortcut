//
//  AppDelegate.m
//  3DTouchAttempt
//
//  Created by mac on 16/1/27.
//
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CheckinViewController.h"
#import "InviteViewController.h"

@interface AppDelegate ()
{
    UINavigationController *navVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"rootVC"];
    navVC = [[UINavigationController alloc]initWithRootViewController:vC];
    self.window.rootViewController = navVC;
    [_window makeKeyAndVisible];

    
//    NSString *string = [NSString stringWithFormat:@"%@", launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"]];
//    if (string.length == 0) {
//        return false;
//    }
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if ([shortcutItem.type isEqualToString:@"shortcutInviteFriend"]) {
        NSLog(@"BINGO!");
    }else if ([shortcutItem.type isEqualToString:@"inviteDetail"]) {
        InviteViewController *inviteVC = [storyboard instantiateViewControllerWithIdentifier:@"inviteDetail"];
        [navVC pushViewController:inviteVC animated:YES];
    }else if ([shortcutItem.type isEqualToString:@"checkin"]) {
        CheckinViewController *checkinVC = [storyboard instantiateViewControllerWithIdentifier:@"checkin"];
        [navVC pushViewController:checkinVC animated:YES];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
