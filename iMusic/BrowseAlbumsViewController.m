//
//  BrowseAlbumsViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "BrowseAlbumsViewController.h"
#import "AlbumDetailsViewController.h"
#import "Album.h"
#import "MusicStoreService.h"

@interface BrowseAlbumsViewController ()
@property (nonatomic, strong) NSMutableArray *albums;
@end

@implementation BrowseAlbumsViewController

@synthesize artist = _artist;
@synthesize albums = _albums;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Albums";
	[self.navigationController setNavigationBarHidden:NO animated:YES];

//	// Sample Data
//	Album *album = [[Album alloc] init];
//	album.albumID = 446292213;
//	album.albumName = @"In Waves";
//	album.imageURLString = @"http://a4.mzstatic.com/us/r1000/067/Music/93/27/a2/mzi.sottimsz.100x100-75.jpg";
//	album.albumImage = [UIImage imageNamed:@"trivium.jpg"];
//	album.price = @"9.99";
//	album.iTunesURLString = @"http://itunes.apple.com/us/album/in-waves/id446292213?uo=4";
//	album.genre = @"Rock";
//	album.releaseDate = [NSDate date];
//	album.artist = self.artist;
    
    MusicStoreService *service = [[MusicStoreService alloc] init];
    
    [service loadAlbumsForArtist:self.artist completionBlock:^(id result, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Loading" message:@"Unable to load albums. Plase try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        // Set Artist and refresh result list
        self.albums = result;
        [self.tableView reloadData];
    }];
    
//	self.albums = [NSMutableArray arrayWithObject:album];
}

- (IBAction)closeDialog:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
	cell.textLabel.text = [[self.albums objectAtIndex:indexPath.row] albumName];
	return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showDetails"]) {
        AlbumDetailsViewController *controller = [segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		controller.album = [self.albums objectAtIndex:indexPath.row];
		controller.saveToListEnabled = YES;
	}
}

@end
