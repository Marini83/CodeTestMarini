//
//  AddContactViewController.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation 
import UIKit
import RealmSwift

class AddContactViewController: UIViewController, UIScrollViewDelegate  {
//    var scrollView: UIScrollView!
    var containerView = UIView()
    var phoneTextFieldsArray = [UITextField]();
    var emailTextFieldsArray = [UITextField]();
    var addressTextFieldsArray = [UITextField]();
    let MAXADDRESS = 3
    let MAXPHONE = 3
    let MAXEMAIL = 3
    var phoneCount = 1
    var emailCount = 1
    var addressCount = 0
    var originalTopConstraintForSaveButton = 450
    var addPaddingToConstraint = 60
    let addPaddingToSaveButtonConstraint = 58
    var addAddressPaddingToConstraint = 60
    var firstThreeTextFields = false
    //first name
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type name here"
        tf.keyboardType = .default
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .groupTableViewBackground
        return tf
    }()
    //last name
    let lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type last name here"
        tf.keyboardType = .default
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .groupTableViewBackground
        return tf
    }()
    //date of birth
    let DOBTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type date of birth here"
        tf.keyboardType = .phonePad
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .groupTableViewBackground
        return tf
    }()
    
    
    
    //last phone number
    let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type phone number here"
        tf.keyboardType = .phonePad
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .groupTableViewBackground
        return tf
    }()
    
    //last email
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type email here"
        tf.keyboardType = .default
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .groupTableViewBackground
        return tf
    }()
   
    /* Buttons */
    let addPhoneNumberButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+ Add phone number", for: .normal)
        btn.addTarget(self, action: #selector(addPhoneNumber), for: .touchUpInside)
        return btn
    }()
    
    let addEmailButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+ Add email", for: .normal)
        btn.addTarget(self, action: #selector(addEmail), for: .touchUpInside)
        return btn
    }()
    
    let addAddressButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+ Add Address", for: .normal)
        btn.addTarget(self, action: #selector(addAddress), for: .touchUpInside)
        return btn
    }()
    
    
    let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save contact", for: .normal)
        btn.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        return btn
    }()
    
    let realm = try! Realm()
    lazy var results = realm.objects(ContactBook.self)
    
    
    lazy var scrollView: UIScrollView = {
        let instance = UIScrollView()
        instance.backgroundColor = UIColor.black
        return instance
    }()
    
    var needLayoutContent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = scrollView
        
        
