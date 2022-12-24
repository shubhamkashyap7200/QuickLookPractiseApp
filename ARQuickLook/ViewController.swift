
import UIKit
import QuickLook

class ViewController: UIViewController {
  // MARK: - Properties
  
  let modelNames = ["Teapot", "Gramophone", "Pig"]
  var modelImages = [UIImage]()
  var modelIndex = 0;
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Lifeecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    configureUI()
  }
  
  // MARK: - Helper Functions
  func configureUI() {
    // Store Images
    for modelName in modelNames {
      if let modelImage = UIImage(named: "\(modelName).jpg") {
        modelImages.append(modelImage)
      }
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
    
  }
  
}
// MARK: - Tableview delegates and datasource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryReusableCell")! as! GalleryTableViewCell
    
    cell.modelImage.image = modelImages[indexPath.row]
    cell.modelName.text = modelNames[indexPath.row]
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    modelIndex = indexPath.row
    
    let controller = QLPreviewController()
    controller.dataSource = self
    controller.delegate = self
    present(controller, animated: true)
  }
}

// MARK: - QLPreviewControllerDataSource

extension ViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }
  
  func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    let url = Bundle.main.url(forResource: modelNames[modelIndex], withExtension: "usdz")!
    
    return url as QLPreviewItem
  }
}
