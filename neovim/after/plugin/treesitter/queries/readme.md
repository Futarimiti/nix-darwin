# Custom queries

Normally these should go to something like `[after]/queries/xxx/highlights.scm`.
However with home manager, plugin directories are sourced before `~/.config/nvim`,
leaving no chance for user to override shipped queries, only extending them.
Any custom queries should be therefore made here.
