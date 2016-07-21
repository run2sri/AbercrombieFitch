//
//  AppDelegate.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "AppDelegate.h"
#import <Reachability.h>
#import "JSONWebservice.h"
#import "AFUtils.h"
#import "ProductCard.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.abercrombie.com"];

    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Network"
                                                               message:@"No Internet Connection."
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
            [theAlert show];
        });
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    // load product card records
    [self loadProductData];
    
    [NSThread sleepForTimeInterval:3.0];
    
    return YES;
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

- (void) loadProductData {
    JSONWebservice *service = [[JSONWebservice alloc] init];
    [service requestWithURL:AFProductDataServerURL withSuccessBlock:^(NSArray *datas) {
        self.productCardRecords = [NSMutableArray arrayWithCapacity:datas.count];
        for (NSDictionary *productData in datas) {
            ProductCard *product = [[ProductCard alloc] initProductCardWithDictionary:productData];
            [self.productCardRecords  addObject:product];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:AFProductDataLoaded object:nil];
    } andErrorBlock:^(NSError *error) {
        NSLog(@"Data Loading error");
    }];
}

@end
