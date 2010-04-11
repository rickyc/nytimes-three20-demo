//
//  MovieListingViewController.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 Family. All rights reserved.
//

#import "MovieListingViewController.h"
#import "MovieListingDataSource.h"

@implementation MovieListingViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"Movie Listings";
	}
	
    return self;
}

- (void)createModel {
	self.dataSource = [[[MovieListingDataSource alloc] init] autorelease];
}

- (void)dealloc {
    [super dealloc];
}


@end

