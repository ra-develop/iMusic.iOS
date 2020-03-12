//
//  MusicListCell.m
//  iMusic
//
//  Created by RA on 07/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import "MusicListCell.h"
//#import "UIView+Geometry.h"
//
//#define RESIZE_ADJUSTMENT 57.0

@implementation MusicListCell


@synthesize albumImageView = _albumImageView;
@synthesize albumNameLabel = _albumNameLabel;
@synthesize artistNameLabel = _artistNameLabel;

//- (void)willTransitionToState:(UITableViewCellStateMask)state {
//    [super willTransitionToState:state];
//
//    if (state == UITableViewCellStateShowingDeleteConfirmationMask) {
//        self.albumNameLabel.frameWidth -= RESIZE_ADJUSTMENT;
//        self.artistNameLabel.frameWidth -= RESIZE_ADJUSTMENT;
//    }
//}
//
//-(void)didTransitionToState:(UITableViewCellStateMask)state {
//    if (state == UITableViewCellStateDefaultMask) {
//        [UIView animateWithDuration:1.5 animations:^{
//            self.albumNameLabel.frameWidth += RESIZE_ADJUSTMENT;
//            self.artistNameLabel.frameWidth += RESIZE_ADJUSTMENT;
//        } completion:^(BOOL finished) {
//            [super didTransitionToState:state];
//        }];
//    } else {
//        [super didTransitionToState:state];
//    }
//}

//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
