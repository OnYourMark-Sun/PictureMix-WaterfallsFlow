//
//  TableViewCell.m
//  UITableView-WaterFall


#import "TableViewCell.h"

@implementation TableViewCell
{
    UIImageView *imageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    // 设置imageView显示的图片
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    
    // 给imageView设置大小
    // 宽度是屏幕的 1/3
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3;

    // 根据比例算出高度
    float height = image.size.height * width / image.size.width;
    
    imageView.frame = CGRectMake(0, 0, width, height);
}








@end
