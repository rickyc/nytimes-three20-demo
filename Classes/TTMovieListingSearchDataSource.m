//
//  TTMovieListingSearchDataSource.m
//  nytimes-three20-demo
//
//  Created by Ricky Cheng on 4/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTMovieListingSearchDataSource.h"
#import "TTMovieListingSearchModel.h"

@implementation TTMovieListingSearchDataSource

- (id)initWithMovieTitle:(NSString*)movieTitle {
	if (self = [self init]) {
		_searchModel = [[TTMovieListingSearchModel alloc] initWithMovieTitle:movieTitle];
	}
	
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_searchModel);
	[super dealloc];
}

- (id<TTModel>)model {
	return _searchModel;
}


/// ----------------------

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* sections = [[NSMutableArray alloc] init];
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	{
		// This section has no title.
		[sections addObject:@""];
		
		NSMutableArray* itemRows = [[NSMutableArray alloc] init];
		
		NSString* headline = [_searchModel.movieData objectForKey:@"headline"];
		NSString* byline = [_searchModel.movieData objectForKey:@"byline"];
		NSString* title = [_searchModel.movieData objectForKey:@"display_title"];
//		NSString* blog = [_usermodel.properties objectForKey:@"blog"];
//		NSString* location = [_usermodel.properties objectForKey:@"location"];
		NSDate* dateUpdated = [_searchModel.movieData objectForKey:@"date_updated"];
		
		if( TTIsStringWithAnyText(title) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:title
														 caption:@"Display Title"]];
		}

		if( TTIsStringWithAnyText(byline) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:byline
														 caption:@"Byline"]];
		}
		
		/*
		if( TTIsStringWithAnyText(email) ) {
			NSData* emailData = [email dataUsingEncoding:NSUTF8StringEncoding];
			
			NSString* imageUrl = [@"http://www.gravatar.com/avatar/"
								  stringByAppendingString:[emailData md5Hash]];
			
			TTStyle* style =
			[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
			 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1]
										  width:1 next:
			  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
			   [TTContentStyle styleWithNext:
				[TTImageStyle styleWithImageURL:nil
								   defaultImage:nil
									contentMode:UIViewContentModeScaleAspectFill
										   size:CGSizeMake(50, 50) next:nil]]]]];
			
			[itemRows addObject:[TTTableImageItem
								 itemWithText: name
								 imageURL: imageUrl
								 defaultImage: TTIMAGE(@"bundle://gravatar-48.png")
								 imageStyle: style
								 URL: nil]];
		}
		
		if( TTIsStringWithAnyText(email) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:email
														 caption:@"Email"]];
		}
		
		if( TTIsStringWithAnyText(blog) ) {
			[itemRows addObject:[TTTableCaptionItem
								 itemWithText: [[blog
												 stringByReplacingOccurrencesOfString:@"http://"
												 withString:@""]
												stringByTrimmingCharactersInSet:[NSCharacterSet
																				 characterSetWithCharactersInString:@"/"]]
								 caption: @"Website/Blog"
								 URL: blog]];
		}
		
		if( TTIsStringWithAnyText(company) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:company
														 caption:@"Company"]];
		}
		
		if( TTIsStringWithAnyText(location) ) {
			[itemRows addObject:[TTTableCaptionItem itemWithText:location
														 caption:@"Location"]];
		}*/
		
		if( nil != dateUpdated ) {
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"LLLL d, YYYY";
			[itemRows addObject:[TTTableCaptionItem
								 itemWithText: [formatter stringFromDate:dateUpdated]
								 caption: @"Date Updated"]];
			TT_RELEASE_SAFELY(formatter);
		}
		
		[items addObject:itemRows];
		TT_RELEASE_SAFELY(itemRows);
	}
	
	self.sections = sections;
	self.items = items;
	
	TT_RELEASE_SAFELY(sections);
	TT_RELEASE_SAFELY(items);
}

@end
