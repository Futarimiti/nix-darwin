;; extends

(import_from_statement
  module_name: (dotted_name
    (identifier) @module)
  )


(import_statement
  name: (dotted_name
    (identifier) @module))

(import_statement
  name: (aliased_import
    name: (dotted_name
      (identifier) @module)
    alias: (identifier) @module))
