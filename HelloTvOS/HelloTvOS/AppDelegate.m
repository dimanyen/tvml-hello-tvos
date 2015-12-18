//
//  AppDelegate.m
//  HelloTvOS
//
//  Created by diman.yen on 2015/12/14.
//  Copyright © 2015年 Vascreative. All rights reserved.
//

#import "AppDelegate.h"
#import <TVMLKit/TVMLKit.h>

static NSString *TVBaseURL = @"https://raw.githubusercontent.com/dimanyen/tvml-hello-tvos/master/webserver/hellotvos/";
static NSString *TVBootURL = @"https://raw.githubusercontent.com/dimanyen/tvml-hello-tvos/master/webserver/hellotvos/js/application.js";

@interface AppDelegate ()<TVApplicationControllerDelegate>
{
    TVApplicationController *theappController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    TVApplicationControllerContext *context = [[TVApplicationControllerContext alloc] init];
    NSURL *javaScriptURL = [NSURL URLWithString:TVBootURL];
    if (javaScriptURL) {
        context.javaScriptApplicationURL = javaScriptURL;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:TVBaseURL forKey:@"BASEURL"];
    
    if (launchOptions) {
        for (NSString *key in launchOptions) {
            [dict setValue:[launchOptions objectForKey:key] forKey:key];
        }
    }
    context.launchOptions = dict;
    theappController = [[TVApplicationController alloc] initWithContext:context window:self.window delegate:self];
    
    return YES;
}

- (void)appController:(TVApplicationController *)appController didFinishLaunchingWithOptions:(NSDictionary<NSString *,id> *)options
{
    
}

- (void)appController:(TVApplicationController *)appController didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error.localizedDescription);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Launching Appplication" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [theappController.navigationController presentViewController:alert animated:YES completion:nil];
    
}

- (void)appController:(TVApplicationController *)appController didStopWithOptions:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"%@",options.description);
}

- (void)appController:(TVApplicationController *)appController evaluateAppJavaScriptInContext:(JSContext *)jsContext
{
    [jsContext evaluateScript:@"var console = {log: function() { var message = ''; for(var i = 0; i < arguments.length; i++) { message += arguments[i] + ' ' }; console.print(message) } };"];
    void (^logFunction)(NSString *) = ^(NSString *msg)
    {
        NSLog(@"%@",msg);
    };
    [[jsContext objectForKeyedSubscript:@"console"] setObject:logFunction forKeyedSubscript:@"print"];

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
