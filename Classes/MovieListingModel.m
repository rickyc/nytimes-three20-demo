//
//  MovieListingModel.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "MovieListingModel.h"
#import "JSON.h"

@implementation MovieListingModel
@synthesize movieListings = _movieListings;

- (id) init {
	if (self = [super init]) {
		
	}
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_movieListings);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		NSString* url = @"http://api.nytimes.com/svc/movies/v2/reviews/dvd-picks.json?order=by-date&api-key=5ae48abecf651fa6ea534753c869125a:11:60300054";

		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
		request.response = [[[TTURLDataResponse alloc] init] autorelease];
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLDataResponse *response = request.response;
	NSLog(@"test => %@", response);
}

/*
- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data {
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Parse the JSON data that we retrieved from the server.
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // Drill down into the JSON object to get the parts
    // that we're actually interested in.
    NSDictionary *root = [json objectForKey:@"photos"];
    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];
	
    // Now wrap the results from the server into a domain-specific object.
    NSArray *results = [root objectForKey:@"photo"];
    for (NSDictionary *rawResult in results) {
        
        SearchResult *result = [[[SearchResult alloc] init] autorelease];
        result.bigImageURL = [rawResult objectForKey:@"url_m"];
        result.thumbnailURL = [rawResult objectForKey:@"url_t"];
        result.title = [rawResult objectForKey:@"title"];
        result.bigImageSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
                                         [[rawResult objectForKey:@"height_m"] floatValue]);
		
        [self.objects addObject:result];
    }
    
    return nil;
} */

- (NSString *)format { return @"json"; }


/*
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	TTDASSERT([[feed objectForKey:@"entry"] isKindOfClass:[NSArray class]]);
	
	NSArray* entries = [feed objectForKey:@"entry"];
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	
	TT_RELEASE_SAFELY(_tweets);
	NSMutableArray* tweets = [[NSMutableArray alloc] initWithCapacity:[entries count]];
	
	for (NSDictionary* entry in entries) {
		TTTwitterTweet* tweet = [[TTTwitterTweet alloc] init];
		
		NSDate* date = [dateFormatter dateFromString:[[entry objectForKey:@"published"]
													  objectForXMLNode]];
		tweet.created = date;
		tweet.tweetId = [NSNumber numberWithLongLong:
						 [[[entry objectForKey:@"id"] objectForXMLNode] longLongValue]];
		tweet.text = [[entry objectForKey:@"title"] objectForXMLNode];
		tweet.source = [[entry objectForKey:@"twitter:source"] objectForXMLNode];
		
		[tweets addObject:tweet];
		TT_RELEASE_SAFELY(tweet);
	}
	_tweets = tweets;
	
	TT_RELEASE_SAFELY(dateFormatter);
	
	[super requestDidFinishLoad:request];
}*/

@end
