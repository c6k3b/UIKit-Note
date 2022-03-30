import Foundation

struct Note: Codable {
    var title = ""
    var body = ""
    
    func saveData() {
        if let data = try? JSONEncoder().encode(self) {
            print(data)
            UserDefaults.standard.set(data, forKey: "note")
        }
    }
    
    func loadData() {
        if let decodedData = UserDefaults.standard.object(forKey: "note") as? Data {
            if let data = try? JSONDecoder().decode(Note.self, from: decodedData) {
                print(data)
            }
        }
    }
}


