//
//  DocumentPicker.swift
//  PrivateVault
//
//  Created by Emilio Peláez on 20/2/21.
//

import UIKit
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
	@EnvironmentObject private var appState: AppState
	@Environment(\.presentationMode) var presentationMode
	var selectDocuments: ([URL], Folder?) -> Void

	func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
		let viewController = UIDocumentPickerViewController(forOpeningContentTypes: .supportedTypes, asCopy: true)
		viewController.allowsMultipleSelection = true
		viewController.delegate = context.coordinator
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) { }
	
	func makeCoordinator() -> Coordinator { Coordinator(self) }

	class Coordinator: NSObject, UIDocumentPickerDelegate {
		var parent: DocumentPicker

		init(_ parent: DocumentPicker) {
			self.parent = parent
		}

		func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
			parent.selectDocuments(urls, parent.appState.currentFolder)
		}

		func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
}
