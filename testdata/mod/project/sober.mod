// the module of the app: its own packages are greet and json, the dep kv lives next to it
module "example.com/app"

dep "../kv"
alias stdjson "std/json"
