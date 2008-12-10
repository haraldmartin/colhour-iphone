//
//  MainViewController.m
//  colhour-iphone
//
//  Created by Marthin Freij on 2008-12-10.
//  Copyright Konstruktor Sweden AB 2008. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainViewController

@synthesize secTimer;
@synthesize minTimer;
@synthesize hrsTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		dayArray = [NSArray arrayWithObjects:
					@"8300FF", @"6200FF", @"3F00FF", @"1F00FF", @"3F00FF", @"0043FF",
					@"0081FF", @"00C3FF", @"00FFFB", @"00FFBF", @"00FF81", @"00FF3F",
					@"00FF02", @"3DFF00", @"7DFF00", @"BCFF00", @"FCFF00", @"FFC400",
					@"FF8A00", @"FF4C00", @"FF1300", @"E80030", @"E80030", @"C70074", nil];
		
		[dayArray retain];
		
		hourArray = [NSArray arrayWithObjects:
					 @"8200FF", @"7400FF", @"6600FF", @"5900FF", @"4A00FF", @"3D00FF",
					 @"3000FF", @"2300FF", @"1700FF", @"0700FF", @"000AFF", @"0026FF",
					 @"003EFF", @"0058FF", @"008AFF", @"008AFF", @"00A6FF", @"00BEFF",
					 @"00F0FF", @"00FFF3", @"00FFF3", @"00FFDE", @"00FFC1", @"00FFA7",
					 @"00FF8D", @"00FF75", @"00FF5A", @"00FF42", @"00FF2C", @"00FF0F",
					 @"0BFF00", @"25FF00", @"3EFF00", @"56FF00", @"71FF00", @"89FF00",
					 @"89FF00", @"BFFF00", @"D9FF00", @"F3FF00", @"FFF400", @"FFDB00",
					 @"FFC400", @"FFA800", @"FF9300", @"FF7800", @"FF6300", @"FF4900",
					 @"FF3000", @"FF1900", @"FF0000", @"F30018", @"E40037", @"D8004F",
					 @"CA006D", @"BD0087", @"B000A2", @"A200C0", @"9C00CC", @"8F00E7", nil];
		
		[hourArray retain];
		
		minuteArray = [NSArray arrayWithObjects:
					   @"8200FF", @"7400FF", @"6600FF", @"5900FF", @"4A00FF", @"3D00FF", 
					   @"3000FF", @"2300FF", @"1700FF", @"0700FF", @"000AFF", @"0026FF",
					   @"003EFF", @"0058FF", @"008AFF", @"008AFF", @"00A6FF", @"00BEFF",
					   @"00F0FF", @"00FFF3", @"00FFF3", @"00FFDE", @"00FFC1", @"00FFA7",
					   @"00FF8D", @"00FF75", @"00FF5A", @"00FF42", @"00FF2C", @"00FF0F",
					   @"0BFF00", @"25FF00", @"3EFF00", @"56FF00", @"71FF00", @"89FF00",
					   @"89FF00", @"BFFF00", @"D9FF00", @"F3FF00", @"FFF400", @"FFDB00",
					   @"FFC400", @"FFA800", @"FF9300", @"FF7800", @"FF6300", @"FF4900", 
					   @"FF3000", @"FF1900", @"FF0000", @"F30018", @"E40037", @"D8004F", 
					   @"CA006D", @"BD0087", @"B000A2", @"A200C0", @"9C00CC", @"8F00E7", nil];
		
		[minuteArray retain];
		
    }
    return self;
}

- (void)secTick:(NSTimer*)theTimer
{
	[self updatBackgroundColorForLayer:secondView.layer :@"ss"];
}

- (void)minTick:(NSTimer*)theTimer
{
	[self updatBackgroundColorForLayer:minuteView.layer :@"mm"];	
}

- (void)hrsTick:(NSTimer*)theTimer
{
	[self updatBackgroundColorForLayer:hourView.layer :@"HH"];
}

