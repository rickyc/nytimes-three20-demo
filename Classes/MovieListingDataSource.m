//
//  MovieListingDataSource.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "MovieListingDataSource.h"
#import "MovieListingModel.h"
#import "JSON.h"

@implementation MovieListingDataSource

- (id)init {
	if (self = [super init]) {
		_movieListingModel = [[MovieListingModel alloc] init];
	}  
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_movieListingModel);	
	[super dealloc];
}

- (id<TTModel>)model {
	return _movieListingModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (NSDictionary* movieListing in _movieListingModel.movieListings) {
		NSString *thumbnail = [[[movieListing objectForKey:@"multimedia"] objectForKey:@"resource"] objectForKey:@"src"];
		NSString *url = [[movieListing objectForKey:@"link"] objectForKey:@"url"];
		TTTableSubtitleItem *item = [TTTableSubtitleItem itemWithText:[movieListing objectForKey:@"display_title"] 
										subtitle:[movieListing objectForKey:@"byline"] imageURL:thumbnail 
											defaultImage:[UIImage imageNamed:@"placeholder.png"] URL:url accessoryURL:url];
		[items addObject:item];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
