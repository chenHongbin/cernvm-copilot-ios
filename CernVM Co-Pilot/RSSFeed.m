//
//  RSSFeed.m
//  CernVM Co-Pilot
//
//  Created by Eamon Ford on 5/28/12.
//  Copyright (c) 2012 The Byte Factory. All rights reserved.
//

#import "RSSFeed.h"
#import "RSSArticle.h"

@implementation RSSFeed

- (id)initWithFeedURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.parser = [[MWFeedParser alloc] initWithFeedURL:url];
        self.parser.feedParseType = ParseTypeFull;
        self.parser.connectionType = ConnectionTypeAsynchronously;
        self.parser.delegate = self;
        self.articles = [NSMutableArray array];
    }
    return self;
}

- (void)refresh
{
    self.articles = [NSMutableArray array];
    [self.parser parse];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)feedInfo
{
    self.info = feedInfo;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    [self.articles addObject:item];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(feed:didFailWithError:)])
        [self.delegate feed:self didFailWithError:error];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
//    if (self.aggregator && [self.aggregator respondsToSelector:@selector(feedDidLoad:)])
//        [self.aggregator feedDidLoad:self];
    if (self.delegate && [self.delegate respondsToSelector:@selector(feedDidLoad:)])
        [self.delegate feedDidLoad:self];
}

@end
