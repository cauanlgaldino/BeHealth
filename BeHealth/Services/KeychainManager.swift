//
//  KeychainManager.swift
//  Login
//
//  Created by honorio on 25/08/24.
//

import Foundation
import Security

class KeychainManager {
    func storeData (data: Data, forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    func deleteData(forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    func readData(forService service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true
        ]
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            print("Falha ao ler dados do Keychain")
            return nil
        }
        return item as? Data
    }
}
