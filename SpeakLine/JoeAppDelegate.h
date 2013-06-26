//
//  JoeAppDelegate.h
//  SpeakLine
//
//  Created by 楚 乔 on 13-6-19.
//  Copyright (c) 2013年 楚 乔. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JoeAppDelegate : NSObject <NSApplicationDelegate,NSSpeechSynthesizerDelegate>{
    NSSpeechSynthesizer *_speechSynth;
    NSArray* _voice;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSButton *speakButton;
@property (weak) IBOutlet NSTableView *tableview;


- (IBAction)stopIt:(id)sender;
- (IBAction)sayIt:(id)sender;

@end
