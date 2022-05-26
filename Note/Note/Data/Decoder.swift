import Foundation

class Decoder: DecoderType {
    func decode(_ data: Data, completion: ([NoteData]) -> Void) {
        var decodedData = [NoteData]()

        do {
            decodedData = try JSONDecoder().decode([NoteData].self, from: data)
        } catch {
            print(error.localizedDescription)
        }

        completion(decodedData)
    }
}
