import XCTest
import SwiftUI
import AttributedStringBuilder

@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello, World!"
        .bold()
        .modify { $0.backgroundColor = .yellow }
    Array(repeating:
    """
    This is some markdown with **strong** `code` text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempus, tortor eu maximus gravida, ante diam fermentum magna, in gravida ex tellus ac purus.

    - One
    - Two
    - Three

    ```
    some code
    ```

    And a number list:

    1. One
    1. Two
    1. Three
    
    Checklist:
    
    - [ ] Unchecked item
    - [x] Checked item

    Another *paragraph*.

    > A blockquote.
    """.markdown() as any AttributedStringConvertible, count: 2)
    Table(rows: [
        .init(cells: [
            .init(borderColor: .green, borderWidth: .init(right: 2), contents: "Table Testing"),
            .init(contents: Embed {
                        Circle().fill(LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom))
                    .frame(width: 100, height: 100)
                } )
        ])
    ])
    .modify { $0.size = 10 }
    
//    NSImage(systemSymbolName: "hand.wave", accessibilityDescription: nil)!
    Embed {
        HStack {
            Image(systemName: "hand.wave")
                .font(.largeTitle)
            Text("Hello from SwiftUI")
            Color.red.frame(width: 100, height: 50)
        }
    }
}

let sampleAttributes = Attributes(family: "Georgia", size: 16, textColor: .black, paragraphSpacing: 10)


class Tests: XCTestCase {
    func testPDF() async {
        let data = await example
            .joined(separator: "\n")
            .run(environment: .init(attributes: sampleAttributes))
            .pdf()
        try! data.write(to: .desktopDirectory.appending(component: "out.pdf"))

    }
}
