//
//  RecentTracksController.h
//  NepTunes
//
//  Created by rurza on 22/01/16.
//  Copyright © 2016 micropixels. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Song;

@interface RecentTracksController : NSObject
@property (nonatomic, readonly) NSMutableArray *songs;

+(RecentTracksController *)sharedInstance;
-(BOOL)addSongToRecentMenu:(Song *)song;
@end
