//
//  DetailViewController.m
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "JSON.h"

@implementation DetailViewController

@synthesize webView;
@synthesize spinner;
@synthesize entryID;
@synthesize news;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	detailDownLoader = [NewsDetailDownloader new];
	detailDownLoader.urlRequestString = [NSString stringWithFormat:@"http://totizblognone.appspot.com/get_entry?entry_id=%@", entryID];
	detailDownLoader.delegate = self;
	
	[spinner startAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[detailDownLoader startDownload];
}

- (void)dataDidLoad
{
	NSString *detailJsonString = [[NSString alloc] initWithData:detailDownLoader.returnData encoding:NSUTF8StringEncoding];
	NSDictionary *detail = [detailJsonString JSONValue];
	
	NSString *htmlContent = [NSString 
							 stringWithFormat:@"<img width='300' height='200' src='%@' />%@", 
							 news.thumbnailURL,
							 [detail objectForKey:@"description"]];
	[webView loadHTMLString:htmlContent baseURL:nil];
	[spinner stopAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[detailDownLoader cancelDownload];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;	
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
	self.entryID = nil;
	self.webView = nil;
	self.spinner = nil;
}


- (void)dealloc {
	[detailDownLoader release];
	[entryID release];
	[webView release];
	[spinner release];
    [super dealloc];
}


@end
