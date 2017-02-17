module Utils exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (type_)
import Css exposing (Stylesheet)


withCss : Stylesheet -> Html msg -> Html msg
withCss stylesheet html =
    let
        compiledCss =
            Css.compile [ stylesheet ]
    in
        Html.div []
            [ Html.node "style"
                [ type_ "text/css" ]
                [ Html.text compiledCss.css ]
            , html
            ]
