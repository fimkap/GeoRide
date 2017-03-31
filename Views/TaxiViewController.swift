//
//  TaxiViewController.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 24/03/2017.
//
//

import UIKit



class TaxiViewController: UIViewController {
    
    var interactor:MapInteractor = MapInteractor()

  @IBOutlet weak var street: UILabel!
  @IBOutlet weak var city: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    street.text = interactor.locationStreet()
    city.text = interactor.locationCity()
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func callTaxi(_ sender: Any) {
        interactor.callTaxi()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
