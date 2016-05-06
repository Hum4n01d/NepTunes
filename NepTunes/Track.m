//
//  Track.m
//  NepTunes
//
//  Created by rurza on 30/12/15.
//  Copyright © 2015 micropixels. All rights reserved.
//

#import "Track.h"
#import "iTunes.h"
#import "Spotify.h"
#import "MusicPlayer.h"

@implementation Track
@synthesize loved = _loved;

-(instancetype)initWithTrackName:(NSString *)tn artist:(NSString *)art album:(NSString *)alb andDuration:(double)d
{
    self = [super init];
    if (self) {
        self.trackName = tn;
        self.artist = art;
        self.album = alb;
        self.duration = d;
    }
    if (!tn || !art) {
        return nil;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.trackName forKey:@"trackName"];
    [encoder encodeObject:self.artist forKey:@"artist"];
    [encoder encodeObject:self.album forKey:@"album"];
    [encoder encodeObject:@(self.duration) forKey:@"duration"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.trackName = [decoder decodeObjectForKey:@"trackName"];
        self.artist = [decoder decodeObjectForKey:@"artist"];
        self.album = [decoder decodeObjectForKey:@"album"];
        self.duration = [[decoder decodeObjectForKey:@"duration"] doubleValue];
    }
    return self;
}

+(Track *)trackWithiTunesTrack:(iTunesTrack *)track
{
    TrackKind kind;
    if (track.podcast) {
        kind = TrackKindPodcast;
    } else if (track.iTunesU) {
        kind = TrackKindiTunesU;
    } else {
        kind = TrackKindMusic;
    }
    
    if ((!track.name || !track.artist || track.name.length == 0 || track.artist.length == 0) && kind == TrackKindMusic) {
        return nil;
    }
    Track *song = [[Track alloc] initWithTrackName:track.name artist:track.artist album:track.album andDuration:track.duration];
    song.trackOrigin = TrackFromiTunes;
    song.kind = track.kind;
    song.rating = track.rating;
    song.loved = track.loved;
    song.trackKind = kind;
    return song;
}

+(Track *)trackWithSpotifyTrack:(SpotifyTrack *)track
{
    if (!track.name || !track.artist || track.name.length == 0 || track.artist.length == 0) {
        return nil;
    }
    Track *song = [[Track alloc] initWithTrackName:track.name artist:track.artist album:track.album andDuration:(double)track.duration/1000];
    song.artworkURL = track.artworkUrl;
    song.trackOrigin = TrackFromSpotify;
    song.spotifyID = [[track id] stringByReplacingOccurrencesOfString:@"spotify:track:" withString:@""];
    return song;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ by %@ with duration of [%fs]", self.trackName, self.artist, self.duration];
}

#pragma mark Equality

-(BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Track class]]) {
        return NO;
    }
    
    return [self isEqualToTrack:(Track *)object];
}

-(BOOL)isEqualToTrack:(Track *)track
{
    if (self == track) {
        return YES;
    }
    BOOL itIsEqual = ([self.trackName isEqualToString:track.trackName] && [self.album isEqualToString:track.album] && [self.artist isEqualToString:track.artist]);
    return itIsEqual;
}

-(NSUInteger)hash
{
    return [self.trackName hash] ^ [self.album hash];
}

@end
