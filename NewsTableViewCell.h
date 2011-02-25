//
//  NewsTableViewCell.h
//  Blognone9
//
//  Created by Nattapon Nimakul on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@interface NewsTableViewCell : UITableViewCell <IconDownloaderDelegate> {
	NSNumber * entryID;
	NSString * thumbnailURL; 
	
	IconDownloader *iconDownloader;
}

@property (nonatomic, retain) NSNumber * entryID;
@property (nonatomic, retain) NSString * thumbnailURL; 
@property (nonatomic, retain) IconDownloader *iconDownloader;


@end
