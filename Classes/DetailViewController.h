//
//  DetailViewController.h
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsDetailDownloader.h"
#import "EntryNewsViewController.h"



@interface DetailViewController : UIViewController <NewsDetailDownloaderDelegate> {
	NewsDetailDownloader *detailDownLoader;
	
	UIWebView *webView;
	UIActivityIndicatorView *spinner;
	NSNumber *entryID;
	News *news;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) NSNumber *entryID;
@property (nonatomic, retain) News *news;

@end
