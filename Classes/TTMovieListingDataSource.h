//
//  MovieListingDataSource.h
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

@class TTMovieListingModel;

@interface TTMovieListingDataSource : TTListDataSource {
	TTMovieListingModel *_movieListingModel;
}

@end
