import ScoreCore

/// Enables CSS collection for `Button` nodes.
extension Button: CSSWalkable {
    /// Walks into the button's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Form` nodes.
extension Form: CSSWalkable {
    /// Walks into the form's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<input>` is a void element with no children.
extension Input: CSSWalkable {
    /// No-op; `Input` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Enables CSS collection for `Label` nodes.
extension Label: CSSWalkable {
    /// Walks into the label's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Select` nodes.
extension Select: CSSWalkable {
    /// Walks into the select element's child options.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Option` nodes.
extension Option: CSSWalkable {
    /// Walks into the option's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `OptionGroup` nodes.
extension OptionGroup: CSSWalkable {
    /// Walks into the option group's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<textarea>` content is a plain string, not a node tree.
extension TextArea: CSSWalkable {
    /// No-op; `TextArea` holds a string value rather than child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Enables CSS collection for `Fieldset` nodes.
extension Fieldset: CSSWalkable {
    /// Walks into the fieldset's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Legend` nodes.
extension Legend: CSSWalkable {
    /// Walks into the legend's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Output` nodes.
extension Output: CSSWalkable {
    /// Walks into the output element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `DataList` nodes.
extension DataList: CSSWalkable {
    /// Walks into the datalist's child option nodes.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<progress>` has no node children.
extension Progress: CSSWalkable {
    /// No-op; `Progress` carries numeric attributes only, not child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Leaf node — `<meter>` has no node children.
extension Meter: CSSWalkable {
    /// No-op; `Meter` carries numeric attributes only, not child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}
