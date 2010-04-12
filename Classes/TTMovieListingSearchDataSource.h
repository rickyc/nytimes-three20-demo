//
//  TTMovieListingSearchDataSource.h
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TTMovieListingSearchModel;

@interface TTMovieListingSearchDataSource : TTSectionedDataSource {
	TTMovieListingSearchModel *_searchModel;
}

- (id)initWithMovieTitle:(NSString*)movieTitle;

@end
