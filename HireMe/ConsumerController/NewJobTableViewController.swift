//
//  NewJobTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class NewJobTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var typeTextField: UITextField!
	@IBOutlet weak var timeStartTextField: UITextField!
	@IBOutlet weak var timeEndTextField: UITextField!
	@IBOutlet weak var priceLowerTextField: UITextField!
	@IBOutlet weak var priceUpperTextField: UITextField!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var stateTextField: UITextField!
	@IBOutlet weak var zipTextField: UITextField!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var imageCollectionView: UICollectionView!
	@IBOutlet weak var addPhotoButton: UIButton!
	@IBOutlet weak var timeFrameSwitch: UISwitch!
	@IBOutlet var datePicker: UIDatePicker!
	@IBOutlet var customPicker: UIPickerView!
	@IBOutlet weak var myLocationButton: UIButton!
	@IBOutlet weak var locationIndicator: UIActivityIndicatorView!

	var job: Job?
	var images: [UIImage] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		addPhotoButton.layer.cornerRadius = 5.0
		addPhotoButton.layer.borderColor = UIColor.black.cgColor
		addPhotoButton.layer.borderWidth = 0.2

		myLocationButton.layer.cornerRadius = 5.0
		myLocationButton.layer.borderColor = UIColor.black.cgColor
		myLocationButton.layer.borderWidth = 0.2

		locationIndicator.isHidden = true

		priceUpperTextField.delegate = self
		priceLowerTextField.delegate = self
		titleTextField.delegate = self
		timeStartTextField.delegate = self
		timeEndTextField.delegate = self
		stateTextField.delegate = self
		typeTextField.delegate = self
		cityTextField.delegate = self
		zipTextField.delegate = self

		timeStartTextField.inputView = datePicker
		timeEndTextField.inputView = datePicker
		typeTextField.inputView = customPicker
		stateTextField.inputView = customPicker

		datePicker.setDate(NSDate() as Date, animated: false)
		datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
		customPicker.delegate = self

		guard let job = job else { return }

		if job.timeFrameEnd != nil || job.timeFrameStart != nil {
			timeFrameSwitch.setOn(false, animated: false)
		} else {
			timeFrameSwitch.setOn(true, animated: false)
		}

		titleTextField.text = job.name
		typeTextField.text = job.industry
		timeStartTextField.text = job.timeFrameStart
		timeEndTextField.text = job.timeFrameEnd
		priceLowerTextField.text = job.priceRangeStart?.convertToCurrency(includeDollarSign: false)
		priceUpperTextField.text = job.priceRangeEnd?.convertToCurrency(includeDollarSign: false)
		descriptionTextView.text = job.description
		cityTextField.text = job.locationCity
		stateTextField.text = job.locationState
		zipTextField.text = job.locationZip

		if let images = job.images {
			self.images = images
			imageCollectionView.reloadData()
		}
	}

	func updateWith(job: Job) {
		self.job = job
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as? JobImageCell  else { return UICollectionViewCell() }
		cell.updateWith(image: images[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "ImageViewStoryboard", bundle: nil)
		if let vc = storyboard.instantiateViewController(withIdentifier: "LargeImageController") as? ViewPhotosViewController {
			vc.showImages(images: images, senderView: self, selfView: vc, selectedIndex: indexPath.row)
		}
	}

	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		guard let title = titleTextField.text,
			let priceLowerString = priceLowerTextField.text,
			let priceUpperString = priceUpperTextField.text,
			let priceLower = Double(priceLowerString),
			let priceUpper = Double(priceUpperString),
			title.characters.count > 0 else { AlertHelper.showAlert(view: self, title: "Error", message: "Must supply Title and Upper and Lower Price fields", closeButtonText: "OK"); return }

		if priceLower > priceUpper {
			AlertHelper.showAlert(view: self, title: "Error", message: "Lower Price Range must be less than or equal to Upper Price Range", closeButtonText: "Dismiss")
			return
		}

		if let timeStart = timeStartTextField.text,
			let timeEnd = timeEndTextField.text,
			let dateStart = timeStart.dateFromString(),
			let dateEnd = timeEnd.dateFromString(),
			timeStart.characters.count > 0,
			timeEnd.characters.count > 0,
			dateEnd < dateStart {
			AlertHelper.showAlert(view: self, title: "Error", message: "If including start and end date range, end date must be the same day or after start date.", closeButtonText: "Dismiss")
			return
		}

		if let job = job {
			if (!JobController.shared.updateJob(job: job, name: title, timeFrameStart: timeStartTextField.text, timeFrameEnd: timeEndTextField.text, priceRangeStart: priceLower, priceRangeEnd: priceUpper, industry: typeTextField.text, locationCity: cityTextField.text, locationState: stateTextField.text, locationZip: zipTextField.text, description: descriptionTextView.text, images: images.count > 0 ? images : nil)) {

			} else {
				_ = navigationController?.popViewController(animated: true)
			}
		} else {
			if (!JobController.shared.addJob(name: title, timeFrameStart: timeStartTextField.text, timeFrameEnd: timeEndTextField.text, priceRangeStart: priceLower, priceRangeEnd: priceUpper, industry: typeTextField.text, locationCity: cityTextField.text, locationState: stateTextField.text, locationZip: zipTextField.text, description: descriptionTextView.text, images: images.count > 0 ? images : nil)) {
				AlertHelper.showAlert(view: self, title: "Error Saving", message: "An error occured while attempting to save this job. Please try again.", closeButtonText: "Dismiss")
			} else {
				_ = navigationController?.popViewController(animated: true)
			}
		}
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
		images.append(image)
		dismiss(animated: true, completion: nil)
		imageCollectionView.reloadData()
		let indexPath = IndexPath(row: 0, section: 6)
		tableView.reloadRows(at: [indexPath], with: .top)
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if let text = textField.text,
			text.characters.count > 0,
			textField == priceLowerTextField || textField == priceUpperTextField {
			let price = Double(text)
			textField.text = price?.convertToCurrency(includeDollarSign: false)
		} else if let timeStart = timeStartTextField.text,
			let timeEnd = timeEndTextField.text,
			timeStart.characters.count == 0,
			timeEnd.characters.count == 0,
			textField == timeStartTextField || textField == timeEndTextField {
			timeFrameSwitch.setOn(true, animated: true)
		} else if textField == timeStartTextField,
			let text = timeStartTextField.text,
			text.characters.count > 0 {
			let date = text.dateFromString()
			if date == nil {
				textField.text = ""
			}
		} else if textField == timeEndTextField,
			let text = timeEndTextField.text,
			text.characters.count > 0 {
			let date = text.dateFromString()
			if date == nil {
				textField.text = ""
			}
		} else if textField == typeTextField,
			let text = typeTextField.text,
			text.characters.count > 0 {
			let index = AppInfo.industries.index(of: text)
			if index == nil {
				textField.text = ""
			}
		} else if textField == stateTextField,
			let text = stateTextField.text,
			text.characters.count > 0 {
			let index = AppInfo.states.index(of: text)
			if index == nil {
				textField.text = ""
			}
		} else if textField == zipTextField,
			let text = zipTextField.text,
			text.characters.count > 0 {
			let zip = Int(text)
			if zip == nil {
				textField.text = ""
			}
		} else if textField == cityTextField,
			let text = cityTextField.text,
			text.characters.count > 0 {
			if text.contains("'") ||
				text.contains(")") ||
				text.contains("(") ||
				text.contains("\"") {
				textField.text = ""
			}
		} else if textField == titleTextField,
			let text = titleTextField.text,
			text.characters.count > 0 {
			if text.contains("'") ||
				text.contains(")") ||
				text.contains("(") ||
				text.contains("\"") {
				textField.text = ""
			}
		}
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField == timeEndTextField || textField == timeStartTextField {
			timeFrameSwitch.setOn(false, animated: true)
		}

		datePicker.setDate(NSDate() as Date, animated: true)
		if textField == timeEndTextField {
			if let dateString = timeEndTextField.text,
				dateString.characters.count > 0 {
				setDatePickerFromDate(dateString: dateString)
			} else {
				timeEndTextField.text = datePicker.date.stringFromDate()
			}
		} else if textField == timeStartTextField {
			if let dateString = timeStartTextField.text,
				dateString.characters.count > 0 {
				setDatePickerFromDate(dateString: dateString)
			} else {
				timeStartTextField.text = datePicker.date.stringFromDate()
			}
		} else if textField == stateTextField || textField == typeTextField {
			customPicker.reloadComponent(0)
			if let stateText = stateTextField.text,
				textField == stateTextField {
				if let index = AppInfo.states.index(of: stateText) {
					customPicker.selectRow(index, inComponent: 0, animated: true)
				} else {
					customPicker.selectRow(0, inComponent: 0, animated: true)
					stateTextField.text = AppInfo.states[0]
				}
			} else if let industryText = typeTextField.text,
				textField == typeTextField {
				if let index = AppInfo.industries.index(of: industryText) {
					customPicker.selectRow(index, inComponent: 0, animated: true)
				} else {
					customPicker.selectRow(0, inComponent: 0, animated: true)
					typeTextField.text = AppInfo.industries[0]
				}
			}
		}
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if typeTextField.isEditing {
			return AppInfo.industries.count
		} else if stateTextField.isEditing {
			return AppInfo.states.count
		}
		return 0
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if typeTextField.isEditing {
			return AppInfo.industries[row]
		} else if stateTextField.isEditing {
			return AppInfo.states[row]
		}
		return ""
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if typeTextField.isEditing {
			typeTextField.text = AppInfo.industries[row]
		} else if stateTextField.isEditing {
			stateTextField.text = AppInfo.states[row]
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}


	func datePickerChanged() {
		if timeEndTextField.isEditing {
			timeEndTextField.text = datePicker.date.stringFromDate()
		} else if timeStartTextField.isEditing {
			timeStartTextField.text = datePicker.date.stringFromDate()
		}
	}

	func setDatePickerFromDate(dateString: String) {
		if let date = dateString.dateFromString() {
			datePicker.setDate(date, animated: true)
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 44
		} else if indexPath.section == 1 {
			return 44
		} else if indexPath.section == 2 {
			return 96
		} else if indexPath.section == 3 {
			return 44
		} else if indexPath.section == 4 {
			return 141
		} else if indexPath.section == 5 {
			return 125.0
		} else if indexPath.section == 6 {
			let height = imageCollectionView.collectionViewLayout.collectionViewContentSize.height
			return height < 50 ? 50 : height + 50
		}
		return 0
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}

	@IBAction func addPhotoButtonTapped(_ sender: UIButton) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self

		let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
			imagePicker.sourceType = .photoLibrary
			self.present(imagePicker, animated: true, completion: nil)
		}

		let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
			imagePicker.sourceType = .camera
			self.present(imagePicker, animated: true, completion: nil)
		}

		alert.addAction(cancelAction)
		alert.addAction(photoAction)
		alert.addAction(cameraAction)

		self.present(alert, animated: true, completion: nil)
	}

	@IBAction func timeFrameSwitchTapped(_ sender: UISwitch) {
		if sender.isOn {
			timeStartTextField.text = ""
			timeEndTextField.text = ""
			timeEndTextField.resignFirstResponder()
			timeStartTextField.resignFirstResponder()
		}
	}

	@IBAction func myLocationButtonTapped(_ sender: UIButton) {
		locationIndicator.isHidden = false
		if (!LocationHelper.shared.getCurrentLocation { (city, state, zip) in
			DispatchQueue.main.async {
				if let city = city {
					self.cityTextField.text = city
				}

				if let state = state {
					self.stateTextField.text = state
				}

				if let zip = zip {
					self.zipTextField.text = zip
				}
				self.locationIndicator.isHidden = true
			}
		}) {
			self.locationIndicator.isHidden = true
			let alert = UIAlertController (title: "Permission Denied", message: "You have declined permission to use your location. \n\nPlease go to Settings and grant location service permissions.", preferredStyle: .alert)

			let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
				guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }

				if UIApplication.shared.canOpenURL(settingsUrl) {
					UIApplication.shared.open(settingsUrl, completionHandler: nil)
				}
			}
			let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
			alert.addAction(cancelAction)
			alert.addAction(settingsAction)
			present(alert, animated: true, completion: nil)
		}
	}
}
