//
//  NewsTableViewController.m
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "DetailViewController.h"
#import "NetworkStatusBar.h"

@implementation NewsTableViewController

- (void)pressedRefreshButton
{
	[NetworkStatusBar showStatusBar];
}

- (void)infoViewAction:(id)sender
{
	[NetworkStatusBar hideStatusBar];
}

- (void)setupToolBar
{
	// Create Refresh Bar Button
	UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] 
										 initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
										 target:self 
										 action:@selector(pressedRefreshButton)];
	
	// Create Segment Control Bar Button
	UISegmentedControl *segment = [[UISegmentedControl alloc] 
								   initWithItems:[NSArray 
												  arrayWithObjects:@"News", 
												  @"Favorite", 
												  nil]];
	CGRect segmentFrame = segment.frame;
	segmentFrame.size.width = 231;
	segmentFrame.size.height = 30;
	segment.frame = segmentFrame;
	segment.segmentedControlStyle = UISegmentedControlStyleBar;
	UIBarButtonItem *sengmentBarButton = [[UIBarButtonItem alloc] 
										  initWithCustomView:segment];
	
	// Create Info Bar Button	
	UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(infoViewAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	
	
	[self setToolbarItems:[NSArray arrayWithObjects:refreshBarButton, 
						   sengmentBarButton, 
						   infoBarButton, 
						   nil] 
				 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// Set Menu Bar Style
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
	
	[self.navigationController setToolbarHidden:NO animated:YES];
	//[NetworkStatusBarController statusBarFadeIn];
}


- initInManagedObjectContext:(NSManagedObjectContext *)context
{	
	if (self = [super initWithStyle:UITableViewStylePlain])
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:context];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"entryID" ascending:NO]];
		request.predicate = nil;
		request.fetchBatchSize = 20;
		request.fetchLimit = 100;
		
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
										   initWithFetchRequest:request 
										   managedObjectContext:context 
										   sectionNameKeyPath:nil 
										   cacheName:nil];
		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"title";
		self.subtitleKey = @"short_description";
		self.searchKey = @"title";
	}
	self.navigationItem.rightBarButtonItem = self.editButtonItem;

	[self setupToolBar];
	return self;
}


- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
	News *news = (News *)managedObject;
	
	NSLog(@"thumbanil: %@", news.thumbnailURL);
	
	DetailViewController *detailViewController = [DetailViewController new];
	detailViewController.news = news;
	detailViewController.entryID = news.entryID;
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
	
	// Hide Tool Bar
	[self.navigationController setToolbarHidden:YES animated:YES];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	//[NetworkStatusBarController statusBarFadeOut];
	
	[NetworkStatusBar fadeLeft]; 
	
}

- (BOOL)canDeleteManagedObject:(NSManagedObject *)managedObject
{
	return YES;
}

- (void)deleteManagedObject:(NSManagedObject *)managedObject
{
	NSManagedObjectContext *context = managedObject.managedObjectContext;
	
	News *news = (News *)managedObject;
	[context deleteObject:news];
	NSLog(@"Delete news: %@", news);
	[self saveContext:context];
}

- (void)saveContext:(NSManagedObjectContext *)context {
    
    NSError *error = nil;
    if (context != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
} 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

@end
