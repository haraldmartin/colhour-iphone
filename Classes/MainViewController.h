//
//  MainViewController.h
//  colhour-iphone
//
//  Created by Marthin Freij on 2008-12-10.
//  Copyright Konstruktor Sweden AB 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
	IBOutlet UIView *hourView;
	IBOutlet UIView *minuteView;
	IBOutlet UIView *secondView;
	
	IBOutlet UILabel *timeLabel;
	
	NSArray *dayArray;
	NSArray *hourArray;
	NSArray *minuteArray;
	
	NSTimer *secTimer;
	NSTimer *minTimer;
	NSTimer *hrsTimer;
}

@property (nonatomic, assign) NSTimer *secTimer;
@property (nonatomic, assign) NSTimer *minTimer;
@property (nonatomic, assign) NSTimer *hrsTimer;

- (void)updatBackgroundColorForLayer:(CALayer*)layer:(NSString*)withDatePart;
- (CGColorRef)hex2CGColorRef:(char*)hexstr;
- (void)secTick:(NSTimer*)theTimer;
- (void)minTick:(NSTimer*)theTimer;
- (void)hrsTick:(NSTimer*)theTimer;
- (NSDictionary *)userInfo;

@end
