//
//  NetworkStatusBar.m
//  Blognone8
//
//  Created by Nattapon Nimakul on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NetworkStatusBar.h"


@implementation NetworkStatusBar

static NetworkStatusBar *sharedSingleton = NULL;

#define NETWORK_STATUS_BAR_FRAME_Y 436
#define NETWORK_STATUS_BAR_FRAME_HEIGHT 33

+ (NetworkStatusBar *)sharedNetworkStatusBar {
    @synchronized(self) {
        if (sharedSingleton == NULL)
		{
			sharedSingleton = [NetworkStatusBar new];
			CGRect networkStatusBarFrame = sharedSingleton.view.frame;
			CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
			NSLog(@"%f", applicationFrame.size.height);
			
			networkStatusBarFrame.origin.x = 0;
			networkStatusBarFrame.origin.y = NETWORK_STATUS_BAR_FRAME_Y - networkStatusBarFrame.size.height;
			sharedSingleton.view.frame = networkStatusBarFrame;
		}
    }   
	NSLog(@"%@", sharedSingleton);
    return sharedSingleton;
}

+ (void)moveAndScaleView:(UIView *)aView duration:(NSTimeInterval)duration
				   curve:(int)curve 
			translationX:(CGFloat)translationX 
			translationY:(CGFloat)translationY
				  scaleX:(CGFloat)scaleX 
				  scaleY:(CGFloat)scaleY
				   alpha:(CGFloat)alpha
{
	// Setup the animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:curve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	// The transform matrix
	//CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
	
	if (alpha == 1) {
		aView.transform = CGAffineTransformIdentity;
	} else {
		CGAffineTransform transform = CGAffineTransformMakeScale(scaleX, scaleY);
		transform.tx = translationX;
		transform.ty = translationY;
		aView.transform = transform;
	}

	
	aView.alpha = alpha;
	
	/*aView.alpha = alpha;
	CGRect viewFrame = aView.frame;
	viewFrame.origin.y = y - height;
	viewFrame.size.height = height;
	aView.frame = viewFrame;
	
	for (UIView *subView in aView.subviews) {
		CGRect subViewFrame = subView.frame;
		subViewFrame.size.height = height;
		subView.frame = subViewFrame;
	}*/
	
	
	// Commit the changes
	[UIView commitAnimations];
	
}

+ (void)showStatusBar
{
	@synchronized(self) {
		[NetworkStatusBar moveAndScaleView:sharedSingleton.view 
								  duration:0.2 
									 curve:UIViewAnimationCurveLinear 
							  translationX:0 
							  translationY:0 
									scaleX:1 
									scaleY:1 
									 alpha:1];
	}
}

+ (void)hideStatusBar
{
	@synchronized(self) {
		[NetworkStatusBar moveAndScaleView:sharedSingleton.view 
								  duration:0.2 
									 curve:UIViewAnimationCurveLinear 
							  translationX:0 
							  translationY:NETWORK_STATUS_BAR_FRAME_HEIGHT/2 
									scaleX:1 
									scaleY:0.01 
									 alpha:0];
	}
}

+ (void)fadeLeft
{
	@synchronized(self) {
		UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
		[UIView animateWithDuration:0.3 delay:0.0 options:options animations:^{
			sharedSingleton.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -0, 44);
		} completion:nil];
	}
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
