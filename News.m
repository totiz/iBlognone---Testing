// 
//  News.m
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "News.h"


@implementation News 

+ (News *)newsWithBlognoneEntry:(NSDictionary *)blognoneEntry inManagedObjectContext:(NSManagedObjectContext *)context
{
	News *news = nil;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:context];
	request.predicate = [NSPredicate predicateWithFormat:@"entryID = %@", [blognoneEntry objectForKey:@"entry_id"]];
	
	NSError *error = nil;
	news = [[context executeFetchRequest:request error:&error] lastObject];
	[request release];
	
	if (!error && !news) {
		news = [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:context];
		news.author = [blognoneEntry objectForKey:@"author"];
		news.entryID = [blognoneEntry objectForKey:@"entry_id"];
		news.short_description = [blognoneEntry objectForKey:@"short_description"];
		news.title = [blognoneEntry objectForKey:@"title"];
		news.url = [blognoneEntry objectForKey:@"url"];
		if ([blognoneEntry objectForKey:@"thumbnailURL"] != [NSNull null]) {
			news.thumbnailURL = [blognoneEntry objectForKey:@"thumbnailURL"];
		}
		NSLog(@"create new one");
	}
	
	return news;
}

+ (NSNumber *)getLastestFetchedIDInManagedObjectContext:(NSManagedObjectContext *)context
{
	News *news = nil;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:context];
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"entryID" ascending:NO]];
	request.predicate = nil;
	request.fetchLimit = 1;
							  
	NSError *error = nil;
	news = [[context executeFetchRequest:request error:&error] lastObject];
	[request release];
	
	if (news) {
		return news.entryID;
	} else {
		return [NSNumber numberWithInt:-1];
	}	
}

/*- (NSString *)thumbnailURL
{
	//NSString *thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/news-thumbnails/angrybirds_big_2.jpg";
	NSString *thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/finder.png";
	switch ([self.entryID intValue]) {
		case 378001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/finder.png";
			break;
		case 377001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/microsoft.png";
			break;
		case 376001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/yahoobang-small.gif";
			break;
		case 375001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/yahoobang-small.gif";
			break;
		case 374001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/htc_logo.gif";
			break;
		case 373001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/android-robot-logo2.jpg";
			break;
		case 372001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/microsoft.png";
			break;
		case 371001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/bb.jpg";
			break;
		case 370001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/java.png";
			break;
		case 369001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/amd_logo-02.jpg";
			break;
			
		case 368001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/oracle.png";
			break;
		case 367001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/android-robot-logo2.jpg";
			break;
		case 366001:
			thumnailURL = @"http://www.blognone.com/sites/default/files/imagecache/news-thumbnail/category_pictures/yahoobang-small.gif";
			break;
		default:
			break;
	}
	return thumnailURL;
}*/

@dynamic author;
@dynamic title;
@dynamic short_description;
@dynamic url;
@dynamic entryID;
@dynamic thumbnailURL;

@end
