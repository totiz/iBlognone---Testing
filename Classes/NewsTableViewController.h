//
//  NewsTableViewController.h
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"


@interface NewsTableViewController : CoreDataTableViewController {
}

- initInManagedObjectContext:(NSManagedObjectContext *)context;
- (void)saveContext:(NSManagedObjectContext *)context;

@end
