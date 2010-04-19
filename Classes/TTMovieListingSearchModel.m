//
//  TTMovieListingSearchModel.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTMovieListingSearchModel.h"
#import "JSON.h"

static NSString* kSearchFeed = @"http://api.nytimes.com/svc/movies/v2/reviews/search.json";

@implementation TTMovieListingSearchModel
@synthesize movieData = _movieData;
@synthesize movieTitle = _movieTitle;

- (id)initWithMovieTitle:(NSString*)movieTitle {
	if (self = [self init]) {
		self.movieTitle = movieTitle;
	}
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_movieData);
	TT_RELEASE_SAFELY(_movieTitle);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		NSString* url = [[NSString alloc] initWithFormat:@"%@?query=%@&api-key=5ae48abecf651fa6ea534753c869125a:11:60300054",
						 kSearchFeed,_movieTitle];
		
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
	self.movieData = [[[responseBody JSONValue] objectForKey:@"results"] objectAtIndex:0];
	
	NSLog(@"movie search => %@", _movieData);
	
	[super requestDidFinishLoad:request];
}

@end
