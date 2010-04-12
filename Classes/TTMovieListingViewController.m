//
//  TTMovieListingViewController.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "TTMovieListingViewController.h"
#import "TTMovieListingDataSource.h"
#import "TTMovieListingSearchDataSource.h"

@implementation TTMovieListingViewController
@synthesize movieTitle = _movieTitle;

- (id)init {
    if (self = [super init]) {
        self.title = @"Movie Listings";
		self.movieTitle = nil;
	}
	
    return self;
}

- (id) initWithMovieTitle:(NSString*)movieTitle {
	if (self = [self init]) {
		self.movieTitle = movieTitle;
		self.title = movieTitle;
		self.tableViewStyle = UITableViewStyleGrouped;
	}
	
	return self;
}

- (void)createModel {
	self.dataSource = _movieTitle == nil ? [[[TTMovieListingDataSource alloc] init] autorelease] :
	[[[TTMovieListingSearchDataSource alloc] initWithMovieTitle:_movieTitle] autorelease];
}

- (void)dealloc {
    [super dealloc];
}


@end

