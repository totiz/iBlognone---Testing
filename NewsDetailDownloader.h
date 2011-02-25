//
//  NewsDetailDownloader.h
//  Blognone7
//
//  Created by Nattapon Nimakul on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDetailDownloader;

@protocol NewsDetailDownloaderDelegate

- (void)dataDidLoad;

@end

@interface NewsDetailDownloader : NSObject {
	
	NSString *urlRequestString;
	NSData * returnData;
	id <NewsDetailDownloaderDelegate> delegate;
	
	NSMutableData * activeDownload;
    NSURLConnection * connection;
}

- (void)startDownload;
- (void)cancelDownload;

@property (nonatomic, retain) NSString *urlRequestString;
@property (nonatomic, retain) NSData * returnData;
@property (nonatomic, retain) id <NewsDetailDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData * activeDownload;
@property (nonatomic, retain) NSURLConnection * connection;

@end
