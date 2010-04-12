//
//  TTMovieListingModel.h
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

@interface TTMovieListingModel : TTURLRequestModel {
	NSMutableArray *_movieListings;
}

@property (nonatomic, copy) NSMutableArray *movieListings;

@end
