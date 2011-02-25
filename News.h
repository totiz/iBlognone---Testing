//
//  News.h
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface News :  NSManagedObject  
{
}

+ (News *)newsWithBlognoneEntry:(NSDictionary *)blognoneEntry inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSNumber *)getLastestFetchedIDInManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * short_description;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * entryID;
@property (nonatomic, retain) NSString * thumbnailURL;

@end



