import Fluent
import Vapor
// Data Transfer Object x86 Intel/AMD buildx
struct TodoDTO: Content {
    var id: UUID?
    var title: String?
    
    func toModel() -> Todo {
        let model = Todo()
        
        model.id = self.id
        if let title = self.title {
            model.title = title
        }
        return model
    }
}
