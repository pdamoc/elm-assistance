import Html.App as Html

import Counter exposing (update, view)

main : Program Never
main =
  Html.beginnerProgram
    { model = 0, update = update, view = view}
