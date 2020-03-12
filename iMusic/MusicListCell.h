//
//  MusicListCell.h
//  iMusic
//
//  Created by RA on 07/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *albumImageView;
@property (nonatomic, weak) IBOutlet UILabel *albumNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;

@end

NS_ASSUME_NONNULL_END
