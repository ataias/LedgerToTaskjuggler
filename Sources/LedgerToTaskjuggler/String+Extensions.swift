//
//  String+Extensions.swift
//  LedgerToTaskjuggler
//
//  Created by Ataias Pereira Reis on 01/09/20.
//

import Foundation

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
