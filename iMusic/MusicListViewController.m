//
//  MusicListViewController.m
//  iMusic
//
//  Created by RA on 05/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import "MusicListViewController.h"
#import "Album.h"
#import "MusicListCell.h"
#import "AlbumDetailsViewController.h"

@interface MusicListViewController ()

@property (nonatomic, strong) NSMutableArray *albums;

@end

@implementation MusicListViewController

@synthesize albums = _albums;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iMusic List";
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.albums = [NSMutableArray arrayWithArray:[Album findAllAlbums]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"Count of albums item %lu", (unsigned long)self.albums.count);
    return self.albums.count;
}
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];

//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    // Configure the cell...
    
    Album *album = [self.albums objectAtIndex:indexPath.row];
//    cell.imageView.image = album.albumImage;
//    cell.textLabel.text = album.albumName;
    cell.albumImageView.image = album.albumImage;
    cell.albumNameLabel.text = album.albumName;
    cell.artistNameLabel.text = album.artist.artistName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Album *album = [self.albums objectAtIndex:indexPath.row];
//    NSString *message = [NSString stringWithFormat:@"Artist: %@\nAlbum: %@", album.artist.artistName, album.albumName];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Selection" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alertView show];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Album *album = [self.albums objectAtIndex:indexPath.row];
        [album deleteAlbum];
        [self.albums removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Album *album = [self.albums objectAtIndex:indexPath.row];
        AlbumDetailsViewController *controller = [segue destinationViewController];
        controller.album = album;
    }
}


@end
