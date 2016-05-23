$available = classes_from_namespace('wreckit::scenario')
$template  = "Available scenarios:

<% @available.each do |scenario| -%>
* <%= scenario %>
<% end -%>

"
notify { 'available':
  message => inline_template($template)
}