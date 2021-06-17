-- Documentation for neuron.dhall: https://neuron.zettel.page/configuration
{ siteTitle = "@ilumin's Zettels"
, author = Some "@ilumin"
, siteBaseUrl = Some "https://ilumin.github.io/notes/"
-- List of color names: https://semantic-ui.com/usage/theming.html#sitewide-defaults
, theme = "black"
, editUrl = Some "https://github.com/ilumin/notes/edit/master/"
, plugins = ["neuronignore", "links", "tags", "uptree", "dirtree"]
}
