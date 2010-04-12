//
//  TTMovieListingModel.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "TTMovieListingModel.h"
#import "TTMovieListing.h"
#import "JSON.h"

static NSString* kNYTimesMovieFeed = @"http://api.nytimes.com/svc/movies/v2/reviews/dvd-picks.json";

@implementation TTMovieListingModel
@synthesize movieListings = _movieListings;

- (id) init {
	if (self = [super init]) { }
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_movieListings);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		NSString* url = [[NSString alloc] initWithFormat:@"%@?order=by-date&api-key=5ae48abecf651fa6ea534753c869125a:11:60300054",kNYTimesMovieFeed];

		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
		request.response = [[[TTURLDataResponse alloc] init] autorelease];
		[request send];
		
		TT_RELEASE_SAFELY(url);
	}
}

- (void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLDataResponse *response = request.response;
	
	NSString *responseBody = [[NSString alloc]
							  initWithData:response.data encoding:NSUTF8StringEncoding]; 
//	NSLog(@"response body => %@", responseBody);	
	_movieListings = [[responseBody JSONValue] objectForKey:@"results"];
	
	NSLog(@"movie listings => %@", _movieListings);
	
	[super requestDidFinishLoad:request];
}

@end
