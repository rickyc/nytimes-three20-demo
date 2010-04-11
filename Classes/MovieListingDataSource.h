//
//  MovieListingDataSource.h
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

@class MovieListingModel;

@interface MovieListingDataSource : TTListDataSource {
	MovieListingModel *_movieListingModel;
}

@end
