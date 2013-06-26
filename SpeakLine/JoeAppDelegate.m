//
//  JoeAppDelegate.m
//  SpeakLine
//
//  Created by 楚 乔 on 13-6-19.
//  Copyright (c) 2013年 楚 乔. All rights reserved.
//

#import "JoeAppDelegate.h"

@implementation JoeAppDelegate

@synthesize window = _window;
@synthesize textField = _textField;
@synthesize tableview = _tableview;

-(id)init {
    self = [super init];
    if (self) {
        NSLog(@"init");
        
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
        
        [_speechSynth setDelegate:self];
        _voice = [NSSpeechSynthesizer availableVoices];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    NSLog(@"finishedSpeecking = %d",finishedSpeaking);
    [_stopButton setEnabled:NO];
    [_speakButton setEnabled:YES];
    [_tableview setEnabled:YES];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView*)tv{
    return (NSInteger)[_voice count];
}

-(id)tableView:(NSTableView*) tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString *v = [_voice objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
    return [dict objectForKey:NSVoiceName];
}

-(void)tableViewSelectionDidChange:(NSNotification*)notification{
    NSInteger row = [_tableview selectedRow];
    if (row ==-1) {
        return;
    }
    NSString *selectedVoice = [_voice objectAtIndex:row];
    [_speechSynth setVoice:selectedVoice];
    NSLog(@"new voice=%@",selectedVoice);
}

- (IBAction)textField:(id)sender {
}

- (IBAction)stopIt:(id)sender {
    NSLog(@"stopping");
    [_speechSynth stopSpeaking];
}

- (IBAction)sayIt:(id)sender {
    NSString *str = [_textField stringValue];
    
    if ([str length] ==0) {
        NSLog(@"string from %@ is of zero-length",_textField);
        return;
    }
    [_speechSynth startSpeakingString:str];
    [_stopButton setEnabled:YES];
    [_speakButton setEnabled:NO];
    [_tableview setEnabled:NO];
    NSLog(@"Having started to say: %@",str);
}
@end
