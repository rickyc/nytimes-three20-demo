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
		[sections addObject:@""];
		
		NSMutableArray* itemRows = [[NSMutableArray alloc] init];
		
		NSString* byline = [_searchModel.movieData objectForKey:@"byline"];
		NSString* title = [_searchModel.movieData objectForKey:@"display_title"];
		
		NSDictionary *imageResource = [[_searchModel.movieData objectForKey:@"multimedia"] objectForKey:@"resource"];
		NSString *imageURL = [imageResource objectForKey:@"src"];

		if( TTIsStringWithAnyText(imageURL) ) {
			TTStyle* style =
			[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
			 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1] width:1 next:
			  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
			   [TTContentStyle styleWithNext:
				[TTImageStyle styleWithImageURL:nil defaultImage:nil
						contentMode:UIViewContentModeScaleAspectFill
							size:CGSizeMake(75, 75) next:nil]]]]];
			
			[itemRows addObject:[TTTableImageItem
								 itemWithText: title
								 imageURL: imageURL
								 defaultImage: TTIMAGE(@"bundle://placeholder.png")
								 imageStyle: style
								 URL: nil]];
		}

		if (TTIsStringWithAnyText(title))
			[itemRows addObject:[TTTableCaptionItem itemWithText:title caption:@"Display Title"]];
		
		if (TTIsStringWithAnyText(byline))
			[itemRows addObject:[TTTableCaptionItem itemWithText:byline caption:@"Byline"]];
		
		[items addObject:itemRows];
		TT_RELEASE_SAFELY(itemRows);
	}
	
	{
		[sections addObject:@"Details"];
	
		NSString* dateUpdated = [_searchModel.movieData objectForKey:@"date_updated"];
		NSString* headline = [_searchModel.movieData objectForKey:@"headline"];
		NSString* summary = [_searchModel.movieData objectForKey:@"summary_short"];
		
		NSDictionary *linkData = [_searchModel.movieData objectForKey:@"link"];
		NSString *urlText = [linkData objectForKey:@"suggested_link_text"];
		NSString *url = [linkData objectForKey:@"url"];
		
		NSMutableArray* itemRows = [[NSMutableArray alloc] init];
	
		if (TTIsStringWithAnyText(headline))
			[itemRows addObject:[TTTableSubtextItem itemWithText:@"Headline" caption:headline]];
		
		if (TTIsStringWithAnyText(summary))
			[itemRows addObject:[TTTableLongTextItem itemWithText:summary]];
		
		if (nil != dateUpdated) {
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
			NSDate *date = [formatter dateFromString:dateUpdated];			
			formatter.dateFormat = @"EEEE MMMM d, YYYY";
			
			[itemRows addObject:[TTTableCaptionItem itemWithText: [formatter stringFromDate:date] caption: @"Date Updated"]];
			TT_RELEASE_SAFELY(formatter);
		}
		
		if (TTIsStringWithAnyText(urlText))
			[itemRows addObject:[TTTableLink itemWithText:urlText URL:url]];
		
		[items addObject:itemRows];
		TT_RELEASE_SAFELY(itemRows);
	}
	
	self.sections = sections;
	self.items = items;
	
	TT_RELEASE_SAFELY(sections);
	TT_RELEASE_SAFELY(items);
}

@end
