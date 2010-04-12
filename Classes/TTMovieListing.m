//
//  MovieListing.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "TTMovieListing.h"


@implementation TTMovieListing
@synthesize title = _title;


- (void) dealloc {
	TT_RELEASE_SAFELY(_title);
	[super dealloc];
}

@end
