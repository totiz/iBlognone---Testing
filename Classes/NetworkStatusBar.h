//
//  NetworkStatusBar.h
//  Blognone8
//
//  Created by Nattapon Nimakul on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NetworkStatusBar : UIViewController {

}

+ (NetworkStatusBar *)sharedNetworkStatusBar;
+ (void)showStatusBar;
+ (void)hideStatusBar;

@end
