// Asset helpers for the template.
//
// MyST can render the template from different working directories. This helper
// keeps configured asset paths stable across local builds and packaged exports.

#let resolve_asset_path = (path, levels_up: 1) => {
  if path == none {
    none
  } else if type(path) != str {
    path
  } else {
    let normalized = str(path).replace("\\", "/")
    if normalized.starts-with("/") or normalized.starts-with("./") or normalized.starts-with("../") or normalized.contains(":/") {
      normalized
    } else if levels_up == 2 {
      "../../" + normalized
    } else if levels_up == 1 {
      "../" + normalized
    } else {
      normalized
    }
  }
}

#let resolve_logo_for_layout = (logo) => {
  resolve_asset_path(logo, levels_up: 2)
}
