//
//  NewsDetailDownloader.m
//  Blognone7
//
//  Created by Nattapon Nimakul on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailDownloader.h"


@implementation NewsDetailDownloader

@synthesize urlRequestString;	
@synthesize returnData;
@synthesize delegate;

@synthesize activeDownload;
@synthesize connection;

- (void)dealloc
{
    [returnData release];
	[activeDownload release];
	
	[connection cancel];
	[connection release];
    
    [super dealloc];
}

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
    // alloc+init and start an NSURLConnection; release on completion/failure
	
	// setup the request without caching
	NSURLRequest *urlRequest = [NSURLRequest 
								requestWithURL:[NSURL URLWithString:self.urlRequestString] 
								cachePolicy:NSURLRequestReloadIgnoringCacheData 
								timeoutInterval:30.0];
	
	// download thumbnail in different run-loop so we can receive data while the table is scrolling
    NSURLConnection *conn = [[NSURLConnection alloc] 
							 initWithRequest:urlRequest
							 delegate:self
							 startImmediately:NO];
	[conn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[conn start];
    self.connection = conn;
	
    [conn release];
}

- (void)cancelDownload
{
    [self.connection cancel];
    self.connection = nil;
    self.activeDownload = nil;
}

#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.connection = nil;
}

#define blognoneIconHeight 80

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    self.returnData = [NSData dataWithData:self.activeDownload];
    
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.connection = nil;
	
    // call our delegate and tell it that our icon is ready for display
	//NSLog(@"thumbnail ready");
    [delegate dataDidLoad];
	//NSLog(@"finished download %@", self.indexPathInTableView);
}


@end
