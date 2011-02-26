//
//  EntryNewsViewController.h
//  Blognone10
//
//  Created by Nattapon on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EntryNewsViewController : UIViewController {
	NSString *htmlContentData;
	NSArray *commentsArray;
	UIWebView *myWebView;
}

@property (nonatomic, retain) NSString *htmlContentData;
@property (retain) NSArray *commentsArray;
@property (nonatomic, retain) IBOutlet UIWebView *myWebView;

@end