//        self.scrollView = UIScrollView()
//        self.scrollView.delegate = self
       // scrollView.addSubview(containerView)
        
        
        
      //  view.addSubview(scrollView)
       // self.scrollView.contentSize = CGSize(1000, 1000)
        /// Setup title for UINavigationController
        title = "Add Contact"
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        phoneTextFieldsArray.append(phoneNumberTextField)
        emailTextFieldsArray.append(emailTextField)
        /// Setup views for AddContactVC
        setupView()
        
        /// Setup textfield
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        DOBTextField.delegate  = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        /// Setup return key for textfield
        nameTextField.returnKeyType = .next
        
        
      
        /// Init UITapGesture
        let tapToCloseKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        /// Add tapGesture to the view so the keyboard will dismiss when user tap anywhere outside textfield
        view.addGestureRecognizer(tapToCloseKeyboard)
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                //self.view.frame.origin.y -= keyboardSize.height
//                let selectedTextField = view.selectedTextField
//                if selectedTextField.getname {
//
//                }
//                else {
                print ("self.scrollView.frame.origin.y - keyboardSize.height", self.scrollView.frame.origin.y - keyboardSize.height)
                if (self.scrollView.frame.origin.y - keyboardSize.height) > (-277) {
                self.scrollView.frame.origin.y -= keyboardSize.height + 40
                }
                else {
                     self.scrollView.frame.origin.y -= keyboardSize.height - 330
                }
               // }
                self.view.layoutIfNeeded()
                self.firstThreeTextFields = false
               // self.scrollView.layoutIfNeeded()
            })
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        scrollView.frame = view.bounds
//        containerView.frame = CGRect(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if needLayoutContent {
            let bounds = scrollView.bounds
            let contentSize = CGSize(width: bounds.width * 1, height: bounds.height * 2.9)
            scrollView.contentSize = contentSize
           // scrollView.contentOffset = CGPoint(bounds.width * 0.25, bounds.height * 0.25)
           // scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       //     scrollView.updateContentViewSize()
            needLayoutContent = false
            
        }
    }

    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    /// Setup views for AddContactVC
    func setupView() {
        
        view.addSubview(nameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(DOBTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(addPhoneNumberButton)
        view.addSubview(addEmailButton)
        view.addSubview(emailTextField)
        view.addSubview(addAddressButton)
        view.addSubview(saveButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        DOBTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addPhoneNumberButton.translatesAutoresizingMaskIntoConstraints = false
        addEmailButton.translatesAutoresizingMaskIntoConstraints = false
        addAddressButton.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 54, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
         lastNameTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 108, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
         DOBTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 162, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
        phoneNumberTextField.anchor( addPhoneNumberButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
        addPhoneNumberButton.anchor(DOBTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: saveButton.frame.height)
        addPhoneNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addEmailButton.topAnchor.constraintEqualToAnchor(anchor: phoneTextFieldsArray[phoneTextFieldsArray.count - 1].bottomAnchor , constant:12, identifier:"firstEmailConstraint").isActive = true
        addEmailButton.leftAnchor.constraintEqualToAnchor( anchor: view.leftAnchor , constant:12, identifier:"leftEmailButtonConstraint").isActive = true
        addEmailButton.rightAnchor.constraintEqualToAnchor( anchor: view.rightAnchor , constant:12, identifier:"rightEmailButtonConstraint").isActive = true

        
     //  emailTextField.bottomAnchor.constraintEqualToAnchor(anchor: phoneNumberTextField.topAnchor, constant: 40, identifier: "firstEmailBottom").isActive = true
        addEmailButton.leadingAnchor.constraintEqualToAnchor(anchor: phoneNumberTextField.leadingAnchor, constant: 0, identifier: "firstEmailLeading").isActive = true
        addEmailButton.trailingAnchor.constraintEqualToAnchor(anchor: phoneNumberTextField.trailingAnchor, constant: 0, identifier: "firstEmailTrailing").isActive = true
        addEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
         emailTextField.anchor( addEmailButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        addAddressButton.topAnchor.constraintEqualToAnchor(anchor: emailTextFieldsArray[emailTextFieldsArray.count - 1].bottomAnchor , constant:12, identifier:"firtAddressConstraint").isActive = true
        addAddressButton.leftAnchor.constraintEqualToAnchor( anchor: view.leftAnchor , constant:12, identifier:"leftAddressButtonConstraint").isActive = true
        addAddressButton.rightAnchor.constraintEqualToAnchor( anchor: view.rightAnchor , constant:12, identifier:"rightAddressButtonConstraint").isActive = true
        addAddressButton.leadingAnchor.constraintEqualToAnchor(anchor: emailTextField.leadingAnchor, constant: 0, identifier: "addressButtonLeading").isActive = true
        addAddressButton.trailingAnchor.constraintEqualToAnchor(anchor: emailTextField.trailingAnchor, constant: 0, identifier: "addressButtonTrailing").isActive = true
        addAddressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

//        emailTextField.anchor(phoneTextFieldsArray[phoneTextFieldsArray.count - 1].bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: CGFloat(add60ToContraint), leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 44)
        
        saveButton.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: CGFloat(originalTopConstraintForSaveButton), leftConstant: 0, bottomConstant: 14, rightConstant: 0, widthConstant: 200, heightConstant: saveButton.frame.height)
        saveButton.topAnchor.constraintEqualToAnchor(anchor: view.topAnchor, constant: CGFloat(originalTopConstraintForSaveButton), identifier: "topConstraintSaveButton").isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addToolbar(nil, textField: phoneNumberTextField, doneSelector: #selector(toolBarDoneTapped), cancelSelector: #selector(toolBarCancelTapped))
      
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
        }
    }
    
     // Add additional phone number
     @objc func addPhoneNumber() {
        scrollView.updateContentViewSize()
        if phoneCount < MAXPHONE {
            phoneCount += 1
            let additionalPhoneNumberTextField: UITextField = {
                let tf = UITextField()
                tf.placeholder = "Type phone number here"
                tf.keyboardType = .phonePad
                tf.borderStyle = .roundedRect
                tf.backgroundColor = .groupTableViewBackground
                return tf
            }()
           addPaddingToConstraint += 5
            if phoneCount == 3{
                addPaddingToConstraint += 52
            }
            phoneTextFieldsArray.append(additionalPhoneNumberTextField )
            view.addSubview(phoneTextFieldsArray.last!)
            phoneTextFieldsArray.last!.translatesAutoresizingMaskIntoConstraints = false
           // addEmailButton.translatesAutoresizingMaskIntoConstraints = false
            print("add60 to constraint", addPaddingToConstraint)
            originalTopConstraintForSaveButton += addPaddingToSaveButtonConstraint
            self.view.constraint(withIdentifier:"topConstraintSaveButton")?.constant = CGFloat(originalTopConstraintForSaveButton)
            additionalPhoneNumberTextField.anchor( phoneTextFieldsArray[phoneTextFieldsArray.count - 2].bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
            additionalPhoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.view.constraint(withIdentifier:"firstEmailConstraint")?.constant = CGFloat(addPaddingToConstraint)
            
        //addEmailButton.layoutIfNeeded()
//            view.callRecursively { subview, _ in
//                if let textField = subview as? UITextField {
//                    print(textField.text ?? "not available")
//                    for constraint in subview.constraints {
//                        print(constraint.constant)
//                    }
//                }
//            }
        }
    }
    
    // Add additional phone number
    @objc func addEmail() {
         scrollView.updateContentViewSize()
        if emailCount < MAXEMAIL {
            emailCount += 1
            let additionalEmailTextField: UITextField = {
                let tf = UITextField()
                tf.placeholder = "Type email here"
                tf.keyboardType = .default
                tf.borderStyle = .roundedRect
                tf.backgroundColor = .groupTableViewBackground
                return tf
            }()
            addAddressPaddingToConstraint += 5
            if emailCount == 3{
                addAddressPaddingToConstraint += 52
            }
            emailTextFieldsArray.append(additionalEmailTextField )
            view.addSubview(emailTextFieldsArray.last!)
            emailTextFieldsArray.last!.translatesAutoresizingMaskIntoConstraints = false
            originalTopConstraintForSaveButton += addPaddingToSaveButtonConstraint
            self.view.constraint(withIdentifier:"topConstraintSaveButton")?.constant = CGFloat(originalTopConstraintForSaveButton)
            //addEmailButton.translatesAutoresizingMaskIntoConstraints = false
            additionalEmailTextField.anchor( emailTextFieldsArray[emailTextFieldsArray.count - 2].bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
            additionalEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          //  addAddressButton.layoutIfNeeded()
//             addAddressButton.topAnchor.constraintEqualToAnchor(anchor: emailTextFieldsArray[emailTextFieldsArray.count - 1].bottomAnchor , constant:12, identifier:"firtAddressConstraint").isActive = true
             self.view.constraint(withIdentifier:"firtAddressConstraint")?.constant = CGFloat(addAddressPaddingToConstraint)
        }
    }
    
    @objc func addAddress() {
         scrollView.updateContentViewSize()
        if addressCount < MAXEMAIL {
            addressCount += 1
            let additionalAddressTextField: UITextField = {
                let tf = UITextField()
                tf.placeholder = "Type address here"
                tf.keyboardType = .default
                tf.borderStyle = .roundedRect
                tf.backgroundColor = .groupTableViewBackground
                return tf
            }()
            
            addressTextFieldsArray.append(additionalAddressTextField )
            view.addSubview(addressTextFieldsArray.last!)
            addressTextFieldsArray.last!.translatesAutoresizingMaskIntoConstraints = false
            addAddressButton.translatesAutoresizingMaskIntoConstraints = false
            originalTopConstraintForSaveButton += addPaddingToSaveButtonConstraint
            self.view.constraint(withIdentifier:"topConstraintSaveButton")?.constant = CGFloat(originalTopConstraintForSaveButton)
            additionalAddressTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            if addressCount == 1 {
                 additionalAddressTextField.anchor( addAddressButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
            }
            else {
            additionalAddressTextField.anchor( addressTextFieldsArray[addressTextFieldsArray.count - 2].bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
            }
        }
        
    }
    
    /// Save new contact to realm database
    @objc func saveToRealm() {
        print("savetorealm being called" )
        guard let nameField = nameTextField.text else { return }
        guard let lastNameField = lastNameTextField.text else { return }
        guard let phoneField = phoneNumberTextField.text else { return }
        guard let dobField = DOBTextField.text else { return }
        guard !nameField.isEmpty, !phoneField.isEmpty else { return }

        /// Check for the same name
        guard checkBeforeSave(name: nameField, phone: phoneField) else {
            DispatchQueue.main.async {
                self.reusableAlert(alertTitle: "Error", alertMessage: "\(nameField) already exist", viewController: self)
            }
            return
        }
        let newAddresses  = Addresses()
        let newEmails  = Emails()
        let newPhoneNumbers  = PhoneNumbers()
        
        newAddresses.addresses = extractTextFromTextFields(textFieldArray : addressTextFieldsArray)
       
        newEmails.emails = extractTextFromTextFields(textFieldArray : emailTextFieldsArray)
        newPhoneNumbers.phoneNumbers = extractTextFromTextFields(textFieldArray : phoneTextFieldsArray)
        //print("newphonenumbes ", newPhoneNumbers.phoneNumbers)
        /// Sava new contact to realm database
        
        let newContact =   ContactBook(name: nameField, lastName: lastNameField, dateOfBirth: dobField, addresses: newAddresses, phoneNumbers:  newPhoneNumbers , emails: newEmails)
        do {
            try realm.write {
                
                realm.add(newContact)
                nameTextField.text = ""
                phoneNumberTextField.text = ""
                lastNameTextField.text = ""
                DOBTextField.text = ""
                navigationController?.popViewController(animated: true)
            }
        } catch let error {
            print("Failed to add Contact", error)
        }
    }
    
    
    
    func extractTextFromTextFields(textFieldArray : [UITextField]) -> List<String>{
        let textArray : List<String> = List<String>()
        for textField in textFieldArray {
            textArray.append(textField.text!)
            //textField.text = "" // make textField Empty after reading it
        }
        return textArray
    }
    
    
    /// Check for the same name before save
    @objc func checkBeforeSave(name: String, phone: String) -> Bool {
        for savedContact in results {
            guard savedContact.name?.lowercased() == name.lowercased()  else { return true }
            print("\(savedContact.name!)'s already in your contact")
            return false
        }
        return true
    }
    
    
    
    /// Add custom toolbar to textfield
    fileprivate func addToolbar(_ textView: UITextView?, textField: UITextField?, doneSelector: Selector, cancelSelector: Selector) {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: doneSelector)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: cancelSelector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
        
        if let tf = textField {
            tf.inputAccessoryView = toolBar
        }
        
        if let tv = textView {
            tv.inputAccessoryView = toolBar
        }
    }
    
    
    
    /// dismissKeyboard
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    /// donePressed
    @objc fileprivate func toolBarDoneTapped() {
        view.endEditing(true)
    }
    
    
    
    /// cancelPressed
    @objc fileprivate func toolBarCancelTapped() {
        view.endEditing(true)
    }
    
}



extension UIView {
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
            })
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
}


// MARK: - UITextFieldDelegate
extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            phoneNumberTextField.becomeFirstResponder()
        default:
            break
        }
        return false
    }
}

