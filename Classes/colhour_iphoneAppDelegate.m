//
//  colhour_iphoneAppDelegate.m
//  colhour-iphone
//
//  Created by Marthin Freij on 2008-12-10.
//  Copyright Konstruktor Sweden AB 2008. All rights reserved.
//

#import "colhour_iphoneAppDelegate.h"
#import "RootViewController.h"

@implementation colhour_iphoneAppDelegate


@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [rootViewController release];
    [window release];
    [super dealloc];
}

@end
