//
//  ViewController.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    let genderOptions = ["--","Masculino" , "Femenino", "Otro"]
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var firstLastnameTextfield: UITextField!
    @IBOutlet weak var secondLastnameTextfield: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lblGender: UILabel!
    private var selectedGender : String = "--"
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        nameTextfield.delegate = self
        firstLastnameTextfield.delegate = self
        secondLastnameTextfield.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        disableNextButton()
    }
    
    private func disableNextButton(){
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
    }
    private func enableNextButton(){
        nextButton.isEnabled = true
        nextButton.alpha = 1
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Actions
    @IBAction func saveInfo(_ sender: Any) {
        
        guard let userInfo = checkUserInfo() else { return }
        
        HelperApp.shared.save(name: userInfo.name)
        HelperApp.shared.save(firstLastname: userInfo.firstLastname)
        HelperApp.shared.save(secondLastname: userInfo.secondLastname)
        HelperApp.shared.save(gender: userInfo.gender)
        
        //navigate to second viewcontroller
        
    }
    
    
    ///Valida que los formularios esten completos y retorna el objeto `UserInfo` de lo contrario retorna `nil`
    private func checkUserInfo() -> UserInfo? {
        guard let name = nameTextfield.text, name != "",
              let firstLastname = firstLastnameTextfield.text, firstLastname != "",
              let secondLastName = secondLastnameTextfield.text, secondLastName != "",
              selectedGender != "--"
        else {
            debugPrint("some empty data")
            return nil
        }
        
        let userInfo : UserInfo = .init(name: name, firstLastname: firstLastname, secondLastname: secondLastName, gender: selectedGender)
        
        return userInfo
    }
    
    ///Valida si el boton debe estar activado o desactivado, dependiendo de si todo el formulario está completo o no.
    private func validateNextButton() {
        if checkUserInfo() != nil {
            enableNextButton()
        }else {
            disableNextButton()
        }
    }
}

//MARK: Gender Picker
extension PersonalInfoViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedGender = genderOptions[row]
        lblGender.text = "Sexo: \(selectedGender)"
        self.selectedGender = selectedGender
        validateNextButton()
    }
}

//MARK: Textfields
extension PersonalInfoViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateNextButton()
        
        if textField.text == "" {
            disableNextButton()
        }
    }
}