- (void)updatBackgroundColorForLayer:(CALayer*)layer:(NSString*)withDatePart
{
	// Create date formatter
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
	// Get datepart as int
	[formatter setDateFormat:withDatePart];
	int index = [[formatter stringFromDate:[NSDate date]] intValue];
	
	/*
	 Använd 
	 NSDateComponents
	 NSCalendar
	 */
	
	// Set time label
	[formatter setDateFormat:@"HH:mm:ss"];
	[timeLabel setText:[formatter stringFromDate:[NSDate date]]];
	
	// Release formatter
	[formatter release];
	
	NSString *curColorAsHex = nil;
	NSString *nxtColorAsHex = nil;
	float duration = 1.0;
	
	if ([withDatePart isEqualToString:@"ss"])
	{
		duration = 1.0;
		int nxtIndex = index+1 == 60 ? 0 : index+1;
		curColorAsHex = [minuteArray objectAtIndex:index];
		nxtColorAsHex = [minuteArray objectAtIndex:nxtIndex];
	}
	else if ([withDatePart isEqualToString:@"mm"])
	{
		duration = 60.0;
		int nxtIndex = index+1 == 60 ? 0 : index+1;
		curColorAsHex = [hourArray objectAtIndex:index];
		nxtColorAsHex = [hourArray objectAtIndex:nxtIndex];
	}
	else if ([withDatePart isEqualToString:@"HH"])
	{
		duration = 60*60;
		int nxtIndex = index+1 == 24 ? 0 : index+1;
		curColorAsHex = [dayArray objectAtIndex:index];
		nxtColorAsHex = [dayArray objectAtIndex:nxtIndex];
	}
	
	// Get CGColorRef from HEX
	CGColorRef curColor = [self hex2CGColorRef:(char*)[curColorAsHex UTF8String]];
	CGColorRef nxtColor = [self hex2CGColorRef:(char*)[nxtColorAsHex UTF8String]];
	
	// Create and setup the animation
	CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
	colorAnimation.removedOnCompletion = YES;
	colorAnimation.repeatCount = 0;
	colorAnimation.duration = duration;
	colorAnimation.fillMode = kCAFillModeBoth;
	colorAnimation.fromValue = (id)curColor;
	colorAnimation.toValue = (id)nxtColor;
	
	NSString *animationName = [NSString stringWithFormat:@"%@Animation", withDatePart];
	
	[layer addAnimation:colorAnimation forKey:animationName];
	
	[layer setBackgroundColor:nxtColor];
	
	[curColorAsHex release];
	[nxtColorAsHex release];
	
	//	CGColorRelease(curColor);
	//	CGColorRelease(nxtColor);
}

- (NSDictionary *)userInfo
{
	return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

- (CGColorRef)hex2CGColorRef:(char*)hexstr
{
	unsigned int hex = 0;
	sscanf(hexstr, "%X", &hex);
	
	float r = (0xFF & (hex >> 0x10)) / 255.0;
	float g = (0xFF & (hex >> 0x8)) / 255.0;
	float b = (0xFF & (hex)) / 255.0;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float c1[4] = {r, g, b, 1.0};
	CGColorRef c = CGColorCreate(colorSpace, c1);
	[NSMakeCollectable(colorSpace) autorelease];
	[NSMakeCollectable(c) autorelease];
	return c;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[self updatBackgroundColorForLayer:secondView.layer :@"ss"];
	[self updatBackgroundColorForLayer:minuteView.layer :@"mm"];
	[self updatBackgroundColorForLayer:hourView.layer :@"HH"];
	
	NSTimer *t1 = [NSTimer scheduledTimerWithTimeInterval:1.0 
												   target:self
												 selector:@selector(secTick:)
												 userInfo:[self userInfo]
												  repeats:YES];
	
	NSTimer *t2 = [NSTimer scheduledTimerWithTimeInterval:60.0 
												   target:self
												 selector:@selector(minTick:)
												 userInfo:[self userInfo]
												  repeats:YES];
	
	NSTimer *t3 = [NSTimer scheduledTimerWithTimeInterval:3600.0 
												   target:self
												 selector:@selector(hrsTick:)
												 userInfo:[self userInfo]
												  repeats:YES];
	
    self.secTimer = t1;
	self.minTimer = t2;
	self.hrsTimer = t3;
	
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	
	[dayArray release];
	[hourArray release];
	[minuteArray release];
	
	[secTimer invalidate];
	[minTimer invalidate];
	[hrsTimer invalidate];
	
	self.secTimer = nil;
	self.minTimer = nil;
	self.hrsTimer = nil;
	
	[super dealloc];
}

@end
