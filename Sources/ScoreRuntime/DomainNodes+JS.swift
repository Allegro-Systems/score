import ScoreCore

// MARK: - Layout Nodes

/// Enables JS event collection for `Stack` nodes.
extension Stack: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Main` nodes.
extension Main: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Section` nodes.
extension Section: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Article` nodes.
extension Article: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Header` nodes.
extension Header: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Footer` nodes.
extension Footer: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Aside` nodes.
extension Aside: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Navigation` nodes.
extension Navigation: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Group` nodes.
extension Group: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

// MARK: - Content Nodes

/// Enables JS event collection for `Heading` nodes.
extension Heading: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Paragraph` nodes.
extension Paragraph: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Text` nodes.
extension Text: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Strong` nodes.
extension Strong: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Emphasis` nodes.
extension Emphasis: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Small` nodes.
extension Small: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Mark` nodes.
extension Mark: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Code` nodes.
extension Code: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Preformatted` nodes.
extension Preformatted: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Blockquote` nodes.
extension Blockquote: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Address` nodes.
extension Address: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<hr>` has no children.
extension HorizontalRule: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Leaf node — `<br>` has no children.
extension LineBreak: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

// MARK: - Control Nodes

/// Enables JS event collection for `Button` nodes.
extension Button: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Form` nodes.
extension Form: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<input>` is a void element.
extension Input: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Enables JS event collection for `Label` nodes.
extension Label: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Select` nodes.
extension Select: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Option` nodes.
extension Option: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `OptionGroup` nodes.
extension OptionGroup: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<textarea>` holds a string value, not child nodes.
extension TextArea: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Enables JS event collection for `Fieldset` nodes.
extension Fieldset: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Legend` nodes.
extension Legend: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Output` nodes.
extension Output: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `DataList` nodes.
extension DataList: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<progress>` carries numeric attributes only.
extension Progress: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Leaf node — `<meter>` carries numeric attributes only.
extension Meter: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

// MARK: - Interactive Nodes

/// Enables JS event collection for `Link` nodes.
extension Link: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Dialog` nodes.
extension Dialog: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Menu` nodes.
extension Menu: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Summary` nodes.
extension Summary: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Details` nodes.
extension Details: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(summary, bindings: &bindings, index: &index)
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

// MARK: - Media Nodes

/// Leaf node — `<img>` is a void element.
extension Image: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Enables JS event collection for `Figure` nodes.
extension Figure: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `FigureCaption` nodes.
extension FigureCaption: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<source>` is a void element.
extension Source: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Leaf node — `<track>` is a void element.
extension Track: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}

/// Enables JS event collection for `Audio` nodes.
extension Audio: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Video` nodes.
extension Video: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Picture` nodes.
extension Picture: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `Canvas` nodes.
extension Canvas: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

// MARK: - List Nodes

/// Enables JS event collection for `UnorderedList` nodes.
extension UnorderedList: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `OrderedList` nodes.
extension OrderedList: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `ListItem` nodes.
extension ListItem: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `DescriptionList` nodes.
extension DescriptionList: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `DescriptionTerm` nodes.
extension DescriptionTerm: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `DescriptionDetails` nodes.
extension DescriptionDetails: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

// MARK: - Table Nodes

/// Enables JS event collection for `Table` nodes.
extension Table: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableCaption` nodes.
extension TableCaption: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableHead` nodes.
extension TableHead: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableBody` nodes.
extension TableBody: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableFooter` nodes.
extension TableFooter: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableRow` nodes.
extension TableRow: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableHeaderCell` nodes.
extension TableHeaderCell: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableCell` nodes.
extension TableCell: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Enables JS event collection for `TableColumnGroup` nodes.
extension TableColumnGroup: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {
        JSEmitter.extractEventsFromChild(content, bindings: &bindings, index: &index)
    }
}

/// Leaf node — `<col>` is a void element.
extension TableColumn: _JSWalkable {
    func walkChildrenForJS(bindings: inout [JSEmitter.EventBinding], index: inout Int) {}
}
