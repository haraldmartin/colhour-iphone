//
//  colhour_iphoneAppDelegate.h
//  colhour-iphone
//
//  Created by Marthin Freij on 2008-12-10.
//  Copyright Konstruktor Sweden AB 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface colhour_iphoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

