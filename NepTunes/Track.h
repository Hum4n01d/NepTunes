//
//  Song.h
//  NepTunes
//
//  Created by rurza on 30/12/15.
//  Copyright © 2015 micropixels. All rights reserved.
//

#import <Foundation/Foundation.h>
@class iTunesTrack;
@class SpotifyTrack;

@interface Track : NSObject <NSCoding>

@property (nonatomic) NSString *trackName;
@property (nonatomic) NSString *artist;
@property (nonatomic) NSString *album;
@property (nonatomic) double duration;//in seconds
@property (nonatomic) BOOL itIsNotMusic;
-(instancetype)initWithTrackName:(NSString *)tn artist:(NSString *)art album:(NSString *)alb andDuration:(double)d;
+(Track *)trackWithiTunesTrack:(iTunesTrack *)track;
+(Track *)trackWithSpotifyTrack:(SpotifyTrack *)track;
-(BOOL)isEqualToTrack:(Track *)track;

@end
