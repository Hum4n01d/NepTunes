//
//  CoverWindow.m
//  NepTunes
//
//  Created by rurza on 11/02/16.
//  Copyright © 2016 micropixels. All rights reserved.
//

#import "CoverWindow.h"
#import "CoverImageView.h"
#import "ControlView.h"

@interface CoverWindow ()
@end

@implementation CoverWindow

-(void)awakeFromNib
{
    [self setupWindow];
    [self setupControlView];
    [self makeFirstResponder:self.controlView];
}

-(void)setupWindow
{
    self.releasedWhenClosed = YES;
    [self setMovableByWindowBackground:YES];
    [self setMovable:YES];
    [self setOpaque: NO];
    [self setBackgroundColor:[NSColor clearColor]];
    [self setIgnoresMouseEvents:NO];
    [self setStyleMask:NSBorderlessWindowMask];
    [self setHasShadow:YES];
    self.restorable = YES;
}

-(void)setupControlView
{
    self.controlView.layer.cornerRadius = 6;
}



@end