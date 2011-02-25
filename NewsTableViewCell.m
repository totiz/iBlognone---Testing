//
//  NewsTableViewCell.m
//  Blognone9
//
//  Created by Nattapon Nimakul on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsTableViewCell.h"


@implementation NewsTableViewCell

@synthesize entryID;
@synthesize thumbnailURL;
@synthesize iconDownloader;

- (IconDownloader *)iconDownloader
{
	if (!iconDownloader) {
		iconDownloader = [IconDownloader new];
	}
	iconDownloader.delegate = self;
	return iconDownloader;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)setThumbnailURL:(NSString *)newThumbnailURL
{
	thumbnailURL = newThumbnailURL;
	
	if (iconDownloader.activeDownload != nil) {
		[self.iconDownloader cancelDownload];
	}
	self.iconDownloader.thumbnailURL = newThumbnailURL;
	if (newThumbnailURL) {
		[self.iconDownloader startDownload];
	}
}

- (void)appImageDidLoad:(UIImage *)returnImage
{
	//NSLog(@"download thumbnail finished 3");
	self.imageView.image = returnImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	iconDownloader.delegate = nil;
	[iconDownloader cancelDownload];
	[iconDownloader release];
    [super dealloc];
}


@end
