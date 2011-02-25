//
//  Queue.m
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"


@implementation Queue

@synthesize objects;

- (NSMutableArray *)objects
{
	if (!objects) {
		objects = [NSMutableArray new];
	}
	return objects;
}

- (NSUInteger) size
{
	return [self.objects count];
}

// Queues are first-in-first-out, so we remove objects from the head
- (id) dequeue {
    // if ([self count] == 0) return nil; // to avoid raising exception (Quinn)
    id headObject = [self.objects objectAtIndex:0];
    if (headObject != nil) {
        [[headObject retain] autorelease]; // so it isn't dealloc'ed on remove
        [self.objects removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
    [self.objects addObject:anObject];
    //this method automatically adds to the end of the array
}



@end
