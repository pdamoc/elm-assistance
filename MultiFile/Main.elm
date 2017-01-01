module Main exposing (..)

import Html
import Counter exposing (update, view, Msg)


main : Program Never Int Msg
main =
    Html.beginnerProgram
        { model = 0, update = update, view = view }
