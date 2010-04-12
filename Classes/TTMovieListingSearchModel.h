//
//  TTMovieListingSearchModel.h
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface TTMovieListingSearchModel : TTURLRequestModel {
	NSDictionary *_movieData;
	NSString *_movieTitle;
}

@property (nonatomic, copy) NSDictionary *movieData;
@property (nonatomic, copy) NSString* movieTitle;

- (id)initWithMovieTitle:(NSString*)movieTitle;

@end
