//
//  Queue.h
//  Blognone3
//
//  Created by Nattapon Nimakul on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Queue : NSObject {
	NSMutableArray *objects;
}

@property (nonatomic, retain) NSMutableArray *objects;
@property (nonatomic, readonly) NSUInteger size;

- (id) dequeue;
- (void) enqueue:(id)obj;

@end
