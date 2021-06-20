import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel?
    @IBOutlet weak var userAvatar: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(star: MyStargazer,
               downloader: MyImageProtocol?) {
        self.userAvatar?.layer.masksToBounds = true
        self.userAvatar?.layer.cornerRadius = (self.userAvatar?.bounds.width)! / 2
        usernameLabel?.text = star.user
        downloader?.downloadImage(from: star.avatar) { [weak self] in
            self?.userAvatar?.image = $0
        }
    }
}
