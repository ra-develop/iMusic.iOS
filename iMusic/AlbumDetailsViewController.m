//
//  AlbumDetailsViewController.m
//  iMusic
//
//  Created by RA on 07/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import "AlbumDetailsViewController.h"#im
#import "MusicStoreService.h"

@interface AlbumDetailsViewController ()

@end

@implementation AlbumDetailsViewController

@synthesize albumImageView = _albumImageView;
@synthesize albumNameLabel = _albumNameLabel;
@synthesize artistNameLabel = _artistNameLabel;
@synthesize genereLabel = _genereLabel;
@synthesize priceLabel = _priceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize saveToListButton = _saveToListButton;
@synthesize openInITunesButton = _openInITunesButton;

@synthesize album = _album;
@synthesize saveToListEnabled = _saveToListEnabled;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.album.albumImage) {
        MusicStoreService *service = [[MusicStoreService alloc] init];
        [service fetchArtworkForAlbum:self.album completionBlock:^(id result, NSError *error) {
            self.album.albumImage = result;
            self.albumImageView.image = result;
        }];
    } else {
        self.albumImageView.image = self.album.albumImage;
    }
    
    self.albumNameLabel.text = self.album.albumName;
    self.artistNameLabel.text = self.album.artist.artistName;
    self.genereLabel.text = self.album.genre;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.album.price];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [formater stringFromDate:self.album.releaseDate];
    self.saveToListButton.enabled = self.saveToListEnabled;
}

- (IBAction)saveToList:(id)sender {
    [self.album saveAlbum];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)openInITunes:(id)sender{
    NSURL *url = [NSURL URLWithString:self.album.iTunesURLString];
    [[UIApplication sharedApplication] openURL:url];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
